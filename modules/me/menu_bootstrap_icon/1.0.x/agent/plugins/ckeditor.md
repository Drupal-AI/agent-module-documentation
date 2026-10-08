# CKEditor 5 Bootstrap Icons plugin

Definition: `menu_bootstrap_icon.ckeditor5.yml` → plugin id `menu_bootstrap_icon_plugins`
(JS `bootstrapIcons.BootstrapIcons`), toolbar item `bootstrapIcons` ("Bootstrap icons"),
class `Drupal\menu_bootstrap_icon\Plugin\CKEditor5Plugin\BootstrapIcons`.

## Enable

On a text format (`admin/config/content/formats/manage/<format>`), drag **Bootstrap icons** into
the CKEditor 5 toolbar. Allowed elements declared by the plugin: `<i>` and `<i class="bi">`.
If "Limit allowed HTML tags" is on, ensure `<i class="bi">` is permitted.

## Configuration form

One setting (schema `ckeditor5.plugin.menu_bootstrap_icon_plugins` → `cdn_bootstrap: boolean`):

| Setting | Default | Meaning |
|---|---|---|
| `cdn_bootstrap` | `false` | Load the Bootstrap Icons font from CDN inside the editor when the admin theme doesn't provide it. |

## How it feeds the picker

`getDynamicPluginConfig()` reads the cached search index `js/iconSearch.json`
(`Json::decode`) and passes it to the JS plugin as `bootstrapicons.search_list`; when
`cdn_bootstrap` is on it also resolves the `icons` library CSS URL and passes it as
`bootstrapicons.cdn` so the font loads inside the editing view. The plugin inserts inline
`<i class="bi bi-…">` elements. Keep the search index current with the settings page's
**Generate** button (see [../configure/settings.md](../configure/settings.md)).
