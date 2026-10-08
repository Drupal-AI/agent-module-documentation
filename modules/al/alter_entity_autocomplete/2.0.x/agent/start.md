<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter Entity Autocomplete (alter_entity_autocomplete) — agent index

Replaces core's `entity.autocomplete_matcher` service so entity-reference autocomplete fields accept a
**directly typed identifier** — numeric ID, `#ID`, user email, full URL, canonical path, or path alias —
and prepend the resolved entity as the first suggestion. Targets **Node, User, Taxonomy Term**. No module
dependencies, **no permissions of its own**, no Drush, no plugin types. Version **2.0.0**. Core
`^10.2 || ^11`. License GPL-2.0-or-later.

- **Everything: the service swap, the matcher algorithm, the settings form, config object/schema, routes**
  → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Service override** — `AlterEntityAutocompleteServiceProvider::alter()`
  (`src/AlterEntityAutocompleteServiceProvider.php`) takes the existing `entity.autocomplete_matcher`
  definition, calls `setClass(AlterEntityAutocompleteMatcher::class)` (arguments unchanged), and adds five
  setter method-calls (`setConfigFactory`, `setModuleHandler`, `setRequestStack`, `setPathValidator`,
  `setEntityTypeManager`). Constructor stays core-compatible; extra deps come in via setter injection.
- **The matcher** — `AlterEntityAutocomplete\AlterEntityAutocompleteMatcher extends
  Drupal\Core\Entity\EntityAutocompleteMatcher`. Overrides `getMatches()`; private helpers
  `resolveToEntityId()`, `getEntityLabel()`, `getEntityAlias()`.
- **Settings form** — `Form\AlterEntityAutocompleteSettingsForm extends ConfigFormBase` (form id
  `alter_entity_autocomplete_settings_form`), one `checkboxes` element `enabled_entities`
  (options `node` / `user` / `taxonomy_term`), writing config `alter_entity_autocomplete.settings`.
- **Hooks** — `Hook\AlterEntityAutocompleteHooks::help()` (attribute `#[Hook('help')]`) provides
  `help.page.alter_entity_autocomplete` and `system.admin_config_content` help text. `.module` is empty.
- **Route** — `alter_entity_autocomplete.admin_settings` → `/admin/config/alter_entity_autocomplete`,
  requirement `_permission: 'administer site configuration'`. Menu link under
  `system.admin_config_content`; local task on the same route.
- **Config** — install default `enabled_entities: []` (module does nothing until an admin opts a type in);
  schema `config/schema/alter_entity_autocomplete.schema.yml` types it as a sequence of strings.

## Mechanism in one paragraph

`getMatches($target_type, …, $string)` first calls `parent::getMatches()` (core's access-checked selection),
returns those unchanged if `$target_type` is not in `enabled_entities` or `$string` is empty, otherwise runs
`resolveToEntityId()` on the trimmed input. That helper matches `#?\d+`, a user email (via
`user` storage `loadByProperties(['mail' => …])`), an `https?://` URL reduced to its path, the base-path-stripped
`/…` path resolved through `pathValidator->getUrlIfValidWithoutAccessCheck()` mapped by canonical route name,
and finally literal `/node/N` `/user/N` `/taxonomy/term/N` patterns. The resolved entity is loaded, checked
against the field's `target_bundles`, and (if not already in the core matches) prepended as
`['value' => "$label ($id)", 'label' => "$label — $alias (id: $id)"]`.
