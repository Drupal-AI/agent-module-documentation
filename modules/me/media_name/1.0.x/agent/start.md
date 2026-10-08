# Media Name — agent index

Makes the Media *Name* field optional (when shown on the form) and preserves a custom media
name on file replacement. Depends on core `media`. Provides a config object + schema and a
settings form; no permissions of its own (form gated by core `administer media`); no Drush.

- **The one config flag, the settings form, and the name/file preservation logic** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `hook_entity_base_field_info_alter` + `hook_entity_bundle_field_info_alter` set `media.name`
  `#required = FALSE`.
- `hook_form_media_form_alter` stashes original media/file names in build info and adds
  `_media_name_form_submit`, which restores the custom name when the file changed.
- Config `media_name.settings` → `file_name_override` (boolean, default `FALSE`).
- Service `media_name` (`Drupal\media_name\MediaName`) holds the comparison/restore logic.
