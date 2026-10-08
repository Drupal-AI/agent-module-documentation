# SODa SCS manager — manual setup guide

**SODa SCS manager** (`soda_scs_manager`) is a self-service platform for
provisioning and operating containerised research applications — WissKI,
JupyterHub, Nextcloud, SQL databases, triplestores and WebProtégé — managed as
Drupal entities. Researchers can spin up, snapshot and tear down their own
application stacks from within the site, while administrators control the
underlying infrastructure. It runs on Drupal 10 and 11.

It models the world as **Stacks, Components, Snapshots, Service Keys and
Projects**, each a custom content entity with its own listing, add/edit/delete
forms and canonical page. Behind those entities, a family of "action" services
talks to the infrastructure: a Portainer/Docker API (creating, running and
executing containers, managing volumes and a registry), a Keycloak realm (users,
groups, clients), a Nextcloud instance (connecting via Login-Flow-v2 and mounting
storage), and an OpenGDB triplestore. Users register through a Keycloak-backed
form that queues a pending record for admin approval, and core's own login and
password routes are disabled in favour of OpenID Connect. Snapshots provide
backup and restore of stack data, and various health-check, progress-polling and
service-link controllers support the dashboard experience.

This is a substantial module with real dependencies and real infrastructure
behind it. It depends on core's **Language** module, **OpenID Connect**, **SMTP**,
**Field Group**, and a required companion theme (`soda_scs_manager_theme`). It
requires several external services to be running and reachable — Portainer/Docker,
Keycloak, Nextcloud and a triplestore — which you configure with endpoints and
credentials. Access is layered: almost every route requires the **soda scs
manager user** permission (with owner-scoped checks limiting edit, delete,
snapshot and service-link actions to the resource's owner), while destructive or
global operations — settings, service keys, automated updates, debug tools —
require **soda scs manager admin**.

A security note to carry into setup: this module orchestrates Docker exec and run
operations against a configured Portainer endpoint. Those routes are all
permission-gated to owners and admins, and a review found no disabled TLS and no
hardcoded secrets — but the Portainer token and the Keycloak and Nextcloud
credentials are high-value secrets and should be treated as such.

This guide is written for a **human** setting the platform up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — connecting Portainer, Keycloak,
   Nextcloud and the triplestore, and the permission model.

## Where it lives in the admin menu

The settings form is at **Configuration → SODa SCS manager → Settings**
(`/admin/config/soda-scs-manager/settings`), behind the **soda scs manager
admin** permission. Pending user registrations are approved at
`/admin/people/keycloak-registrations` (requires *administer users*), and admin
debug tools live under `/soda-scs-manager/debug`.
