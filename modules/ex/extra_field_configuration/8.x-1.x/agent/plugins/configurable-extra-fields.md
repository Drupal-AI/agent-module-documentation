<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Making an extra field configurable (plugin type, deriver, manager)

This module does **not** define a new plugin annotation. It reuses Extra Field's
`@ExtraFieldDisplay` annotation, interface (`ExtraFieldDisplayInterface`) and base classes
(`ExtraFieldDisplayBase`, `ExtraFieldDisplayFormattedBase`). What it adds is a **second manager +
deriver** so those plugins can be placed by configuration.

## Opt a plugin in

Add the deriver to the plugin's annotation and omit `bundles` (so the field is managed only through
config, never in two places at once):

```php
/**
 * @ExtraFieldDisplay(
 *   id = "my_extra_field",
 *   label = @Translation("My extra field"),
 *   deriver = "Drupal\extra_field_configuration\Plugin\Derivative\ExtraFieldConfigurationDeriver",
 *   weight = 10,
 *   visible = false,
 * )
 */
```

The plugin class body, its `view()` / `viewElements()` methods, and its file location
(`src/Plugin/ExtraField/Display/`) are unchanged from plain Extra Field. Extra Field Plus plugins
work the same way.

## The manager — `ExtraFieldConfigurationDisplayManager`

Service `plugin.manager.extra_field_configuration_display`; subclass of extra_field's
`ExtraFieldDisplayManager`. Constructed with `@container.namespaces`, `@cache.discovery`,
`@module_handler`, `@entity_type.manager`. It:

- Sets its own alter hook `extra_field_configuration_display_info` and cache key
  `extra_field_configuration_display_plugins` (tag `extra_field_configuration`).
- `findDefinitions()` — keeps **only** plugins whose annotation `deriver` is
  `ExtraFieldConfigurationDeriver` (that is how a plugin opts in).
- `getBaseDefinitions()` — the non-derived plugins (used to populate the add-form's provider
  select).
- `getDefinitions()` — only the **derived** definitions (the actual placed instances), used by
  `fieldInfo()`/`entityView()`.
- `entityView()` — renames each rendered build key `extra_field_{plugin}:{id}` → `extra_field_{id}`.

## The deriver — `ExtraFieldConfigurationDeriver`

`getDerivativeDefinitions()` loads all `extra_field_configuration` config entities. For every base
plugin it re-adds the base definition, then for each config entity whose `plugin_id` matches, it
creates a derivative keyed by the config `id` with:

- `bundles` = `$config->getBundlesFormatted()` (the `entity.bundle` list),
- `id` = config id, `label` = config label, `derived` = TRUE.

So one plugin plus N saved instances yields N derived plugin definitions — this is what enables
**reusing the same plugin many times** on an entity.

## Field / template naming

- Internal display component key: `extra_field_{plugin_id}:{id}` (`getRealFieldName()`).
- After `entityView()` renaming, the render key is `extra_field_{id}`.
- The list builder's *Field Name* column shows `extra_field_{id}` — print it in Twig as
  `{{ content.extra_field_{id} }}`.

## Formatted vs. simple plugins

- Extend `ExtraFieldDisplayBase` and implement `view()` for a simple render array.
- Extend `ExtraFieldDisplayFormattedBase` and implement `viewElements()` (+ optionally `getLabel()`
  / `getLabelDisplay()`) to get the field wrapped in the standard field template with a label.

See the examples submodule for one of each:
[../../../modules/extra_field_configuration_examples/8.x-1.x/agent/plugins/example-fields.md](../../../modules/extra_field_configuration_examples/8.x-1.x/agent/plugins/example-fields.md).

## Reusing the manager from your own code

`ExtraFieldConfigurationTrait` supplies lazy getters for `cache_tags.invalidator`,
`entity_type.manager`, `plugin.manager.extra_field_display`,
`plugin.manager.extra_field_configuration_display`, plus `clearFormCaches()` (clear both managers'
definitions + invalidate `entity_field_info`) and display-cleanup helpers
(`removeExtraFields()`, `getFieldActiveDisplays()`). Call `clearFormCaches()` after
programmatically saving/deleting instances so Manage-display forms and rendering pick up the change.
