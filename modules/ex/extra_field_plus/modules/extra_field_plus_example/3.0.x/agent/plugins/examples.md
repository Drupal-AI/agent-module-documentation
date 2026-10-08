<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The example extra-field plugins

Two plugins in `modules/extra_field_plus_example/src/Plugin/ExtraField/Display/`, both using
Extra Field's `@ExtraFieldDisplay` annotation, both for `bundles = { "node.*" }`,
`visible = false`.

## `example_node_label` — `ExampleNodeLabel`

Extends `ExtraFieldPlusDisplayBase` (raw output, implements `view()`).

- Renders `$entity->label() . ' (from extra_field_plus example)'` inside an `html_tag`.
- Settings via `extraFieldSettingsForm()`:
  - `link_to_entity` — checkbox; when on, the label is wrapped in a link to the entity.
  - `wrapper` — select of `span, p, h1, h2, h3, h4, h5`.
- `defaultExtraFieldSettings()` → `['link_to_entity' => FALSE, 'wrapper' => 'span']`.
- `settingsSummary()` → "Link to the entity: Yes/No", "Wrapper: <tag>".

## `example_node_label_formatted` — `ExampleNodeLabelFormatted`

Extends `ExtraFieldPlusDisplayFormattedBase` (wrapped in the standard field template).

- Implements `viewElements()` (same label + suffix output), plus `getLabel()` and
  `getLabelDisplay()` (returns `'above'`) so it renders with a field label.
- Same two settings (`link_to_entity`, `wrapper`) and the same defaults/summary.

## Enable and place them

```bash
drush en extra_field_plus_example -y && drush cr
```

Then *Structure → Content types → Article → Manage display*
(`/admin/structure/types/manage/article/display`): drag **Extra Field Plus: Example Node
Label** (or the Formatted one) out of *Disabled*, click its cog, choose the wrapper and the
link toggle, **Update**, **Save**.

## Where the settings land

```bash
drush cget core.entity_view_display.node.article.default content.extra_field_example_node_label
# settings: { link_to_entity: true|false, wrapper: span|p|h1..h5 }
```

Programmatically:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$fd->setComponent('extra_field_example_node_label', [
  'type' => 'extra_field_example_node_label',
  'settings' => ['link_to_entity' => TRUE, 'wrapper' => 'h2'],
  'weight' => 10, 'region' => 'content',
])->save();
```

Config schema (validates those settings): `field.formatter.settings.extra_field_example_node_label`
and `…_formatted`, each with `link_to_entity` (boolean) + `wrapper` (string).
