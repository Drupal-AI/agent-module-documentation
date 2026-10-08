<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RedHen CRM (redhen) — agent index

Native Drupal CRM framework. Constituents are **Drupal content entities**, not a remote CRM.
Version **3.0.0-alpha1** (alpha). Core `^10 || ^11`. Composer dep: `drupal/entity ^1.4`.

## What is actually in this release

The top-level `redhen` module is thin: a dashboard route (`/redhen`), an admin settings form
(`/admin/config/redhen/general`, one setting: `redhen_admin_path`), a toolbar item, the
`redhen.active` / `redhen.inactive` events, and the helper `redhen_get_entity_from_route()`. All CRM
functionality is in submodules. **This 3.0.x line ships only these four submodules** — the
membership / note / engagement / groups submodules referenced in older README text and around the
web are **not present here**:

- `redhen_contact` — the **Contact** entity (`redhen_contact`, bundle = `redhen_contact_type`).
- `redhen_org` — the **Organization** entity (`redhen_org`, bundle = `redhen_org_type`).
- `redhen_connection` — the **Connection** entity (`redhen_connection`) + Connection Type,
  Connection Role, and a connection-role-based access-delegation layer.
- `redhen_dedupe` — find-duplicate-contacts + merge tool.

## The entity model in one screen

- **Contact** base fields: `first_name`, `middle_name`, `last_name`, `email` (unique, validated via
  the `ContactEmailUnique` constraint), `status` (active/inactive boolean), `uid` (nullable
  entity_reference to a Drupal user), `created`, `changed`. Label = full name. `getOwnerId()` returns
  the linked user id. Static loaders: `Contact::loadByUser($account)`, `Contact::loadByMail($email)`.
- **Organization** base fields: `name` (label), `status`, `created`, `changed`.
- **Connection**: entity with two endpoint reference fields (`endpoint_1`, `endpoint_2`) plus a
  `role` reference to a **Connection Role** config entity; typed by **Connection Type** which pins
  which entity types/bundles each endpoint may reference. Status active/inactive.
- All three are fieldable, revisionable, Views-integrable content entities.

## Access model (read this before assuming anything is public)

Access is **permission-driven and active/inactive-aware**, implemented in per-entity
`*AccessControlHandler` classes. Nothing here is anonymous by default. See
[access/access-model.md](access/access-model.md) for the full permission matrix and the Connection
Role delegation path. Key facts:
- Viewing an **active** contact needs `view active contact entities` (or `view active <bundle>
  contact`, or — for one's own linked contact — `view own <bundle> contact`).
- Viewing an **inactive** contact needs the separate `view inactive contact entities` /
  `view inactive <bundle> contact`.
- Org and Connection follow the same active/inactive split (no per-record "own" concept for Org).
- `redhen_connection` also adds `hook_entity_access` that can **grant** (never deny) access to an
  entity when the current user's Contact is connected to it under a Connection Role whose
  `permissions` include that operation.

## Doc map

- [entities/data-model.md](entities/data-model.md) — Contact / Org / Connection / Connection Role /
  Connection Type, base fields, routes, user-linking behavior, dedupe.
- [access/access-model.md](access/access-model.md) — every permission, the access handlers, the
  Connection-Role delegation mechanism, and the config that affects routing.
- [submodules/submodules.md](submodules/submodules.md) — per-submodule reference (contact, org,
  connection, dedupe), services, plugin type, hooks, drush.

## Framing (when the "which CRM" question comes up)

- **CiviCRM** — full CRM, its own data model + upgrade cycle; fundraising, membership lifecycle,
  event registration, reporting out of the box.
- **RedHen** — contacts/orgs/connections are Drupal entities: fields, view modes, Views, entity
  access, revisions. Composable, no second system to learn — but you build the CRM features
  yourself, and in this alpha you do not even get the old membership/note/engagement submodules.

**A CRM holds the most sensitive data a small org owns.** Entity access must be designed, not
inherited; deletion/anonymisation should exist before the first import.
