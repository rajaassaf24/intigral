#!/usr/bin/env python3
"""
Dynamic inventory generated from terraform ouput.

See also: https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html
"""

import argparse
import json
import sys

from itertools import groupby

TERRAFORM_DB = 'terraform.tfstate'
HOST_VAR_PREFIX = 'host_var_'
GROUP_VAR_PREFIX = 'group_var_'


def parse_args(args):
    parser = argparse.ArgumentParser(
        description='A dynamic inventory that uses terraform outputs')

    group = parser.add_mutually_exclusive_group()
    group.add_argument('--list', action='store_true',
                       help='Generate the inventory.')
    group.add_argument('--host', action='store',
                       help='Generate an empty JSON object.')
    return parser.parse_args(args)


def main(args):

    with open(TERRAFORM_DB) as f:
        output = f.read()

    data = json.loads(output)['modules'][0]['outputs']['wordpress']['value']

    inventory = {
        '_meta': {'hostvars': {}}
    }

    for group, grouper in groupby(data, lambda elem: elem.get('group')):

        for vars_dict in grouper:

            meta = get_meta(vars_dict)
            inventory['_meta']['hostvars'].update(meta)

            group_vars = get_group_vars(vars_dict)

            if group in inventory:
                inventory[group] = inventory[group].update(group_vars)
            else:
                inventory[group] = group_vars

    if args.list is True:
        return json.dumps(inventory)
    else:
        # --host not supported
        return json.dumps({})


def get_meta(vars_dict):
    out = {}

    host = vars_dict['host']
    out[host] = {}

    for k, v in vars_dict.items():
        if k.startswith(HOST_VAR_PREFIX):
            out[host][k.replace(HOST_VAR_PREFIX, '')] = v
    return out


def get_group_vars(vars_dict):
    out = {'hosts': [], 'vars': {}}
    for k, v in vars_dict.items():
        if k.startswith(GROUP_VAR_PREFIX):
            out['vars'][k.replace(GROUP_VAR_PREFIX, '')] = v
        elif k == 'host':
            out['hosts'].append(v)
    return out


if __name__ == '__main__':
    args = parse_args(sys.argv[1:])
    sys.stdout.write(main(args))
