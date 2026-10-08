<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — `seeds_pollination.settings`

Form `Drupal\seeds_pollination\Form\SeedsPollinationSettingsForm` (id `seeds_pollination_settings`),
route `seeds_pollination.settings` at `admin/config/user-interface/seeds-pollination`. Menu link
in `seeds_pollination.links.menu.yml` under `system.admin_config_ui`. The route's
`_permission: "administer seeds pollination settings"` is **not defined by any shipped
`*.permissions.yml`**, so no role can be granted it and only user 1 (who bypasses access) reaches
the form. There is **no `config/schema/`** directory, so the settings object is schema-less
(config export works but reports "no schema").

## Config object `seeds_pollination.settings` (keys)

Install defaults live in `config/install/seeds_pollination.settings.yml`. Form-managed keys
(`buildForm`/`submitForm`):

- `display_unmasquerade_button` (checkbox, default `1`) — show the floating un-masquerade eye.
- `disable_user_1_edit` (checkbox) — forbid editing user 1 (see hooks/features.md).
- `show_description_for_config_entities` (checkbox) — master switch for the config-entity
  description feature; gates the three keys below and the `hook_entity_type_alter` list-builder
  swaps.
- `description_is_required_for_config_entities` (checkbox, default `1`) — make that description
  required (adds `seeds_pollination_description_validate`, min 20 chars).
- `description_config_entities_include` (textarea in the form, **stored as an array**) — entity
  type ids the feature applies to. `submitForm` strips spaces and `explode(',')`s the textarea;
  install default array: `webform, taxonomy_vocabulary, view, media_type, node_type,
  entity_queue, user_role, field_config, paragraphs_type, entity_form_display`.
- `small_letters_extension` (checkbox) — force lowercase upload extensions
  (`hook_file_validate`).

`submitForm` does `cleanValues()` then loops all values into the config, special-casing
`description_config_entities_include` into an array — so any other value posted would also be
written; only the fields the form builds are present.

## Related config object `seeds.container_settings`

Not owned by this form. `hook_form_alter` / `container_settings_form_submit` read and write keys
`{bundle_of}_{bundle_id}` (boolean) on it as bundle forms are saved. It is fetched with
`getEditable(...)` and is expected to be provided by the Seeds profile.

## Install / update notes (`seeds_pollination.install`)

Update hooks enable defaults over time: `8103` sets `display_unmasquerade_button`, `8104`/`8105`/
`8106` (re)seed the config from the install YAML, `8107` sets `small_letters_extension`, `8108`
sets `disable_user_1_edit` and **uninstalls the standalone `disable_user_1_edit` module** if
present, `8102` writes a starter `translations.yml` at the Drupal root, `8101` installs
`seeds_development` when `views_ui` is on, `8109` copies `drush.yml` into a project-level
`drush/` dir.
