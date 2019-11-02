# Version Control Application

More than just a Source Version Control. It is more a DevOps integrated tool.
- https://verctl.maduma.org

## GitLab Community Edition

- Deploy on Azure Container Instance
- Persistance is done using Azure File Share
- Configuration is passed using Environment Variable

## Azure Setup

- Create a resource group (verctl)
- Create a storage account
- Create a file share
```
$ bash azure-up.sh
$ bash azure-down.sh
```

## Application wrapper script
```
$ bash verctl.sh
Usage: verctl.sh status|start|stop|backup|restore
```

## gitlab.rg configuration file

- See https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template
