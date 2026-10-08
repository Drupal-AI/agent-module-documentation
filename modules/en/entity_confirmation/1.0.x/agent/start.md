<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Confirmation (entity_confirmation) — agent index

Customizes or suppresses the **status message shown after an entity create / edit / delete**, configured
**per entity form display** (form mode) via third-party settings. Version **1.0.8**. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. No dependencies (Token module is optional). It is a message/UX feature: **no routes,
no permissions, no entities, no services, no plugins**. It does **not** change redirects.

- **The whole mechanism — the form_alter UI, the stored settings, the submit handler, tokens, and the alter hook** →
  [config/confirmation-messages.md](config/confirmation-messages.md)

## What it actually is (from source)

- Everything lives in `entity_confirmation.module`. `entity_confirmation_form_alter()`:
  - On an **EntityForm whose entity is an `EntityFormDisplayInterface`** (the *Manage form display* config form) it
    adds a `Confirmation settings` details group with a textarea + a "disable" checkbox for each of **create, edit,
    delete**, plus a `token_tree_link` when the **token** module is enabled, and registers the entity builder
    `entity_confirmation_form_entity_type_form_builder()`.
  - On **any other entity form** it appends `entity_confirmation_form_op_submit()` to `actions.submit['#submit']`.
- Settings are stored as **third-party settings** (`entity_confirmation.*`) on the `core.entity_form_display.*.*.*`
  config entity (schema: `config/schema/entity_confirmation.schema.yml`; keys `confirmation_{create,edit,delete}` and
  `confirmation_{create,edit,delete}_disable`).
- On save, `entity_confirmation_form_op_submit()` maps the form operation (`default` → `create`), then either deletes
  the default `status` messages (if `*_disable` is set) or replaces them with the custom text — passed through
  `token->replace()` then `Xss::filterAdmin()`, and wrapped in `Markup::create()`.
- Extension point: `hook_entity_confirmation_alter(&$value, $op, $entity)` (see `entity_confirmation.api.php`), plus a
  matching theme alter.
