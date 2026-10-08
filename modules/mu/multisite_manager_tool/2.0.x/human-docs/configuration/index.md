# Configuration

Multisite Manager Tool has no separate "settings" screen to fill in — instead it
gives you one **management page** where you carry out the cross‑site tasks. This
page describes that page, what each action does, and the access considerations
that come with it.

## Open the management page

1. Log in as an administrator who holds the module's permission.
2. Go to **Configuration → System → Multisite Manager**, or navigate directly to
   `/admin/config/system/multisite-manager`.

## Who should have access

The module provides its own permission, and it is a **high‑privilege** one.
Actions taken here can affect **several sites at once** and can create databases,
so grant the permission **only to fully trusted administrators** at **People →
Permissions**. Treat this the way you would treat shell access to the server:
cross‑site management concentrates risk in one place.

## What you can do on the page

- **Detect and list active sites** — the page enumerates the sites in your
  multisite installation so you have a single overview.
- **Clear caches** — flush the cache for **one specific site**, or for **all
  sites at the same time**, without switching shells.
- **Create a new site** — generate the site's directory, its settings file, and
  (if needed) its database. This last step only works when the configured
  database user has permission to **create databases**; confirm that first.
- **Register headless URLs** — for each site you can record both a **backend**
  URL and a **frontend** URL, which supports headless/decoupled projects.

## Site definitions as configuration

Each site is stored as a **configuration entity**, which has two practical
consequences:

- Site definitions are **exportable** with the rest of your configuration, so
  they travel through your normal config workflow.
- They are exposed through **JSON:API**, so a decoupled front end can discover
  the available sites programmatically.

If you install the tool onto a multisite that already has sites, the
**reconciliation** step registers those existing sites as configuration entities
for you, so the list is populated without manual entry.
