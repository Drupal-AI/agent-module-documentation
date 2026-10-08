<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ckeditor5_icons_icon` CKEditor 5 plugin

The module defines **no plugin types of its own**. It contributes exactly one *CKEditor 5*
plugin, declared in `ckeditor5_icons.ckeditor5.yml`.

## Declaration (what core reads)

```yaml
ckeditor5_icons_icon:
  ckeditor5:
    plugins: [icon.Icon, icon.IconGeneralHtmlSupport, icon.IconLinkEditing]
    config:
      icon:
        toolbarItems: [iconSize, iconAlignment, iconStyle]   # the widget balloon toolbar
        faVersion: '6'
        faStyles: [solid, regular, brands]
        recommendedIcons: null
  drupal:
    label: Icons
    library: ckeditor5_icons/icon.editor
    admin_library: ckeditor5_icons/icon.admin
    toolbar_items:
      icon: { label: Icons }        # the toolbar button id you put in settings.toolbar.items
    elements: ['<i>', '<i class>']  # tags allowed through filter_html when enabled
    class: Drupal\ckeditor5_icons\Plugin\CKEditor5Plugin\Icon
```

The PHP class implements `CKEditor5PluginConfigurableInterface` + `PluginWithFormsInterface`;
its form class is `Drupal\ckeditor5_icons\PluginForm\ConfigureIconForm`. `defaultConfiguration()`
returns only `custom_metadata: FALSE`, `async_metadata: TRUE`, `recommended_enabled: FALSE` —
`fa_version` and `fa_styles` fall back to the static `ckeditor5.config` values above when unset.

`getDynamicPluginConfig()` is where the stored config becomes JS config: it maps
`fa_version → faVersion`, `fa_styles → faStyles`, `recommended_icons → recommendedIcons`
(only when `recommended_enabled`), sets `customMetadata`, and then either adds
`asyncMetadataURI` (a CSRF-tokenised URL) or inlines `faCategories` + `faIcons`.

## Model and markup

CKEditor model element `<icon>` (`isObject`, `isInline`, `allowWhere: $text`) with attributes
`iconFA`, `iconStyle`, `iconSize`, `iconAlignment`. It downcasts to a plain `<i>` element whose
`class` carries the Font Awesome classes:

```html
<i class="fa-solid fa-heart fa-2x fa-pull-left"></i>   <!-- FA6 -->
<i class="fas fa-heart fa-2x"></i>                     <!-- FA5 -->
```

- **Style class** — version-dependent: FA6 `fa-solid|fa-regular|fa-light|fa-thin|fa-duotone|fa-brands|fa-kit`,
  FA5 `fas|far|fal|fad|fab|fak` (FA5 has no `thin`).
- **Icon class** — `fa-<icon-name>` (the `iconFA` attribute; names come from the metadata YAML).
- **Size class** — `fa-xs`, `fa-sm`, *(regular = no class)*, `fa-lg`, `fa-xl` (FA6 only),
  then `fa-2x` … `fa-10x`.
- **Alignment class** — none (`With text`), `fa-pull-left`, `fa-pull-right`.

## Editor commands (JS)

Registered by `IconEditing`:

| Command | Purpose |
|---|---|
| `insertIcon` | Insert a new icon (used by the picker) |
| `styleIcon` | Set the `iconStyle` attribute on the selected icon |
| `sizeIcon` | Set `iconSize` |
| `alignIcon` | Set `iconAlignment` |

The balloon toolbar shown when an icon is selected is driven by the `toolbarItems` config
(`iconSize`, `iconAlignment`, `iconStyle`).

## Companion CKEditor plugins

- `IconGeneralHtmlSupport` — keeps icons working when core's General HTML Support (Source
  editing / arbitrary HTML) is active.
- `IconLinkEditing` — lets an icon live inside a `<a>` link without being unwrapped.

## Extending

There is no Drupal-side extension point (no hooks, no plugin manager). To change behaviour you
either build your own CKEditor 5 plugin, or fork/override the `ckeditor5_icons/icon.editor`
library. To change *which* icons are offered, use the `fontawesome` contrib integration
(`custom_metadata: true`) — see [../api/metadata-service.md](../api/metadata-service.md).
