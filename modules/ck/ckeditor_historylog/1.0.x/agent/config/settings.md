<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-text-format settings, schema & PHP→JS config bridge

## Enable / configure

There is **no admin settings page**. `drush en ckeditor_historylog` (pulls core `ckeditor5`),
then edit a text format at `/admin/config/content/formats`, and drag the **History Log** button
onto that format's CKEditor 5 toolbar. A settings vertical-tab for the plugin then appears
(rendered by `HistoryLog::buildConfigurationForm()`). Settings are stored per text format under
`settings.plugins.ckeditor_historylog_button` in the editor config entity.

## The PHP plugin

`src/Plugin/CKEditor5Plugin/HistoryLog.php` extends `CKEditor5PluginDefault`, implements
`CKEditor5PluginConfigurableInterface` (via `CKEditor5PluginConfigurableTrait`). Declared in
`ckeditor_historylog.ckeditor5.yml` as `ckeditor_historylog_button` with `class:
\Drupal\ckeditor_historylog\Plugin\CKEditor5Plugin\HistoryLog`, toolbar item `historyLog`,
`elements: false`, condition `toolbarItem: historyLog`.

`getDynamicPluginConfig()` merges the seven stored settings into the editor's JS config as
`config.historyLog.{...}`, so the browser plugin reads them from `editor.config.get('historyLog')`.
`validateConfigurationForm()` casts `waitingTime`, `expireMinutes`, `limit`, `maxSize` to `int`.

## Settings (form / `defaultConfiguration()` / schema)

Schema `config/schema/ckeditor_historylog.schema.yml` →
`ckeditor5.plugin.ckeditor_historylog_button`.

| key | type | PHP default | form field | meaning |
|-----|------|-------------|------------|---------|
| `saveKeyAttribute` | string | `name` | textfield "Field attribute selector" | which attribute of the source `<textarea>` element identifies the editor instance in the storage key (e.g. `id`, `name`, `class`) |
| `waitingTime` | integer | `5000` | number | ms to debounce before autosaving |
| `expireMinutes` | integer | `1440` | number | minutes to keep logs before auto-removal (1440 = 1 day) |
| `limit` | integer | `50` | number | max revisions kept |
| `maxSize` | integer | `256000` | number | max storage size in bytes; if exceeded, half the revisions are dropped |
| `saveBeforeRestore` | boolean | `TRUE` | checkbox | before restoring an old revision, save current content tagged `rollback` |
| `ignoreSameData` | boolean | `TRUE` | checkbox | hide revisions identical to current content from the dropdown |

## Gotcha: PHP defaults override JS defaults, and they differ

`js/ckeditor5_plugins/history_log/src/historylog.js` also defines JS-side defaults via
`editor.config.define('historyLog', {...})`, but `getDynamicPluginConfig()` always sends the PHP
values so the effective values are the PHP/form ones. Two defaults DIFFER between the two layers:

- `saveKeyAttribute`: PHP default `name` vs JS default `id`.
- `waitingTime`: PHP default `5000` vs JS default `2000`.

Additional JS-only config keys (NOT exposed in the Drupal form, so they keep their JS defaults):
`saveKeyPrefix` (`cklog`), `saveKeyIgnoreParams` (`true` — strip URL query when building the key),
`saveKeyDelimiter` (`_`), and the internally-computed `saveKey`. See
[../plugins/history-log.md](../plugins/history-log.md) for how the storage key is assembled.
