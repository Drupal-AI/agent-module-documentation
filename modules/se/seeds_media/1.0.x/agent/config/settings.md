<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, form behaviors & permissions

## Install / enable

`composer require drupal/seeds_media` (pulls `drupal/media_library_edit:^3.0`), then
`drush en seeds_media`. On enable/update, `seeds_media_update_8801()` (`seeds_media.install`)
installs the `is_default` boolean field storage on the `media` entity type. The field is also
declared for fresh installs via `hook_entity_base_field_info()` in `seeds_media.module`.

## Config object `seeds_media.settings`

- Ships `config/install/seeds_media.settings.yml` with `check_media_usability: 1`.
- No config **schema** is shipped (`config/schema/` does not exist), so this key is untyped for
  config export/translation.
- Edited by `SeedsMediaConfigForm` (`src/Form/SeedsMediaConfigForm.php`, form id
  `seeds_media_config_form`) at route `seeds_media.config` → **`/admin/config/seeds-media`**,
  menu link "Seeds Media" under `system.admin_config_media` (Configuration → Media).
  One checkbox: **Check Media Usability** (`check_media_usability`).
- Route permission: **`administer seeds media`** (declared with `restrict access: true`).

## Media image edit form alter

`seeds_media_form_media_image_edit_form_alter()` runs on the `media_image` bundle edit form and
does three things, in order:

1. **Default-media guard.** If `$media->is_default->value` is truthy and the current user lacks
   **`bypass default media access`**, the entire `$form` is *replaced* with a `status_messages`
   error telling the user to remove the media instead of editing it. This is a **form-level UX
   guard only** — it blocks this one edit form, not entity save through other paths (REST, other
   forms, code).
2. **Usability warning.** If `check_media_usability` is on, it calls
   `seeds_media.helper::mediaUseablity($media)` and, when the count exceeds a threshold, adds a
   high-weight (`-1000`) warning that the media is used elsewhere. The threshold is `1` when the
   request query `status == 'current'` (the item you are already editing in a widget) else `0`,
   so the item you are currently working on does not trigger a false warning.
3. **Default checkbox.** If the user has permission **`assign default medias`**, a "Default media"
   checkbox (`default_media`) is added and a submit handler `seeds_media_default_media()` is
   appended, which sets and saves `is_default` on the media.

### Caveat: undeclared permission

`assign default medias` is checked in code but is **not declared** in
`seeds_media.permissions.yml` (which declares only `administer seeds media` and
`bypass default media access`). Unless another module declares it, no role can hold it, so the
"Default media" checkbox never renders on stock installs — the guard in step 1 still works for
media whose `is_default` was set programmatically or by seed config.

## Media library widget alter

`seeds_media_field_widget_form_alter()` targets the `media_library_widget`. For each selected
item themed `media_library_item__widget`, it appends `?status=new` or `?status=current` to the
item's edit-button `href`. `current` is used when the media id is among the field's already-saved
target ids (loaded from the persisted entity). This is what feeds step 2's threshold above. The
appended values are the fixed strings `new`/`current`, not user input.

## Entity-embed link wrapper

`seeds_media_preprocess_entity_embed_container()` (template
`entity-embed-container.html.twig`) wraps the embed children in a `#type => link` when the embed
display settings supply `link_url`. The URL is passed through
`UrlHelper::filterBadProtocol()` and, if not external, treated as `internal:/…`. Set
`link_url_target == 1` in the embed display to add `target="_blank"`.
