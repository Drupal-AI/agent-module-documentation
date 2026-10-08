<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring an Inheritance

Go to **Admin → Structure → Inheritance** (`/admin/structure/inheritance`), click **Add Inheritance**.
Fields (all part of the `inheritance` config entity):

- **Label**, **Enabled** (uncheck to pause without deleting), **Description**.
- **Field Strategy** — one of the updater plugins: `update`, `overwrite`, `override`,
  `override_role_visibility`, `disable` (+ per-strategy config where applicable).
- **Source Entity Type → Bundle → Field** — where the value comes from.
- **Destination Entity Type → Bundle → Field** — where it is written.
- **Destination Reference Field to Source** — the entity-reference field on the destination
  bundle that points at the source (currently a single-value reference field only).

Global behaviour lives at `/admin/structure/inheritance/settings` (`inheritance.settings` route,
`administer inheritance` permission). All add/edit/delete/list routes require `administer inheritance`.

The sync runs automatically on entity `insert`/`update`/`presave`/`delete`/`load` and on form build
(`form_alter`, `field_group_form_process_alter`) via the `entity_value_inheritance.updater` service.
