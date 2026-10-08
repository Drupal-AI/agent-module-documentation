<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `plain_string_formatter` field formatter

An implementation of core's `@FieldFormatter` plugin type (the module defines no new plugin
type). It extends `Drupal\Core\Field\Plugin\Field\FieldFormatter\StringFormatter`.

- **id:** `plain_string_formatter`
- **label:** "Plain string formatter"
- **field_types:** `string`, `string_long`

## Settings

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `wrap_tag` | string (select) | `_none` | HTML tag to wrap each value in. `_none` = no wrapper (behaves like core string formatter). |
| `wrap_class` | string | `''` | Space/comma-separated CSS classes for the wrapper (each passed through `Html::getClass()`). |
| `link_to_entity` | bool | (inherited from `StringFormatter`) | Link the value to its entity. |

`wrap_tag` options: `h1`–`h6`, `p`, `blockquote`, `pre`, `template`, `abbr`, `address`,
`cite`, `code`, `del`, `em`, `ins`, `kbd`, `mark`, `meter`, `progress`, `q`, `s`, `samp`,
`small`, `strong`, `sub`, `sup`, `time`, `u`, `var`, `div`, `span`.

When `wrap_tag` is set, each value is rendered as an `html_tag` render element
(`#tag => wrap_tag`, `#attributes['class'] => prepared classes`) wrapping the core-formatted
content. When `_none`, output is identical to the core string formatter.

## Configure via the UI

*Manage display* for the bundle (e.g. `/admin/structure/types/manage/article/display`) → set
the string field's **Format** to *Plain string formatter* → open the cog → choose **Wrapper
tag** and enter **Classes for wrapper tag** → *Update* → *Save*. The summary reads e.g.
"Wrapper tag: H2 / Classes: field-title".

## Where it is stored

In the `entity_view_display` config entity for that bundle/view-mode:

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  <field_name>:
    type: plain_string_formatter
    label: hidden
    settings:
      wrap_tag: h2
      wrap_class: 'field-title big'
      link_to_entity: false
```

## Scriptable (drush php:eval)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_subtitle', [
  'type' => 'plain_string_formatter',
  'label' => 'hidden',
  'settings' => ['wrap_tag' => 'h2', 'wrap_class' => 'field-title'],
])->save();
```

Read back: `drush cget core.entity_view_display.node.article.default content.field_subtitle`.
The formatter only appears for fields whose type is `string` or `string_long`.
