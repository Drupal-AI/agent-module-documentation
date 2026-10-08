<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Iframe field formatter & its settings

`Drupal\link_iframe_formatter\Plugin\Field\FieldFormatter\LinkIframeFormatter`
(id `link_iframe_formatter`, label **"Iframe Formatter"**) — a subclass of core's
`Drupal\link\Plugin\Field\FieldFormatter\LinkFormatter` for **`link`** fields. Select it on a link
field's **Manage display** tab (Structure → your content type → Manage display). There is no admin
config page; all configuration is the formatter's own settings, stored under config schema
`field.formatter.settings.link_iframe_formatter`.

## Settings (`defaultSettings()`, `LinkIframeFormatter.php:25`)

| Key | Type / form element | Default | Effect |
| --- | --- | --- | --- |
| `width` | textfield, required | `640` | iframe `width` attribute |
| `height` | textfield, required | `480` | iframe `height` attribute |
| `disable_scrolling` | checkbox | `FALSE` | when on → `scrolling="no"`, else `scrolling="yes"` |
| `class` | textfield, optional | `''` | extra value put in the iframe `class` attribute |
| `original` | radios On/Off | `FALSE` | when On, prints a "You may view the original link at:" `<a>` below the frame |

`settingsForm()` (`LinkIframeFormatter.php:38`) builds those five elements; `settingsSummary()`
(`:83`) prints one line: `Width: …, Height: …, Scrolling: yes/no, Class: … , Original link is On/Off`.
`width`/`height` are plain textfields (no numeric validation) — but the schema types them as `integer`
and the values are auto-escaped in the template, so a non-numeric value cannot break out of the attribute.

## Rendering (`viewElements()`, `LinkIframeFormatter.php:98`)

For each field item it calls the inherited `buildUrl($item)` (core `LinkFormatter`) to get a
`Drupal\Core\Url` object, then builds a render array with `#theme => 'link_iframe_formatter'` and the
settings as `#width`, `#height`, `#scrolling` (already resolved to `'yes'`/`'no'`), `#class`,
`#original`, `#url` and `#path` (both the same `Url`). The template turns that into:

```html
<iframe width="{width}" height="{height}" src="{url}" class="{class}"
        frameborder="0" scrolling="{scrolling}" allowfullscreen></iframe>
```

The `src` is the editor-entered link value. It is **not** raw-printed: the template auto-escapes it,
and `buildUrl()` wraps core `Url::fromUri()`/`getUrl()` in a try/catch that falls back to route
`<none>` when the URI is invalid — and core `Url::fromUri()` itself rejects `javascript:` / `data:`
schemes, as does the link field's own `LinkExternalProtocols` validation constraint at save time. So
the formatter renders whatever host the URL points at, but cannot be coerced into a scripting-scheme `src`.

## Setting it programmatically

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'page');           // or your entity type/bundle/view mode
$display->setComponent('field_my_link', [
  'type' => 'link_iframe_formatter',
  'settings' => [
    'width' => 800,
    'height' => 450,
    'disable_scrolling' => TRUE,
    'class' => 'responsive-embed',
    'original' => TRUE,
  ],
])->save();
```

To change the markup (add `sandbox`, `loading="lazy"`, a `title`, `referrerpolicy`) override the
template — see [../theming/link_iframe_formatter.md](../theming/link_iframe_formatter.md).
