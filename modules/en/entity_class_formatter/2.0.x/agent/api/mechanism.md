<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

Two files: the formatter plugin (which deliberately renders **nothing**) and
`entity_class_formatter.module` (one hook + two helpers). No services, no events, no API for
other modules to implement.

## The formatter plugin

`Drupal\entity_class_formatter\Plugin\Field\FieldFormatter\EntityClassFormatter`
(`@FieldFormatter id = "entity_class_formatter"`, label "Entity Class").

- `defaultSettings()` → `['prefix' => '', 'suffix' => '', 'attr' => '', 'field' => '']`.
- `settingsForm()` → four textfields. `attr` is `#required` when the field type is
  `decimal`/`float`/`integer`; `field` is `#access`-restricted to `entity_reference` fields.
- `settingsSummary()` → one line per non-empty setting (`Prefix: "…"`, `Attribute: "…"` …).
- **`viewElements()` returns `[]`** — the field prints nothing. The whole effect is the hook below.

## `hook_entity_view_alter()`

`entity_class_formatter_entity_view_alter(&$build, $entity, $display)`:

1. Bails unless `$entity instanceof FieldableEntityInterface`.
2. Collects `$fields[<field_name>][] = <formatter settings>`:
   - **Layout Builder display** (`LayoutEntityDisplayInterface` and layout enabled): iterates
     sections → components; when the display `isOverridable()` and the entity has
     `layout_builder__layout` it uses the entity's own sections, otherwise the display's default
     sections. For each component whose `configuration.formatter.type` is
     `entity_class_formatter`, the field name is the **4th `:`-separated part** of the component
     id (`field_block:node:article:field_x`). A field can therefore appear more than once.
   - **Normal display**: every component whose `type` is `entity_class_formatter`.
3. For each collected field present on the entity, calls `_entity_class_formatter_apply()` once
   per settings set.

## `_entity_class_formatter_apply()`

Resolves `prefix`, `suffix`, `attr` (default `class`) and `field`, extracts values, then for each
value appends:

```php
$build['#attributes'][$attr][] = Html::getClass($prefix . $value . $suffix);   // attr === 'class'
$build['#attributes'][$attr][] = Html::escape($prefix . $value . $suffix);     // any other attr
```

So classes are sanitised into valid CSS identifiers (`Html::getClass()` lowercases and replaces
invalid characters); other attributes are only HTML-escaped and keep their original casing.

## `_entity_class_formatter_extract()` — value rules per field type

| Field | Value contributed |
|---|---|
| `entity_reference` | For each referenced entity: if the `field` setting names a field that entity **has**, recurse into that field's values; otherwise the referenced entity's `label()` (skipped when empty). |
| `boolean` | The field definition's `on_label` setting when the value is truthy (`filter_var(..., FILTER_VALIDATE_BOOLEAN)`), otherwise `off_label`. |
| anything else | Each item's `value`, skipped when empty. When `attr` is `class` the value is `explode(' ', …)`-ed so `"red big"` yields **two** classes; for other attributes the value is passed through whole. |

## Consequences an agent should know

- The class lands on the **entity wrapper** (`$build['#attributes']`), so the theme template must
  print `attributes` — core's `node.html.twig`, `taxonomy-term.html.twig`, `media.html.twig`,
  `paragraph.html.twig` all do. A template that ignores `attributes` shows nothing.
- Setting the formatter hides the field from the output — there is no way to both print the value
  and use it as a class with a single component (use two Layout Builder blocks for that).
- Empty values contribute nothing; there is no "default class" fallback.
- Nothing is cached separately: the classes ride along on the entity's own render cache, so a
  field change invalidates them normally.
- `attr` is not validated — any string becomes an attribute name. Writing `class` explicitly is
  exactly equivalent to leaving it empty (the helper defaults `attr` to `class` and then picks
  `Html::getClass()` for it).
