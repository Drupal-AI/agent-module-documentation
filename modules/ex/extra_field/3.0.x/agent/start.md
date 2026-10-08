<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field — agent index

Two plugin types that turn classes into positionable pseudo-fields on any fieldable entity's
*Manage display* / *Manage form display*. **No settings form, no `configure` route, no
permissions, no config schema, no config entities.** The only persistent state is a component
named `extra_field_<plugin_id>` inside `core.entity_view_display.*` /
`core.entity_form_display.*`.

- **Write a display plugin or a form plugin (annotation/attribute keys, bundles wildcards,
  base classes, machine names)** → [plugins/extra-field-plugins.md](plugins/extra-field-plugins.md)
- **Place / read / remove an extra field on a display, and render it in Twig** →
  [api/placement.md](api/placement.md)
- **`hook_extra_field_display_info_alter()` / `hook_extra_field_form_info_alter()`** →
  [hooks/alter.md](hooks/alter.md)
- **The bundled Drush generators (and why they do not register on Drush 13)** →
  [drush/generators.md](drush/generators.md)
- **Ready-made example plugins** → submodule
  [`extra_field_example`](../../modules/extra_field_example/3.0.x/agent/start.md)

Quick facts:

| Thing | Value |
|---|---|
| Display plugins | `src/Plugin/ExtraField/Display/*.php` in **your** module, manager `plugin.manager.extra_field_display` |
| Form plugins | `src/Plugin/ExtraField/Form/*.php`, manager `plugin.manager.extra_field_form` |
| Attribute / annotation | `Drupal\extra_field\Attribute\ExtraFieldDisplay` / `ExtraFieldForm` (legacy `@ExtraFieldDisplay` / `@ExtraFieldForm` still work) |
| Pseudo-field machine name | `extra_field_` + plugin id (`ExtraFieldManagerBaseInterface::EXTRA_FIELD_PREFIX`) |
| Base classes | `ExtraFieldDisplayBase`, `ExtraFieldDisplayFormattedBase`, `ExtraFieldFormBase` |
| Alter hooks | `hook_extra_field_display_info_alter()`, `hook_extra_field_form_info_alter()` |
| Cache bins | discovery cache keys `extra_field_display_plugins`, `extra_field_form_plugins` |
