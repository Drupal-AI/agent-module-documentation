<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Link as Button" formatter

`ButtonLinkFormatter` (id **`button_link`**, label "Link as Button") applies to fields of type
**`link`**. It extends core `LinkFormatter`, so it inherits that formatter's settings and adds
button-specific ones. There is **no configure route and no settings form of its own** — you set
it per field on the entity's *Manage display* page (or in `entity_view_display` config).

## Selecting it (UI)

1. *Manage display* for the bundle (e.g. `/admin/structure/types/manage/article/display`).
2. On the Link field's row, choose **Link as Button** in the Format column.
3. Click the cog to set the options below; **Update**, then **Save**.

## Settings keys

Button-specific (from `defaultSettings()`):

| Key | Default | Values / meaning |
|---|---|---|
| `btn_type` | `btn-default` | `btn-default`, `btn-primary`, `btn-secondary`, `btn-success`, `btn-info`, `btn-warning`, `btn-danger`, `btn-light`, `btn-dark`, `btn-link`. **Required.** |
| `btn_size` | `''` | `''` (default), `btn-lg`, `btn-sm`, `btn-xs`. |
| `btn_block` | `NULL` | `btn-block` when the "Block level?" checkbox is ticked, else empty. |
| `link_text` | `''` | Override text for every button (leave empty to use the field's link title). |
| `additional_class` | `''` | Extra space-separated CSS classes added to the `<a>`. |
| `icon_class` | `''` | Classes for a leading `<i>` icon, e.g. `fa fa-anchor`. |
| `disable_btn_role` | `0` | `1` drops the default `role="button"` attribute. |

Inherited from core `LinkFormatter`: `trim_length` (default 80), `rel`, `target`, `url_only`,
`url_plain`. (The button formatter uses the link title/text; `url_only`/`url_plain` come from
the parent.)

## Where it is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_cta:
    type: button_link
    settings:
      btn_type: btn-primary
      btn_size: btn-lg
      icon_class: 'fa fa-anchor'
      additional_class: ''
      disable_btn_role: 0
    label: hidden
```

## Read / write via drush + PHP

```bash
drush cget core.entity_view_display.node.article.default content.field_cta
```

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_cta', [
  'type' => 'button_link',
  'label' => 'hidden',
  'settings' => ['btn_type' => 'btn-primary', 'btn_size' => 'btn-lg'],
])->save();
```

Note: Bootstrap CSS is not provided by the module — the classes only render as buttons if your
theme loads Bootstrap (or equivalent `.btn` styles).
