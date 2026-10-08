<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia CMS Audio (acquia_cms_audio) — agent index

Config/glue module for Acquia CMS (a.k.a. Acquia Drupal Starter Kit). It installs a **SoundCloud-backed
`audio` media type**, its fields, form/view displays, five permissions, and a Site Studio "Audio"
component. **No routes, controllers, services, settings form, or config schema.** Version 1.5.2.
Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Package `Acquia CMS`.

- **The media type, fields, displays, permissions, install hooks, and shipped Site Studio config** →
  [config/media-type.md](config/media-type.md)

## What it actually is

- **Dependencies** (`acquia_cms_audio.info.yml`): `acquia_cms_common`, core `media`, `media_library`,
  `media_entity_soundcloud`, `field_group`. Composer `require`: `drupal/acquia_cms_common`,
  `drupal/media_entity_soundcloud`.
- **Entity provided**: media bundle **`audio`** (`config/optional/media.type.audio.yml`), source
  `soundcloud`, source field `field_media_soundcloud`.
- **Fields**: `field_media_soundcloud` (string, required — the track URL), `field_categories`
  (entity_reference → `categories` vocab), `field_tags` (entity_reference → `tags` vocab, auto-create).
- **Displays**: form displays `default` + `media_library`; view displays `default`, `embedded`,
  `media_library`; plus `embedded` and `media_library` view modes and the `media_library` form mode.
- **Permissions** (`acquia_cms_audio.permissions.yml`, all `provider: media`): `create audio media`,
  `edit own audio media`, `delete own audio media`, `edit any audio media`, `delete any audio media`.
- **Hooks** (no plugins, no Drush):
  - `hook_install($is_syncing)` in `.install` → when not syncing, calls
    `_acquia_cms_common_editor_config_rewrite()` to rewrite the shared CKEditor config.
  - `acquia_cms_audio_content_model_role_presave_alter(RoleInterface &$role)` in `.module` (an
    Acquia CMS Common hook) → grants the create/edit-own/delete-own perms to `content_author` and
    edit-any/delete-any to `content_editor`.
- **Site Studio**: `config/pack_acquia_cms_audio/` ships a Cohesion component `cpt_audio`
  (`cohesion_elements.cohesion_component.cpt_audio.yml`), its sync package, and a preview image —
  all **enforced by `acquia_cms_site_studio`**, not by this module (installed only if that module is present).

## Access model

Audio media is governed entirely by **core Media/entity access** plus the five bundle permissions above.
This module defines **no route access, no `_access: TRUE`, no self-authenticating token**, and makes no
outbound HTTP calls. The SoundCloud URL is stored as a plain string and rendered by
`media_entity_soundcloud`'s `soundcloud_embed` formatter (visual player, 100% × 450px).
