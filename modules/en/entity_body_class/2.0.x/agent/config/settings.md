<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, routes & permissions

## Install / enable

`composer require drupal/entity_body_class` then `drush en entity_body_class -y`. No module
dependencies; the `token` module is optional (only adds a token-browser link on the field form).

## Settings form — `src/Form/EntityBodyClassForm.php`

`EntityBodyClassForm extends ConfigFormBase`, form id `entity_body_class`, editable config
`entity_body_class.settings`. Injects `entity_type.manager` via `create()`.

- `buildForm()` builds a `#tree` fieldset `types` (*"Default body classes"*). It iterates
  `entityTypeManager->getDefinitions()` and, for each definition whose `getOriginalClass()` implements
  `ContentEntityInterface` and that has a `canonical` link template, adds a textfield keyed by the entity
  type id, labelled with the entity type's label, defaulted to the stored `types[<id>]` value.
- `submitForm()` saves `entity_body_class.settings` key `types` = `array_filter($form_state->getValue('types'))`
  (empty values dropped), then calls parent.

These per-type strings are used only as the `#default_value` for **new** entities (see the field doc); they
are not written to `<body>` directly.

## Config object & schema

- Object: `entity_body_class.settings`.
- Schema (`config/schema/entity_body_class.schema.yml`): `config_object` with `types` = `sequence` of
  `string` (label *"Default values"*). No `config/install/` file ships, so the object starts empty.

Example export:

```yaml
# entity_body_class.settings
types:
  node: 'default-node-class'
  taxonomy_term: 'term-page [term:vid]'
```

## Route & menu

- `entity_body_class.settings` (`entity_body_class.routing.yml`) → path
  `/admin/config/content/body-class-settings`, `_form` = `EntityBodyClassForm`, title
  *"Manage entity body class settings"*, requirement `_permission: 'access entity body class settings'`.
- Menu link (`entity_body_class.links.menu.yml`) parents it under `system.admin_config_content`
  (*Configuration → Content*). `configure` in info.yml points here.

## Permissions — `entity_body_class.permissions.yml` + `src/EntityBodyClassPermissions.php`

Static (in the YAML):

- `access entity body class settings` — *Manage body class settings* (gates the settings route above).
- `access entity body class fields` — *Manage body class fields* (grants field access on **all** supported
  entity types).

Dynamic (`permission_callbacks` → `EntityBodyClassPermissions::permissions`): for every content entity
type with a canonical link template it defines `access <entity_type_id> body class field`
(*"Manage @entity_type body class field"*), granting field access for just that one entity type. `hook_form_alter()`
grants field visibility if the user holds the global fields permission **or** the per-type one.
