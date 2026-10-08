# Legacy → core settings migration

The 3.x branch drops the module's own format-restriction and moves any legacy data into
core's `allowed_formats` field setting (available since Drupal 10.1). Nothing to call —
it runs automatically.

## Triggers
- **`allowed_formats_field_config_presave(FieldConfigInterface $field_config)`** — on every
  field-config save, calls `_allowed_formats_convert_formats2core()` for backwards
  compatibility with unconverted config.
- **`allowed_formats_post_update_formats2core()`** — batched `ConfigEntityUpdater` pass over
  all `field_config` entities (run via `drush updb`).
- **`allowed_formats_post_update_store_allowed_formats_as_sequence()`** — earlier update that
  normalized legacy checkbox-array storage into a clean sequence.

## Conversion logic (`_allowed_formats_convert_formats2core`)
1. Skips fields with no `allowed_formats` key in `third_party_settings`.
2. Reads `allowed_formats.allowed_formats`, runs `array_values(array_filter(...))` to drop
   the old `['fmt' => '0', 'fmt2' => 'fmt2']` checkbox form.
3. `$field_config->setSetting('allowed_formats', $formats)` (core field setting takes
   precedence in the form) and `unsetThirdPartySetting('allowed_formats', 'allowed_formats')`.

The `hide_help` / `hide_guidelines` widget settings are **not** touched by migration — they
remain the module's own feature. See [../configure/widget-settings.md](../configure/widget-settings.md).
