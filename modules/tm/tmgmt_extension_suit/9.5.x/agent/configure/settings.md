# TMGMT Extension Suit — settings & config

## Settings form
Route `tmgmt_extension_suit.settings` → `/admin/tmgmt/extension-settings`
(menu tab under `tmgmt.admin_tmgmt`), access `_permission: administer tmgmt`.
Form: `TmgmtExtensionSuitSettingsForm` (a `ConfigFormBase`).

Fields:
- **`do_track_changes`** (checkbox) — stored in config `tmgmt_extension_suit.settings:do_track_changes`
  (schema `tmgmt_extension_suit.settings`, default `true`). Master switch for auto-resubmission of
  edited source content.
- **Per translator + target language** — for each configured TMGMT translator whose plugin implements
  `ExtendedTranslatorPluginInterface`, a details group of per-language checkboxes. These are NOT stored
  in config; the whole `$form_state` values array is written to **state**
  `tmgmt_extension_suit.settings.do_track_changes_by_provider_and_locales` keyed
  `"{translator_id}_{langcode}"`. If none of the configured translators are "extended", a warning shows.

## Default config (`config/install/tmgmt_extension_suit.settings.yml`)
```yaml
do_track_changes: true
```
`tmgmt_extension_suit_init_default_config_values()` (run on `hook_modules_installed` for `tmgmt`) seeds
the state map to enable tracking for every extended translator × non-default language.

## Config schema (`config/schema/tmgmt_extension_suit.schema.yml`)
- `tmgmt_extension_suit.settings` → `do_track_changes` (boolean).
- Action configuration schemas for the 5 bulk actions
  (`action.configuration.tmgmt_extension_suit_*_action`, all `action_configuration_default`), matching
  the shipped `system.action.*` config entities in `config/install`.

## Related state / base fields
- State `tmgmt_extension_suit.settings.do_track_changes_by_provider_and_locales` — the provider+language
  tracking map (see above).
- Base field `tes_source_content_hash` (md5, on `tmgmt_job_item`) and `job_file_name` (on `tmgmt_job`)
  are added programmatically, not via config.

Access to every route/form/action in this module is the TMGMT `administer tmgmt` trust boundary; no
lower-privilege entry points are added.
