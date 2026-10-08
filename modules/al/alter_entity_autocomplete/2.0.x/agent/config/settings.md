<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring and operating Alter Entity Autocomplete

## Install / enable

`composer require drupal/alter_entity_autocomplete` then `drush en alter_entity_autocomplete`. No
dependencies beyond core (`^10.2 || ^11`). Enabling the module alone changes nothing: the service swap is
active but `enabled_entities` defaults to `[]`, so the matcher returns core's results untouched until a type
is opted in.

## The service override

`src/AlterEntityAutocompleteServiceProvider.php` — `AlterEntityAutocompleteServiceProvider::alter(ContainerBuilder $container)`:

- `$container->getDefinition('entity.autocomplete_matcher')->setClass(AlterEntityAutocompleteMatcher::class)`
  — reuses the core service definition/arguments, only changing the class. Any autocomplete request for any
  entity-reference field now flows through the subclass.
- Adds method calls `setConfigFactory` (`config.factory`), `setModuleHandler` (`module_handler`),
  `setRequestStack` (`request_stack`), `setPathValidator` (`path.validator`), `setEntityTypeManager`
  (`entity_type.manager`). Setter injection keeps the constructor signature core-compatible.

A service provider needs a cache rebuild (`drush cr`) to take effect after enable.

## Settings form, route, config object

- Route `alter_entity_autocomplete.admin_settings`, path `/admin/config/alter_entity_autocomplete`,
  `_permission: 'administer site configuration'`, form
  `Form\AlterEntityAutocompleteSettingsForm` (`alter_entity_autocomplete.routing.yml`). Reached via the
  *Configuration → Content authoring → Alter Entity Autocomplete settings* menu link
  (`alter_entity_autocomplete.links.menu.yml`, parent `system.admin_config_content`).
- The form (`buildForm()`) is a single `#type => 'checkboxes'` element `enabled_entities` with options
  `node`, `user`, `taxonomy_term`, plus a static description and a collapsed "Usage Examples" details block.
  `getEditableConfigNames()` / `getFormId()` return `alter_entity_autocomplete.settings` /
  `alter_entity_autocomplete_settings_form`.
- `submitForm()` saves `array_filter($form_state->getValue('enabled_entities'))` (unchecked boxes are `0`
  and dropped) into config key `enabled_entities`.
- Config object `alter_entity_autocomplete.settings`; install default `enabled_entities: []`
  (`config/install/`). Schema (`config/schema/alter_entity_autocomplete.schema.yml`): a `config_object`
  whose `enabled_entities` is a `sequence` of `string` entity-type machine names.

Set it from the CLI without the UI:
`drush cset alter_entity_autocomplete.settings enabled_entities.0 node -y` (repeat with an incremented index
for `user` / `taxonomy_term`), then `drush cr`.

## The matcher algorithm — `AlterEntityAutocompleteMatcher::getMatches()`

`src/AlterEntityAutocomplete/AlterEntityAutocompleteMatcher.php`. Signature matches core:
`getMatches($target_type, $selection_handler, $selection_settings, $string = '')`.

1. `$matches = parent::getMatches(...)` — core's normal, selection-handler-driven suggestions.
2. Read `enabled_entities` from `alter_entity_autocomplete.settings`. If `$target_type` is not in it
   (strict `in_array`) or `$string === ''`, return the core matches unchanged.
3. `resolveToEntityId(trim($string), $target_type)` → an int ID or `NULL`; on `NULL`, return core matches.
4. Load the entity with `entityTypeManager->getStorage($target_type)->load($entity_id)`; if it fails to
   load, return core matches.
5. If `$selection_settings['target_bundles']` is a non-empty array and `$entity->bundle()` is not in it,
   return core matches (field bundle restriction honoured).
6. Dedupe: `array_filter($matches, …)` with `preg_match('/\((\d+)\)\s*$/', $m['value'])` — if a core match
   already ends in `(<same id>)`, don't add ours.
7. Otherwise `array_unshift` a new first match:
   `'value' => sprintf('%s (%d)', $label, $entity_id)` (what the widget stores) and
   `'label' => sprintf('%s — %s (id: %d)', $label, $alias, $entity_id)` (what the user sees).

### `resolveToEntityId(string $input, string $entity_type): ?int`

Tried in order: (1) `^#?(\d+)$` → that int; (2) `user` only — `filter_var($input, FILTER_VALIDATE_EMAIL)`
then `user` storage `loadByProperties(['mail' => $input])`, `reset()`->id(); (3) `^https?://` → replace
input with `parse_url(PHP_URL_PATH)`; then prefix `/` if missing, strip the request base path
(`requestStack->getCurrentRequest()->getBasePath()`), `urldecode`; (4) `pathValidator->getUrlIfValidWithoutAccessCheck($path)`
→ if routed, map route name via `$route_mapping` (`entity.node.canonical`→node/`node`,
`entity.user.canonical`→user/`user`, `entity.taxonomy_term.canonical`→taxonomy_term/`taxonomy_term`) and,
when the mapped type equals `$entity_type`, return the route parameter as int; (5) fallback literal patterns
`^/node/(\d+)$`, `^/user/(\d+)$`, `^/taxonomy/term/(\d+)$` keyed to the matching `$entity_type`; else `NULL`.

### Label / alias helpers

- `getEntityLabel($entity, $entity_type)`: `$entity->label() ?: 'Untitled'`.
- `getEntityAlias($entity, $entity_type)`: canonical `toUrl('canonical')->toString()`; for `node` /
  `taxonomy_term`, if `path_alias` module exists, `path_alias` storage `loadByProperties(['path' => $path])`
  and returns the first `alias` value, else the canonical path.

## Extending to more entity types

Per the README, add an `entity.<type>.canonical => ['entity_type' => …, 'param' => …]` row to
`$route_mapping` in `resolveToEntityId()`, add the option to the form's `enabled_entities` `#options`, and the
schema already accepts any string machine name. Email resolution is hard-coded to `user` only.

## Operating notes

- Nothing happens until at least one type is checked; verify with
  `drush cget alter_entity_autocomplete.settings enabled_entities`.
- Alias resolution for aliases only covers `node` and `taxonomy_term` (canonical `/user/N` still works for
  users). Multilingual/base-path handling is built into `resolveToEntityId()`.
- The subclass overrides only `getMatches()`; every other autocomplete behaviour is inherited from core
  `EntityAutocompleteMatcher`.
