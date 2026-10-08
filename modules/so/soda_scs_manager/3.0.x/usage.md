<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SODa SCS manager is a self-service platform for provisioning and operating containerised research applications (WissKI, JupyterHub, Nextcloud, SQL databases, triplestores, WebProtégé) as Drupal entities.

---

It models the world as Stacks, Components, Snapshots, Service Keys and Projects — each a custom content entity with its own collection, add/edit/delete forms and canonical page. Behind the entities, `*ComponentActions`, `*StackActions`, `*RequestActions` and `*ServiceActions` services talk to a Portainer/Docker API (create/run/exec/volumes/registry), a Keycloak realm (users, groups, clients), a Nextcloud instance (Login-Flow-v2 connect + mounts), and an OpenGDB triplestore. Users register through a Keycloak-backed registration form that queues a pending record for admin approval; core's login/password routes are disabled by a route subscriber in favour of OIDC. Health-check, progress-polling, service-link and package-inspection controllers support the dashboard UX. Snapshots provide backup/restore of stack data.

Access is layered: almost every route requires the `soda scs manager user` permission (owning-entity checks via custom access handlers restrict edit/delete/snapshot/service-link to the resource owner), while destructive/global operations (settings, service keys, automated updates, debug tools, Drupal-package inspection) require `soda scs manager admin`. Service Keys are stored as entities and the SODa theme submodule is required. Configure connection endpoints and credentials at `/admin/config/soda-scs-manager/settings`. Note: this module orchestrates Docker exec/run against a configured Portainer endpoint — all such routes are permission-gated to owners/admins, but operators should treat the Portainer token and Keycloak/Nextcloud credentials as high-value secrets.
---
- Let researchers self-provision a WissKI stack
- Spin up a JupyterHub environment as a Stack entity
- Provision a Nextcloud instance and mount it
- Create SQL-database or triplestore components on demand
- Snapshot a stack or component for backup
- Restore a stack from a snapshot
- Run automated updates across all components (admin)
- Inspect installed Drupal packages inside a component container
- Check a component's health status
- Poll long-running operations for progress steps
- Manage Service Keys for applications and external services
- Group resources under collaborative Projects with memberships
- Invite users to a project and handle notifications
- Register new users through Keycloak with admin approval
- Approve or reject pending Keycloak registrations (administer users)
- Generate external service links to a running container
- Connect a Nextcloud account via Login Flow v2
- Configure Portainer, Keycloak, Nextcloud and triplestore endpoints
- Restrict edit/delete of a component to its owner
- Leave a project you were invited to
- Renew or delete a service key
- Report an issue through the built-in form
- Run snapshot integrity debug tools (admin)
- Disable core login in favour of OIDC-only authentication
- Set a component's package environment
