<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Font Awesome Icon Picker on a field

There is **no module settings page**. You configure it per field, on the *Manage form display*
(widget) and *Manage display* (formatter) tabs of an entity bundle.

## Steps (UI)

1. Add a **Text (plain)** (`string`) or **Text (formatted)** (`text`) field to a bundle
   (Text plain is recommended).
2. *Manage form display* → set that field's widget to **"Font Awesome Icon Picker"**. Configure
   its settings (cog).
3. *Manage display* → set that field's formatter to **"Font Awesome Icon Picker"** and choose a
   size.
4. Save.

## Widget settings (`fontawesome_iconpicker`)

Schema `field.widget.settings.fontawesome_iconpicker`:

| Setting | Type | Default | Notes |
|---|---|---|---|
| `type` | string | `''` | **Required.** `default` (plain picker) or `component` (loads the Bootstrap-5 theme). |
| `size` | integer | `60` | HTML `#size` of the text input. |
| `placeholder` | string | `''` | Placeholder text (the in-picker search placeholder is "Search icon…"). |

The widget renders a textfield with class `fontawesomeIconPickerVanillaIconPicker` and attaches
the `fontawesome_iconpicker/vanilla-icon-picker` library; icon sources are FontAwesome Solid/
Regular 5 and Solid/Regular/Brands 6.

## Formatter settings (`fontawesome_iconpicker_formatter_type`)

Schema `field.formatter.settings.fontawesome_iconpicker_formatter_type`:

| Setting | Type | Default | Options |
|---|---|---|---|
| `size` | string | `fa-1x` | `fa-1x`, `fa-2x`, `fa-3x`, `fa-4x`, `fa-5x` |

Output: `<i class="fa <stored-icon-class> <size>" aria-hidden="true"></i>` (via the
`fontawesome_iconpicker_formatter` theme hook).

## Where config is stored

```yaml
# core.entity_form_display.node.article.default  (widget)
content:
  field_icon:
    type: fontawesome_iconpicker
    settings: { type: default, size: 60, placeholder: '' }

# core.entity_view_display.node.article.default  (formatter)
content:
  field_icon:
    type: fontawesome_iconpicker_formatter_type
    settings: { size: fa-2x }
```

## Set it with drush

```bash
# Widget on the default form display
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_icon", ["type"=>"fontawesome_iconpicker","region"=>"content",
    "settings"=>["type"=>"default","size"=>60,"placeholder"=>""]])->save();'

# Formatter on the default view display at 2x
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_icon", ["type"=>"fontawesome_iconpicker_formatter_type","region"=>"content",
    "settings"=>["size"=>"fa-2x"]])->save();'
```

Requires the contrib **Font Awesome** module to be enabled (it provides the icon CSS/webfont)
and the `d34dman/vanilla-icon-picker` library under `/libraries`.
