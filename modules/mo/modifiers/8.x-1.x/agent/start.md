<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modifiers (modifiers) — agent index

Framework that defines a **`modifier` plugin type**. Each modifier plugin turns stored entity/field
values (colours, spacing, images, animation config) into **inline CSS + JS library attachments + DOM
attributes**, attached to an entity, theme region or Layout Builder section via a generated CSS
selector. Version **8.x-1.8**, core `^10.2 || ^11 || ^12`, no dependencies, no config/permissions/
schema. Ships **no concrete plugins** — those come from **Modifiers Pack**; **Look** applies
per-page collections. Maintained by Morpht.

## How it works (real mechanism)

- **Service `modifiers`** (`Drupal\modifiers\Modifiers`, `src/Modifiers.php`) is the engine.
- **`hook_entity_view_alter`** (`src/Hook/ModifiersHooks.php`): if the entity has field
  **`field_modifiers`** (constant `Modifiers::FIELD`), it extracts config, adds marker classes
  (`modifiers`, `modifiers-id-<type>-<id>`, `modifiers-type-*`, `modifiers-bundle-*`,
  `modifiers-display-*`), builds selector `html body .modifiers.modifiers-id-<id>` and applies.
  Paragraph `preview` display mode is skipped.
- **Config extraction** (`extractEntityConfig` / `extractFieldConfig` / `getReferencedValue` /
  `getSimpleValue`): flattens referenced entities' fields into `[modifier_id][] => [field => value]`.
  Field names lose the `field_mod_` (or `field_`) prefix. Media/image references resolve to file
  URLs; `color_field_type` becomes `rgba()` via **`getColorValue()`** (hex validated by
  `preg_match('/[0-9A-F]{6}/i')`).
- **Plugin contract**: `ModifierInterface::modification($selector, array $config)` — **static** —
  returns a `Modification` (`src/Modification.php`) with five arrays: `css` (`[media][selector] =>
  [properties]`), `libraries`, `settings`, `attributes`, `links`.
- **`Modifiers::apply()`**: `renderCss()` concatenates `selector{prop;prop}` (wrapped in `@media`
  when media key ≠ `all`) and attaches ONE `#attached['html_head']` `<style media="all"
  data-modifiers="…">` whose `#value` is `Markup::create($style)` → **inline `<style>` in the head,
  no CSS file written**. Libraries → `#attached['library']`; settings/attributes →
  `drupalSettings.modifiers`; links → head `<link>` tags.
- **JS** (`js/modifiers.init.js`, library `modifiers/init`, always attached via
  `preprocess_html`): dispatches each setting to `window[namespace][callback](selector, media, args)`
  and enables/disables attributes+classes per `window.matchMedia(media)` on resize.
- **Layout Builder** (`modifiers_preprocess_layout` in `.module`): custom block bundles ending in
  `_modifier` are read from regions and applied to the section (if `field_lb_modifiers_section` set)
  or region.
- **Plugin manager** `plugin.manager.modifier`: discovers `Plugin/modifiers` (attribute
  `#[Modifier]` / annotation `@Modifier`) in **modules and themes**, plus YAML `*.modifiers.yml`
  discovery. Alter hook name `modifiers_info`.

## Alter hooks (`modifiers.api.php`)

- `hook_modifiers_info_alter(&$modifiers)` — alter/replace plugin definitions (incl. `class`).
- `hook_modifiers_mappings_alter(&$mappings)` — alter entity-type/bundle → field mappings used to
  resolve referenced values (media files, colour terms).
- `hook_modifiers_entity_view_config_alter(&$config, &$context)` — alter extracted config / build.

## Design consequences

1. **Modifier values are content** — stored on the entity; they version, export and migrate. A
   modifier plugin removed/renamed leaves entities pointing at a plugin that no longer exists.
2. **Vocabulary grows unless owned** — the value over a free-text class field is a finite, named,
   developer-managed option set.

## Sub-docs

- `api/` — service methods, plugin contract, `Modification` shape, alter hooks, mapping table.
- `plugins/` — how to write a `modifier` plugin (PHP attribute/annotation and YAML forms).
