# Configure — settings form & config object

Form `\Drupal\fluidui\Form\FluidConfigForm` (`ConfigFormBase`, form id `fluidui_settings_form`)
at `/admin/config/fluidui/adminsettings` (route `fluidui.admin_settings_form`,
`_permission: access administration pages`). It edits the single config object
**`fluidui.adminsettings`**. There is **no `config/schema` or `config/install`** — the object
is created the first time the form is saved, so `drush config:get fluidui.adminsettings`
returns nothing until then.

## Config keys

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `admin_display` | checkbox (0/1) | 0 | Also show the toolbox on admin routes (`/admin/*`). When 0, admin pages are skipped. |
| `fluidui_as_block` | checkbox (0/1) | 0 | When 1, the module stops auto-rendering the toolbox in `page_top`; you place it yourself as the `fluidui_block` block (see [blocks/fluidui-block.md](../blocks/fluidui-block.md)). When 0, it renders automatically at the top of every non-admin page. |
| `url_blacklist` | textarea (string, `\r\n`-separated) | — | Paths where the toolbox is hidden. One path per line; matched against both the internal path and its URL alias. A trailing `/*` acts as a prefix wildcard (e.g. `/blog/*` hides it on everything under `/blog`). The blacklist takes precedence over `admin_display`. |

## Where these are read

- `fluidui_preprocess_page()` (in `fluidui.module`) — decides whether to **attach the CSS/JS
  libraries**, honoring `admin_display` and `url_blacklist`.
- `FluidUiHooks::fluiduiPageTop()` (`#[Hook('page_top')]`) — decides whether to **render the
  toolbox markup** (`#theme => fluid_ui_block`), honoring all three keys.

Both add cache contexts `url.path` and `user` to the page.

## Set without the UI

```php
\Drupal::configFactory()->getEditable('fluidui.adminsettings')
  ->set('admin_display', 0)
  ->set('fluidui_as_block', 0)
  ->set('url_blacklist', "/user/*\r\n/node/1")
  ->save();
```

Drush:

```bash
drush config:set fluidui.adminsettings admin_display 1 -y
drush config:set fluidui.adminsettings fluidui_as_block 1 -y
```

Note `url_blacklist` is split on the literal `\r\n` sequence, so lines must be CRLF-separated
(as the textarea produces); a value set with plain `\n` will be treated as one line.
