# Cloud — manual setup guide

**Cloud** (`cloud`), also known as *Cloud Orchestrator*, turns Drupal into a
multi‑cloud management dashboard — think of an AWS‑Management‑Console‑style
control panel that also reaches into Kubernetes, OpenStack, VMware, Docker and
Terraform Cloud, all governed by Drupal's own permission system. This base module
is the **core framework**: it provides the entity model, permissions and plugin
managers that the individual provider submodules build on. You enable `cloud`
plus one or more provider submodules for the clouds you actually run.

The problem it solves is governance and cost control across several clouds from
one place. Depending on the providers you enable, it can show resource
dashboards, launch instances from approval‑gated launch templates, tag and
budget resources, flag long‑running or under‑utilised instances, manage
Kubernetes namespaces and costs, drive OpenStack REST APIs, and manage VMware VMs
or Terraform workspaces. Because every provider is a Drupal plugin, the whole
system is highly modular.

Cloud depends on a number of core modules (Field, File, Filter, Image, Link,
Options, User, Taxonomy, Text and Views) and pulls in several third‑party PHP
libraries via Composer — the AWS SDK, a Kubernetes client, the Google API client
and the Geocoder module. It needs a recent stack: **Drupal 10.6 or 11** (the
project README also calls for a very recent PHP). Provider credentials (AWS keys
or IAM roles, kubeconfig/tokens, OpenStack and VMware logins) are stored on each
*cloud service provider* entity you create.

The provider submodules are the heart of the system: **aws_cloud**, **k8s**,
**openstack**, **vmware**, **docker** and **terraform**, plus supporting modules
such as **cloud_dashboard**, **cloud_budget**, **cloud_project**,
**cloud_cluster** / **cloud_cluster_worker**, **gapps** and **tools**. For a
brand‑new site the maintainers recommend starting from the *Cloud Orchestrator*
distribution rather than assembling everything by hand.

> **Security note.** Cloud's provider integrations connect to powerful external
> APIs and store credentials on the provider entity. The public agent docs flag a
> few things to review before exposing a site: the `/health_check` route accepts a
> username/password in its POST body and can act as an unauthenticated
> credential‑check oracle; the geocoder and some dashboard config routes are
> reachable anonymously; and the k8s and VMware provider services have been
> observed disabling TLS certificate verification. Treat this as an admin‑only
> tool behind proper access control, and review those areas for your deployment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the framework and the provider
   submodules you need with Composer, and enable them.
2. [Configuration](configuration/index.md) — the settings form, adding a cloud
   service provider, and the launch workflow.

## Where it lives in the admin menu

The framework's own settings form is at **Configuration → Web services → Cloud →
Settings** (`/admin/config/services/cloud/settings`), which requires the
**Administer cloud** permission. You add and manage the clouds themselves under
**Structure → Cloud service providers**.
