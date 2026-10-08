<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & export behaviour

Form `Drupal\config_auto_export\Form\Settings` (`config_auto_export_settings`) at
`/admin/config/development/config_auto_export` (route `config_auto_export.settings`,
`administer site configuration`). All values live in the config object
`config_auto_export.settings` (defaults from `config/install/config_auto_export.settings.yml`).
There is **no `config/schema`** shipped — the settings object is unschemaed.

## Config keys

| Key | Form widget | Default | Meaning |
|---|---|---|---|
| `enabled` | checkbox | `1` | Master switch. Also re-checked by the subscriber's `enabled()`; when off nothing is written or triggered. |
| `directory` | textfield | `temporary://cae` | Stream-wrapper path the `FileStorage` writes exported config into. Any wrapper (`temporary://`, `public://`, `private://`, a real path). Changing it deletes the previous sync dir on submit (`Settings::submitForm` → `FileStorageFactory::removeSync`). |
| `webhook` | textfield (maxlength 1024) | `''` | `base_uri` for the outbound Guzzle POST. Empty ⇒ `triggerExport()` returns `FALSE` (no request). |
| `webhook_params` | textarea (YAML) | `''` | Decoded as YAML → `form_params` (POST body). Supports placeholder substitution (below). |
| `webhook_headers` | textarea (YAML) | `''` | Decoded as YAML → request `headers`. |
| `webhook_autorun_enabled` | checkbox | `1` | When off, automatic (non-forced) `triggerExport()` returns `FALSE`; a forced trigger (manual form, `cae:trigger`) still fires. |
| `delay` | number (min 0) | `60` | `0` ⇒ fire immediately in `destruct()`. `>0` ⇒ store a due timestamp fired by the next cron. |
| `delay_from_first` | checkbox | `false` | When true the due timestamp is set from the *first* event of a burst and not reset by later events, bounding total wait. |

`delay` / `delay_from_first` are only shown (and only relevant) when `webhook_autorun_enabled` is on.

## Placeholders in `webhook_params`

`Service::triggerExport()` (Service.php:346-360) runs `str_replace` over the raw `webhook_params`
string **before** YAML-decoding, substituting:

- `[current user]` → `$this->account->getDisplayName()`
- `[export directory]` → `realpath` of `directory`
- `[config directory]` → `realpath` of `Settings::get('config_sync_directory')`
- `[config split directories]` → `json_encode` of `{split_id: folder}` for every enabled `config_split`

The result is `Yaml::decode()`d; a malformed result logs a `critical` and aborts. The request is
`POST` to `base_uri = webhook` with `form_params` + `headers`. TLS verification is left at Guzzle's
default (on); the webhook URL comes only from stored config, never from a request.

## What gets written, and when

The event subscriber `config_auto_export.config_subscriber`
(`Drupal\config_auto_export\ConfigSubscriber`) writes on every config **save** and **delete**
(`ConfigEvents::SAVE` / `::DELETE`, priority 0), and on language config-override save
(`LanguageConfigOverrideEvents::SAVE_OVERRIDE`, only if the `language` module is installed). It
switches itself off during a config import (`ConfigEvents::IMPORT_VALIDATE`, priority 1024) so
imported changes are not re-exported.

- `enabled()` (ConfigSubscriber.php:170) gates writing: not during installation, `enabled` config on,
  and the directory is preparable (`prepareDirectory(CREATE_DIRECTORY | MODIFY_PERMISSIONS)`) and
  writable — else it `@chmod($uri, 0777)`.
- Each changed config `<name>` is written into the `config_auto_export.storage` `FileStorage`. A
  deletion (cached read returns `FALSE`) is recorded as file `.<name>` with `['status' => 'deleted']`.
- **config_ignore**: `isIgnored()` skips any config matched by `config_ignore`'s `export`/`update`
  rules (only when `config_ignore` is enabled).
- **config_split**: a config that belongs to an enabled split's folder is written into a
  `config_split.<id>` storage collection; for `core.extension`, modules owned by a split are stripped
  from the exported module list.
- After any write, `triggerNeeded` is set and the outbound webhook is scheduled/fired in `destruct()`
  (see [../api/services.md](../api/services.md)).

## Lifecycle

- `hook_cron` → `Service::checkDueDate()` fires a due delayed export.
- `hook_uninstall` → `FileStorageFactory::removeSync()` deletes the export directory.
- `config_auto_export_update_8001` sets `webhook_autorun_enabled = 1` on existing sites.
