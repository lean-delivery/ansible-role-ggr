ggr role
=========
[![License](https://img.shields.io/badge/license-Apache-green.svg?style=flat)](https://raw.githubusercontent.com/lean-delivery/ansible-role-ggr/master/LICENSE)
[![Build Status](https://travis-ci.org/lean-delivery/ansible-role-ggr.svg?branch=master)](https://travis-ci.org/lean-delivery/ansible-role-ggr)
[![Build Status](https://gitlab.com/lean-delivery/ansible-role-ggr/badges/master/pipeline.svg)](https://gitlab.com/lean-delivery/ansible-role-ggr/pipelines)
[![Galaxy](https://img.shields.io/badge/galaxy-lean__delivery.ggr-blue.svg)](https://galaxy.ansible.com/lean_delivery/ggr)
![Ansible](https://img.shields.io/ansible/role/d/42600.svg)
![Ansible](https://img.shields.io/badge/dynamic/json.svg?label=min_ansible_version&url=https%3A%2F%2Fgalaxy.ansible.com%2Fapi%2Fv1%2Froles%2F42600%2F&query=$.min_ansible_version)

Set up [Go Grid Router](https://aerokube.com/ggr/latest/)

Requirements
------------

- **Supported OS**:
  - CentOS
    - 7
  - Ubuntu
    - 16.04, 18.04
  - Debian
    - 9
  - Amazon
    - All

Role Variables
--------------

- `selenoid_port`  
  default: `4444`
- `home_ggr`  
  default: `/home/ggr`
- `ggr_components`  
  default: 
  ```yaml
  ggr_components:
    - go-grid-router
    - go-grid-router/quota
    - selenoid-ui
  ```
 
- `ggr_config`  
  default: `- ggr-config-consul-template.tpl`
- `ggr_start_script_path`  
  default: `/etc/systemd/system/`
- `ggr_user`  
  default: `ggr`

- `ggt_init_script`  
  default:
  ```yaml
  ggt_init_script:
    - ggr.service
    - ggr-ui.service
    - selenoid-ui.service
  ```
- `ggr_version`  
  default: `1.6.5`
- `ggr_ui_version`  
  default: `1.1.2`
- `ggr_selenoid_ui_version`  
  default: `1.9.0`

Dependencies
------------

[![Ansible Galaxy](https://img.shields.io/badge/galaxy-brianshumate.consul-blue.svg)](https://galaxy.ansible.com/brianshumate/consul/)
[![Build Status](https://travis-ci.org/brianshumate/ansible-consul.svg?branch=master)](https://travis-ci.org/brianshumate/ansible-consul)

 Consul role usage example
 ```yaml
 - name: Install Consul
   hosts: consul_instances
   become: true
   roles:
    - role: brianshumate.consul
      consul_group_name: consul_instances
      consul_raw_key: ''
 ```

Example Playbook
----------------

```yaml
---
- name: Install GGR
  hosts: consul_instances
  become: true
  roles:
    - role: lean_delivery.ggr
  tasks:
    - name: Configure Go Grid Router quota
      copy:
        src: '../resources/files/ggr-config-example.xml'
        dest: /home/ggr/go-grid-router/quota
        mode: 0664
        owner: ggr
        group: ggr
```

License
-------
Apache

Author Information
------------------

authors:
  - Lean Delivery Team <team@lean-delivery.com>
