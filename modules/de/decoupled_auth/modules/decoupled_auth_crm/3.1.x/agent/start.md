<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple CRM (decoupled_auth_crm) — agent index

Submodule of **Decoupled User Authentication** (`decoupled_auth`). A config-only "starter CRM": it has
**no PHP logic** — `decoupled_auth_crm.module` is an empty stub. Package **Tool**. Core `^10 || ^11`.
License GPL-2.0-or-later. Version **3.1.5** (packaged with the parent project).

## What it does

- **Dependencies as a bundle** (`decoupled_auth_crm.info.yml`): `decoupled_auth`, `user`, `profile`,
  `address`, `datetime`, `options`, `image` — so decoupled (login-less) users can carry rich contact
  data via Profile + Address fields.
- **One optional view** (`config/optional/views.view.simple_crm_users.yml`): id `simple_crm_users`,
  label "Simple CRM Users", base table `users_field_data`, access by the **`access user profiles`**
  permission, cache type `tag`. Installed only if Views is enabled and its dependencies are met.

No routes, services, permissions, hooks, config schema, or Drush of its own — all behaviour comes from
the parent module and the listed dependencies. See the parent docs at
`modules/de/decoupled_auth/3.1.x/agent/start.md` for the entity model, acquisition API and settings.

## Install

`drush en decoupled_auth_crm` (enables the parent + Profile/Address/etc.). The `simple_crm_users` view
is optional config — import or re-create it if it does not appear.
