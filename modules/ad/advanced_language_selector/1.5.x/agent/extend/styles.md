# Extend — how styles work and the StyleManager service

A "style" is the module's own abstraction (not a Drupal plugin type — `provides_plugin_types` is
empty). A style = a YAML file in `config/styles/` + a matching Twig template + a `theme` hook that
`hook_theme()` auto-registers.

## Anatomy of a style YAML (`config/styles/<id>.yml`)
```yaml
id: 'bootstrap_dropdown'            # required; also the Theme-selector option value
title: 'Bootstrap Dropdown'         # label shown in the Look and Feel select
theme: 'block__language_selector__bootstrap_dropdown'  # theme hook / template
templates_location: '/templates'    # relative to the module; StyleManager makes it absolute
libraries: []                       # libraries attached when this style renders
properties:                         # the form field tree for this style
  bootstrap_dropdown:
    type: 'details'
    states: { visible: { ':input[name="settings[look_and_feel][theme]"]': { value: 'bootstrap_dropdown' } } }
    properties:
      general: { type: 'fieldgroup', properties: { id: {type: textfield, ...}, css: {...}, ... } }
      display: { type: 'fieldset', properties: { selected_item: {...}, items: {...} } }
```
`properties` is a recursive tree. Any key except `properties` on a node becomes a Form-API
property with a `#` prefix (`title` → `#title`, `type` → `#type`, `default_value` →
`#default_value`, `options`, `states`, `required`, `open`, etc.). `LanguageSelectorBlock::buildItem()`
/ `buildFormField()` walk this tree to build the block form and initialize configuration defaults.

## Adding a new style
1. Add `config/styles/<id>.yml` with a unique `id`, a `title`, a `theme` hook, and a `properties`
   tree (gate visibility with a `states.visible` on the theme select as above).
2. Add `templates/block--language-selector--<id-with-dashes>.html.twig` using the variables in
   theming/templates.md.
3. Clear caches. `hook_theme()` picks up the new `theme` hook automatically, and `StyleManager`
   picks up the YAML on the next scan — the style then appears in the Look and Feel select.

Note: `StyleManager` scans **the module's own** `config/styles/` directory (path resolved from
`advanced_language_selector`), so styles are effectively added by editing/patching this module,
not from other modules. There is no alter hook or plugin manager for styles.

## StyleManager service
Service id `advanced_language_selector.style_manager`, class
`Drupal\advanced_language_selector\Services\StyleManager`, interface `StyleManagerInterface`
(constructor args: `@module_handler`, `@file_system`). Methods:
- `getAvailableStyles(): array` — scans `config/styles/*.yml`, decodes each, resolves
  `templates_location` to an absolute path, keys the result by style `id` (skips files with no
  `id`).
- `getStyle(string $key): array` — one style definition, or `[]`.
- `getStyleSelector(array $styles): array` — reads `config/style_selector.yml` and injects the
  style ids/titles as the Theme select `options`.

You can `\Drupal::service('advanced_language_selector.style_manager')` to enumerate styles
programmatically, but there is no extension point beyond adding YAML files.

## Dead service definition (heads-up)
`advanced_language_selector.services.yml` also declares
`advanced_language_selector.service` → class `...\Services\AdvancedLanguageSelectorService`, but
**no such class file exists** in `src/Services/`. It is unused by the block/render path (only
`StyleManager` is wired into the block). Do not rely on that service — instantiating it would
fail.
