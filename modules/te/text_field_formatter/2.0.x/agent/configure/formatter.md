<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `text_field_formatter` formatter

`TextFieldFormatter` (id `text_field_formatter`, label "Text field formatter") extends core's
`StringFormatter`. Applies to **`string`** fields. Configure it on the entity's *Manage display*
page (there is no module settings page).

## Settings

| Key | Default | Meaning |
|---|---|---|
| `wrap_tag` | `_none` | wrapper tag: `div`, `h1`–`h6`, `span` (empty = no wrapper). `a` is disallowed. |
| `wrap_class` | `''` | CSS classes for the wrapper; space- or comma-separated (run through `Html::getClass`) |
| `wrap_attributes` | `''` | extra attributes, one `attribute|value` per line (value optional) |
| `override_link_label` | `''` | replacement label when the value links to the entity (token-aware); only used with `link_to_entity` |
| `link_to_entity` | (inherited) | from StringFormatter — link the value to its entity |

Stored on the view display: `core.entity_view_display.<entity>.<bundle>.<mode>` →
`content.<field>.type = text_field_formatter`, `content.<field>.settings.{wrap_tag,wrap_class,wrap_attributes,override_link_label,link_to_entity}`.

## Set it on a display (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_subtitle', [
  'type' => 'text_field_formatter',
  'label' => 'hidden',
  'settings' => [
    'wrap_tag' => 'h2',
    'wrap_class' => 'subtitle featured',
    'wrap_attributes' => "data-role|subtitle\nid|main-subtitle",
    'override_link_label' => '',
  ],
])->save();
```

```bash
drush cget core.entity_view_display.node.article.default content.field_subtitle
```

## Rendering

Each value is wrapped in a `#type => html_tag` element using `wrap_tag`, with `class` = parsed
`wrap_class` plus parsed `wrap_attributes`. When the value renders as a link and
`override_link_label` is set (and `link_to_entity` on), the label is token-replaced against the
field's entity. If `wrap_tag` is empty/`_none`, output is the plain string value.
