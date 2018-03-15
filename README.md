# cookbook_keepalived_ec2vpc Cookbook

A cookook for using keepalived in EC2-VPC environment.

## Requirements

TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
### Platforms

- Amazon Linux

### Chef

- Chef 12.0 or later

### Cookbooks

- `keepalived` - keepalived-ec2 needs keepalived cookook.

## Attributes

TODO: List your cookbook attributes here.

e.g.
### keepalived-ec2::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['bag_name']</tt></td>
    <td>String</td>
    <td>bag_name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['item_name']</tt></td>
    <td>String</td>
    <td>item_name</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['chk_script']</tt></td>
    <td>String</td>
    <td>vrrp_script</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['eni']</tt></td>
    <td>String</td>
    <td>eni</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['device_index']</tt></td>
    <td>String</td>
    <td>device_index</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['interface']</tt></td>
    <td>String</td>
    <td>interface</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['state']</tt></td>
    <td>String</td>
    <td>MASTER or BACKUP</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['virtual_router_id']</tt></td>
    <td>String</td>
    <td>virtual_router_id</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['unicast_src_ip']</tt></td>
    <td>String</td>
    <td>unicast_src_ip</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['keepalived-ec2']['unicast_peer']</tt></td>
    <td>String</td>
    <td>unicast_peer</td>
    <td><tt></tt></td>
  </tr>
</table>

## Usage

### keepalived-ec2::default

TODO: Write usage instructions for each cookbook.

e.g.
Just include `keepalived-ec2` in your node's `run_list`:

#### MASTER
```json
{
  "name":"master_node",
  "run_list": [
    "recipe[keepalived-ec2]"
  ],
  "keepalived-ec2" :{
    "bag_name": "bag_name",
    "item_name": "item_name",
    "chk_script": "pidof haproxy",
    "eni": "eni-xxxxxxxx",
    "device_index": "2",
    "interface": "eth1",
    "state": "MASTER",
    "virtual_router_id": "51",
    "unicast_src_ip": "10.0.0.110",
    "unicast_peer": "10.0.0.210"
  },
}
```

#### BACKUP
```json
{
  "name":"backup_node",
  "run_list": [
    "recipe[keepalived-ec2]"
  ],
  "keepalived-ec2" :{
    "bag_name": "bag_name",
    "item_name": "item_name",
    "chk_script": "pidof haproxy",
    "eni": "eni-xxxxxxxx",
    "device_index": "2",
    "interface": "eth1",
    "state": "BACKUP",
    "virtual_router_id": "51",
    "unicast_src_ip": "10.0.0.210",
    "unicast_peer": "10.0.0.110"
  },
}
```

## Contributing

TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: TODO: List authors
