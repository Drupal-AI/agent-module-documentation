<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS Video — agent index

Feature module of the **Acquia CMS** (Acquia Drupal Starter Kit) distribution. Ships a **Video media
type** (`media.type.video`) sourced from core oEmbed (`oembed:video`), restricted to **YouTube** and
**Vimeo**, plus its fields, form/view displays, an extra view mode, and optional Site Studio templates.
No code beyond install/update glue and one role-presave hook. Version **1.6.2**, core `^9.4 || ^10 || ^11`.

Depends on `acquia_cms_common`, core `media` + `media_library`, and `field_group`. No settings page
(`configure` is null); no Drush; no plugin types; no config schema of its own.

- **The Video media type, its oEmbed source/providers, fields, displays, how to change them** →
  [configure/video-media-type.md](configure/video-media-type.md)
- **The 5 media permissions it declares** → [permissions/permissions.md](permissions/permissions.md)
- **Install/update glue + the role-presave-alter hook that auto-grants those permissions** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Media type id `video`, source `oembed:video`, source field `field_media_oembed_video` (string 255,
  required, "Remote video URL"); providers allowlist = `YouTube`, `Vimeo`; thumbnails in
  `public://oembed_thumbnails`; `new_revision: true`, `queue_thumbnail_downloads: false`.
- Bundle also carries `field_categories` and `field_tags` (entity_reference → taxonomy `categories`/`tags`,
  grouped in a "Taxonomy" fieldset via `field_group`); their storages + vocabularies come from
  `acquia_cms_common`. Content translation is enabled on the bundle.
- View displays: `default` (thumbnail + author + created) and `embedded` (oEmbed player, 960×540);
  extra view mode `media.video_component` ("Video component") used by the Site Studio templates.
- Permissions (in `acquia_cms_video.permissions.yml`, `provider: media`): `create video media`,
  `edit own video media`, `delete own video media`, `edit any video media`, `delete any video media`.
- Glue: `hook_install` calls `_acquia_cms_common_editor_config_rewrite()`; hook
  `acquia_cms_video_content_model_role_presave_alter()` grants the media perms to `content_author` /
  `content_editor`; `hook_update_8001/8002` maintain the `config/pack_acquia_cms_video` Site Studio pack.
