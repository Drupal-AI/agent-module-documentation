<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings and shipped config

## The settings form

Route `lightning_media.settings` → **`/admin/config/system/lightning/media`**
(menu link under *Configuration → Media*), requirement `_permission: 'administer site
configuration'`. Form class `Drupal\lightning_media\Form\SettingsForm`, form id
`lightning_media_settings_form`. Two checkboxes only.

```yaml
# config/install/lightning_media.settings.yml
entity_embed:
  choose_display: false   # "Allow users to choose how to display embedded media"
revision_ui: false        # "Show revision UI on media forms"
```

```bash
drush config:get lightning_media.settings
drush config:set lightning_media.settings revision_ui true -y
drush config:set lightning_media.settings entity_embed.choose_display true -y
```

Beware: `revision_ui` is consumed in `hook_entity_type_alter()`
(`$entity_types['media']->set('show_revision_ui', …)`), so after changing it from code you
must clear cached entity type definitions — the settings form does this for you via
`entityTypeManager->clearCachedDefinitions()`; from Drush use `drush cr`.

`entity_embed.choose_display` is read by `Drupal\lightning_media\Form\EntityEmbedDialog`
(which replaces core Entity Embed's dialog form through `Routing\RouteSubscriber`): when
FALSE the "display plugin" step is skipped and the media source's preferred display is used.

## Config installed by the module

`config/install/` (always):

| Config | What it is |
|---|---|
| `core.entity_view_mode.media.embedded` | "Embedded" media view mode, used for in-body embeds |
| `core.entity_view_mode.media.thumbnail` | "Thumbnail" media view mode |
| `field.storage.media.embed_code` | `string_long` field used by embed-code media types (tweet, Instagram) |
| `field.storage.media.field_media_in_library` | boolean "Show in media library" |

`config/optional/` (installed only when their dependencies are met):

| Config | Requires |
|---|---|
| `filter.format.rich_text` + `editor.editor.rich_text` | `editor`, CKEditor |
| `pathauto.pattern.media` — pattern `media/[media:bundle:target_id]/[media:mid]` | `pathauto` |
| `user.role.media_creator`, `user.role.media_manager` | `lightning_roles` |

Check what actually landed on a site:

```bash
drush config:get core.entity_view_mode.media.embedded
drush config:get pathauto.pattern.media pattern
drush php:eval 'print implode(",", array_keys(\Drupal::entityTypeManager()->getStorage("user_role")->loadMultiple()))."\n";'
```

## `field_media_in_library` — the per-item library switch

`lightning_media_media_type_insert()` runs for **every** media type created while the module
is enabled (skipped during config sync) and:

1. creates a `field_config` for `field_media_in_library` on that bundle, label
   *Show in media library*, on/off labels *Shown in media library* / *Hidden in media
   library*, default value TRUE;
2. adds a `boolean_checkbox` widget component to that bundle's default form display.

`lightning_media_views_pre_view()` then injects a
`field_media_in_library_value = 1` filter into the `media_library` view's `widget*`
displays — but only if the view does not already configure that filter, and only if the
field exists in the field map.

To hide a media item from the library:

```bash
drush php:eval '
  $m = \Drupal\media\Entity\Media::load(12);
  $m->set("field_media_in_library", FALSE)->save();
'
```

## Third-party image widget settings

`hook_field_widget_third_party_settings_form()` adds two checkboxes to any core
`ImageWidget` (via `ImageWidgetHelper`), stored under
`third_party_settings.lightning_media` on the form-display component:

```yaml
third_party_settings:
  lightning_media:
    file_links: true      # "Show links to uploaded files"
    remove_button: true   # "Show Remove button"
```

Both default to TRUE when absent. Schema key: `field.widget.third_party.lightning_media`.

## Other schema this module owns

`config/schema/lightning_media.schema.yml` also types the two Entity Browser widgets it
provides: `entity_browser.browser.widget.embed_code`
(`target_bundles`, `submit_text`, `form_mode`) and
`entity_browser.browser.widget.file_upload` (the same plus `upload_validators` and
`return_file`).

## Updates

The README documents a Lightning-specific optional config-update runner:

```bash
drush update:lightning
```

It is provided by `lightning_core`, not by this module, and is separate from `drush updb`.
