<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feature hooks (`seeds_pollination.module`, `.install`)

Every feature is a procedural hook, guarded by a `seeds_pollination.settings` flag and/or a
`moduleExists()` check, so the module no-ops cleanly when a toggle is off or an optional module is
missing.

## Config-entity descriptions
- `seeds_pollination_form_alter()` — when `show_description_for_config_entities` is on and the
  form's config entity's type id is in `description_config_entities_include`: it either marks the
  entity's native description field required (min 20 chars) or, when none exists, injects a
  `description` textarea whose value is saved as the `seeds_pollination`/`description`
  **third-party setting** by `seeds_pollination_description_submit()`. Special cases: `view`
  (uses `name.description`), `webform` (`general_settings.description`),
  `field_config_edit_form` (adds a separate *Administrative Description* → `admin_description`),
  `entity_form_display` (default mode gets an auto description), and the Views UI
  `views_ui_edit_details_form`.
- `seeds_pollination_description_validate()` — `setError` if `mb_strlen < 20`.
- `seeds_pollination_entity_type_alter()` — when the master flag is on, swaps the list-builder
  class for `field_config`, `entity_queue`, `user_role`, `entity_form_mode` to the module's
  subclasses (`SeedsFieldConfigListBuilder`, `SeedsEntityQueueListBuilder`, `SeedsRoleListBuilder`,
  `SeedsFormModeListBuilder`), each of which adds an `admin_description` column that prints the
  stored third-party setting. (`FieldConfigListBuilder` is an older variant not referenced by the
  alter.)

## Container settings (fluid container per bundle)
- `seeds_pollination_form_alter()` also targets any `EntityForm` bundle form (non-delete, not
  `taxonomy_overview_terms`) that has an `entity.{bundle_of}.canonical` route (excluding
  `block_content`). It adds a *Container settings → Fluid Container* checkbox defaulted from
  `seeds.container_settings[{bundle_of}_{id}]`.
- `container_settings_form_submit()` writes that boolean back to `seeds.container_settings`.

## Un-masquerade button
- `seeds_pollination_preprocess_html()` — when `display_unmasquerade_button` is set and
  `masquerade` is enabled, and the current user is masquerading but lacks `access toolbar`, adds a
  `page_top` link to route `masquerade.unmasquerade` with library `seeds_pollination/unmasquerade`
  (`assets/css/unmasquerade.css`). Cache tag `config:seeds_pollination.settings` and context
  `user.permissions` are attached.

## User-1 edit lock
- `seeds_pollination_user_access()` (`hook_ENTITY_TYPE_access`) — for user id `1`, `update`
  operation, when `disable_user_1_edit` is set, returns
  `AccessResult::forbiddenIf(!$account->hasPermission('You shall not pass ' . uniqid()))`. The
  random permission is never held, so this reliably forbids the edit; otherwise `neutral()`.

## Misc UI/file hooks
- `seeds_pollination_form_node_form_alter()` — hides the node title label and shows it as a
  placeholder on all node forms.
- `seeds_pollination_form_alter()` attaches `root/global-styling` to Layout Builder
  `add_block`/`update_block` modal forms.
- `seeds_pollination_file_validate()` — when `small_letters_extension` is set, lowercases the
  uploaded file's extension by rewriting `$file->destination`.

## Translations importer
- `seeds_pollination_rebuild()` (runs on drush cache-rebuild/deploy) reads `translations.yml`
  from `DRUPAL_ROOT`, and for each `langcode → {source: translation}` calls
  `seeds_pollination_add_translation()` which upserts a `locale` `SourceString` + translation
  (only when `locale` is enabled). Missing file → prints a hint; no error.
