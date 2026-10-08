# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`). The project
  README also asks for a very recent PHP release, so check your PHP version before
  installing.
- **Core module dependencies**, all in Drupal core and enabled automatically:
  Field, File, Filter, Image, Link, Options, User, Taxonomy, Text and Views.
- **Third‑party PHP libraries**, pulled in by Composer: `aws/aws-sdk-php`,
  `maclof/kubernetes-client`, `google/apiclient`, and the `drupal/geocoder`
  module (with a Nominatim provider). Which of these you actually need depends on
  the provider submodules you enable.
- A **Cloudflare account is not required**, but you *will* need credentials for
  whichever clouds you connect (AWS, Kubernetes, OpenStack, VMware, etc.).

## Recommended: start from the distribution

For a fresh site the maintainers recommend the ready‑made **Cloud Orchestrator**
distribution, which wires up the framework and common providers for you:

```bash
composer create-project docomoinnovations/cloud_orchestrator cloud_orchestrator
```

## Install this module with Composer

To add the Cloud framework to an existing site instead:

```bash
composer require drupal/cloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
dependencies (and pull the PHP libraries above) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloud -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the framework and a provider

Enable the base framework plus the provider submodule(s) for the clouds you
manage:

```bash
drush en cloud -y
# then one or more providers, for example:
drush en aws_cloud -y
```

## Submodules

Cloud is deliberately modular. Enable only the pieces you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AWS Cloud** | `aws_cloud` | Amazon EC2 dashboard, launch templates, pricing/cost views, IAM assume/switch role. |
| **Kubernetes** | `k8s` | Manage one or more K8s clusters, namespaces‑as‑projects, pod/deployment launch templates, cost and node views. |
| **OpenStack** | `openstack` | Manage OpenStack via its REST and EC2‑compatible APIs (images, instances, networks, volumes, stacks, and more). |
| **VMware** | `vmware` | Manage VMware VMs and hosts. |
| **Docker** | `docker` | Docker resource management. |
| **Terraform** | `terraform` | Manage Terraform Cloud workspaces, runs, states and variables. |
| **Cloud Dashboard** | `cloud_dashboard` | The consolidated multi‑cloud dashboard view. |
| **Cloud Budget** | `cloud_budget` | Budgeting/cost‑awareness features. |
| **Cloud Project** | (bundled) | Group resources into projects. |
| **Cloud Cluster / Worker** | `cloud_cluster`, `cloud_cluster_worker` | Cluster support and background workers. |
| **Google Apps / Tools** | `gapps`, `tools` | Google integration and utilities such as k8s↔S3 helpers. |

## Verify it worked

Log in as an administrator and visit **Structure → Cloud service providers**. If
you see the "Add cloud service provider" action, the framework is installed.
Next, grant the Cloud permissions to the right roles and add your first provider —
see [Configuration](../configuration/index.md).
