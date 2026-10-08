<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity body class (entity_body_class) — agent index

Adds a translatable **`entity_body_class` string base field** ("Body CSS class(es)") to every
**content entity type that has a `canonical` link template**, and appends that value — after token
replacement — to the page **`<body>` class list** when the entity is viewed. Package `Field`. No
module dependencies (Token module optional, for a token-browser link). Core `^8.8 || ^9.0 || ^10.0 || ^11`.
License GPL-2.0-or-later. Version 2.0.3.

- **The base field, form integration, XSS filter, and `<body>` output** →
  [fields/body-class-field.md](fields/body-class-field.md)
- **Settings form, config object, routes, permissions** →
  [config/settings.md](config/settings.md)

## What it actually is (all in `entity_body_class.module` + `src/`)

- `hook_entity_base_field_info()` — creates base field `entity_body_class` (label *Body CSS class(es)*,
  type `string`, translatable, form widget `string_textfield`) on each entity type where
  `getOriginalClass()` implements `ContentEntityInterface` **and** `getLinkTemplate('canonical')` is set.
- `hook_preprocess_html()` — scans `\Drupal::routeMatch()->getParameters()`; for any content entity that
  has a non-empty `entity_body_class` field, runs `\Drupal::token()->replace(...)` and appends the result
  to `$variables['attributes']['class'][]`.
- `hook_form_alter()` — on `ContentEntityFormInterface` forms that contain the field: pre-fills new
  entities from config default, adds a `token_tree_link` (if Token module enabled), sets field `#access`
  from permissions, and registers the validation handler.
- `entity_body_class_entity_form_validate()` — runs `Xss::filter()` over the submitted value before save.
- Config settings form `EntityBodyClassForm` (`src/Form/`), dynamic permissions provider
  `EntityBodyClassPermissions` (`src/`).

## Provides

- **Config object** `entity_body_class.settings` (key `types`: map of entity-type-id → default class string).
- **Route** `entity_body_class.settings` → `/admin/config/content/body-class-settings`
  (menu under *Configuration → Content*).
- **Permissions**: static `access entity body class settings`, `access entity body class fields`; plus a
  dynamic `access <entity_type_id> body class field` per supported entity type.
- No services, no plugins, no Drush, no submodules.
