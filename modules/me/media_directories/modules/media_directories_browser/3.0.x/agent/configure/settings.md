<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `media_directories_browser.settings`

Form: `Drupal\media_directories_browser\Form\BrowserSettingsForm`, route
`media_directories_browser.config_form` → **`/admin/config/media/media_directories/browser`**
(local task **Browser**, weight 10, under the parent module's settings page). Permission
`administer site configuration`.

Every key below ships in `config/install/media_directories_browser.settings.yml` and is typed
in `config/schema/media_directories_browser.schema.yml`.

| Key | Type | Default | Effect |
|---|---|---|---|
| `remember_sort` | bool | `false` | Persist the sort selection in browser local storage. |
| `remember_directory` | bool | `false` | Reopen the last-visited directory. |
| `remember_sidebar` | bool | `true` | Persist sidebar open/closed. |
| `remember_view_mode` | bool | `true` | Persist grid vs list view. |
| `expand_directories_default` | bool | `true` | Expand the whole tree on load. |
| `remember_expanded_directories` | bool | `false` | Persist which folders are expanded. |
| `enable_bulk_actions` | bool | `false` | Show the bulk-edit form for a multi-selection. |
| `bulk_action_fields` | sequence of sequences | `{}` | Per media bundle, the field names offered in the bulk form (`{bundle: [field, field:alt, …]}`). Seeded with `name`, `*:alt`, `*:title` by `update_11002`. |
| `enable_preview_drawer` | bool | `true` | Detail drawer on the full browser page. |
| `enable_preview_drawer_in_modal` | bool | `false` | Also show it inside field-widget / CKEditor modals. |
| `enable_selection_drawer` | bool | `true` | Selection drawer inside field-widget modals. |
| `show_existing_media_in_drawer` | bool | `false` | Pre-fill the selection drawer with the field's current values. |
| `show_directory_counts` | bool | `false` | Media-count badges on directories. |
| `page_size` | integer | `100` | Items per page in the grid. |
| `enable_combined_upload` | bool | `false` | One upload control that routes by file extension. |
| `combined_upload_media_types` | sequence of strings | `[]` | Media type ids included in combined upload. Extension→type map is built in `hook_page_attachments()` from each type's source field `file_extensions`; the **first** type claiming an extension wins. |
| `directory_sort` | string | `alphabetical` | `alphabetical` or `weight`. |
| `experimental_fullscreen` | bool | `false` | Full-screen layout on the admin page (attaches the `fullscreen` library). |
| `experimental_fab` | bool | `false` | Floating add button in the full-screen layout. |
| `experimental_topbar_add` | bool | `false` | Add button in the admin top bar. |
| `translation_types` | sequence of strings | `[]` | Media type ids that get per-language tabs. Only effective when `content_translation` is installed. |
| `enable_file_link_in_link_form` | bool | `true` | Show the file-picker button in the CKEditor link form. |
| `embed_image_styles` | sequence of strings | `{}` | Explicit opt-in list of image styles offered in the CKEditor display dropdown. **No "show all" fallback** — an empty list means no image-style options at all. |
| `media_list_date_format` | string | `''` | Date format id for grid/list items (`''` = default). |
| `details_drawer_date_format` | string | `''` | Date format id in the details drawer. |

Two extra schemas live in the same file:
`ckeditor5.plugin.media_directories_browser_media_file_link` (key `allowedBundles`) and
`filter_settings.media_directories_default_view_mode` (key `view_mode_mapping`).

## Drush recipes

```bash
drush cget media_directories_browser.settings

drush cset media_directories_browser.settings page_size 48 -y
drush cset media_directories_browser.settings show_directory_counts 1 -y
drush cset media_directories_browser.settings directory_sort weight -y

# Sequence values need php:eval (cset can't write arrays).
drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_browser.settings")
    ->set("enable_bulk_actions", TRUE)
    ->set("bulk_action_fields", ["image" => ["name", "field_media_image:alt"]])
    ->set("embed_image_styles", ["large", "medium"])
    ->set("translation_types", ["image"])
    ->save();'
```

No cache rebuild is required for these — they are read per request in
`hook_page_attachments()` — but `drush cr` is harmless.

## Update hooks (what changed and when)

| Hook | Change |
|---|---|
| `update_11001` | adds `show_existing_media_in_drawer` (FALSE) |
| `update_11002` | seeds `bulk_action_fields` per bundle with `name`, `*:alt`, `*:title` |
| `update_11003` | adds `enable_preview_drawer_in_modal` (FALSE) |
| `update_11004` | adds `embed_image_styles`, migrating from the deprecated `media_directories_editor.settings:embed_dialog.image_styles` |
| `update_11005/6/7` | add `experimental_fullscreen`, `experimental_fab`, `experimental_topbar_add` (all FALSE) |

## Where the settings surface at runtime

`MediaDirectoriesBrowserHooks::pageAttachments()` writes
`drupalSettings.mediaDirectoriesBrowser` on **every** page (so the CKEditor integration,
which loads its library from a plugin definition, can read it). Notable derived values:

- `theme` — the active theme name (the app ships `claro`, `gin`, `dark`, `default_admin` themes).
- `uploadLimits` — from PHP/Drupal upload limits.
- `combinedUpload` — `{extensionMap, accept, mediaTypes}` or `null`.
- `mediaTypeTranslationSettings` — `{<type>: {enableTranslations, enableAiTranslations}}`;
  `enableAiTranslations` is always `FALSE` here and is flipped by `media_directories_ai`'s
  `hook_page_attachments_alter()`.
- `enableAiAltText` — same, always `FALSE` here.
- `languages` — non-default site languages, only when at least one type has translations on.
- `siteDefaultLangcode`.

Inspect it live with:

```bash
drush php:eval '
  $a = [];
  \Drupal::service("Drupal\media_directories_browser\Hook\MediaDirectoriesBrowserHooks")->pageAttachments($a);
  print json_encode($a["#attached"]["drupalSettings"]["mediaDirectoriesBrowser"], JSON_PRETTY_PRINT);'
```
