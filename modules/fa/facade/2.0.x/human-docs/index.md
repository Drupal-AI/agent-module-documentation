# Façade — manual setup guide

**Façade** (`facade`) is a framework for managing multi‑tenant Drupal
deployments — provisioning and running many separate Drupal sites or environments
from one central control site. It gives you a **Tenant** content entity and a
**Tenant type** configuration entity to model each managed site, plus a
"launch‑tenant" plugin system so that creating, editing, or deleting a tenant can
trigger real work against an external cloud orchestrator.

Façade itself is provider‑agnostic: it defines the tenant data model and the
lifecycle hooks, and leaves the actual deployment to a launch plugin you (or a
provider module) supply. The reference implementation drives an OpenStack‑based
Cloud Orchestrator on Amazon EC2/CloudFormation through the contrib
[Cloud](https://www.drupal.org/project/cloud) module, which is why Façade depends
on `cloud`. Access is permission‑driven, with separate permissions for adding,
viewing, editing, deleting, and administering tenant entities (plus per‑bundle
permissions generated automatically for each Tenant type).

An optional submodule, **Façade Remote Worker** (`facade_remote_worker`), lets
remote worker machines authenticate back to the control site with a bearer token
and fetch their own configuration over REST. Because that bearer token is a
credential, treat it like any other secret — issue one per worker, store it
carefully, and rotate it if it may have been exposed.

This is an advanced, infrastructure‑oriented module intended for teams building a
multi‑site or hosting‑style platform, not a drop‑in site feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Façade (and Cloud) with
   Composer, enable it, and optionally enable the remote‑worker submodule.
2. [Configuration](configuration/index.md) — the framework settings form and the
   tenant/permission setup.

## Where it lives in the admin menu

Façade's settings form sits at **Configuration → Web services → Façade**
(`/admin/config/services/facade`) and requires the **Administer site
configuration** permission. Tenants themselves are managed through their own
entity list and add/edit forms once you have defined a Tenant type.
