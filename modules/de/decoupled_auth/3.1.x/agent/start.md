<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled User Authentication (decoupled_auth) — agent index

Lets `user` entities exist without a username/password ("decoupled" users) so people can be stored as
Drupal users without a login. Swaps the core user class for `DecoupledAuthUser`, makes `name` nullable,
and relaxes the name/mail required + unique constraints. Package **Tool**. Depends only on core
**`user`** (Profile/Address are soft integrations, pulled via composer for the CRM submodule). Core
`^10 || ^11`. Version **3.1.5**. License GPL-2.0-or-later.

## What it provides

- **Entity override** — `hook_entity_type_build()` + `hook_install()` set the user class to
  `Drupal\decoupled_auth\Entity\DecoupledAuthUser` and storage-schema handler to
  `DecoupledAuthUserStorageSchema` (makes `users_field_data.name` NULL-able). See
  [api/entity-model.md](api/entity-model.md).
- **Acquisition service** — `decoupled_auth.acquisition` (`AcquisitionService`), the find-or-create
  API, plus `AcquisitionEvent::PRE` / `::POST` events. See [api/acquisition.md](api/acquisition.md).
- **Config + settings form** — `decoupled_auth.settings` config object, form at
  `admin/config/people/decoupled-auth` (route `decoupled_auth.settings`,
  `_permission: 'administer account settings'`). See [config/settings.md](config/settings.md).
- **Validation constraints** — `DecoupledAuthUserName`, `DecoupledAuthUserMailRequired`,
  `DecoupledAuthUserMailUnique` (per-role unique-email modes). See [api/entity-model.md](api/entity-model.md).
- **Views** — `user_decoupled` field + filter ("Has web account?"), auto-added to `user_admin_people`.
- **Field formatter** — `DecoupledUserNameFormatter` replaces core `user_name` so decoupled names render.
- **Form alters** — user register/edit, `user_pass`, and `user_login_form` (decoupled-aware, and
  Email-Registration / User-Registration-Password aware).
- **Submodule** — `decoupled_auth_crm` (Simple CRM), documented at
  `modules/de/decoupled_auth/modules/decoupled_auth_crm/3.1.x/`.

No permissions, no Drush, no services beyond `decoupled_auth.acquisition`.

## Solution docs

- **Entity model, coupled/decoupled state, constraints** → [api/entity-model.md](api/entity-model.md)
- **Acquisition API (find-or-create, behaviour flags, events)** → [api/acquisition.md](api/acquisition.md)
- **Settings config object + schema + keys** → [config/settings.md](config/settings.md)
- **Registration acquisition + module integrations (hooks)** → [api/integrations.md](api/integrations.md)
