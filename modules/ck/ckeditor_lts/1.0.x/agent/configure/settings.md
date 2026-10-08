# Configure: CKEditor 4 - LTS settings & license key

The module ships one dedicated settings page, plus the usual per-text-format editor
configuration inherited from the CKEditor 4 editor plugin.

## The settings page

| Item | Value |
|------|-------|
| Route | `ckeditor.lts.settings` |
| Path | `/admin/config/ckeditor-lts/settings` |
| Permission | `administer site configuration` (core) |
| Form class | `Drupal\ckeditor\Form\SettingsForm` (extends `ConfigFormBase`) |
| Form id | `ckeditor.lts.settings` |
| Menu link | `ckeditor.lts.form.settings` (parent `system.admin_config_content`, weight 20) |
| Config object | `ckeditor.lts.settings` |

### Fields

| Config key | Type | Notes |
|------------|------|-------|
| `license_key` | string | Textfield, `#maxlength` 512, not required. If non-empty it must be at least **48 characters** (`SettingsForm::LICENSE_KEY_MIN_LENGTH`), else the form sets an error. Trimmed on save. |

There is no separate "clear cache" config value — the **Clear cache** button under the
"Advanced settings" details element runs the `::clearUserCache` submit handler, which calls
`apcu_clear_cache()` / `wincache_ucache_clear()` if available and shows a "Cache cleared."
status message. Its purpose is to flush the PHP user/opcode cache after swapping from the old
core `ckeditor` module to this one.

On normal save (`submitForm`) the form writes the cleaned values to `ckeditor.lts.settings`
and invalidates the cache tags `ckeditor_plugins`, `editor_plugins`, `filter_plugins`.

## Set the license key without the UI

Drush:

```
drush config:set ckeditor.lts.settings license_key 'YOUR-48-CHAR-OR-LONGER-LICENSE-KEY' -y
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('ckeditor.lts.settings')
  ->set('license_key', 'YOUR-48-CHAR-OR-LONGER-LICENSE-KEY')
  ->save();
```

Read it back through the module's service (see [api/integration.md](../api/integration.md)):

```php
$key = \Drupal::service('ckeditor.lts.config_handler.settings')->getLicenseKey();
```

## Where the key goes

`Drupal\ckeditor\Plugin\Editor\CKEditor::getJSSettings()` injects the stored value as the
`licenseKey` entry of the CKEditor JavaScript settings for every text format that uses the
`ckeditor` editor, so the bundled CKEditor 4 build can initialise. If no key is set,
`getLicenseKey()` returns `NULL` and `licenseKey` is passed as null.

## Per-text-format editor configuration

Toolbar and plugin settings are configured per text format at
`/admin/config/content/formats/manage/<format>` (core `filter`/`editor` UI), not on the page
above. Those values are stored on the `editor` config entity and validated by the schema
`editor.settings.ckeditor`:

- `toolbar.rows[][].name` + `toolbar.rows[][].items[]` — button groups and buttons per row.
- `plugins.<plugin_id>` — per-plugin settings, e.g. `ckeditor.plugin.language` (`language_list`)
  and `ckeditor.plugin.stylescombo` (`styles`).

## Config schema (`config/schema/ckeditor.schema.yml`)

- `ckeditor.lts.settings` — `config_object` with `license_key: string`.
- `editor.settings.ckeditor` — the per-format toolbar/plugins mapping described above.
