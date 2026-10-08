<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webshare — configuration, platform storage & admin forms

## Install / enable
`drush en webshare`. Depends on `path_alias` (core). `hook_install()` (`webshare.install`) creates
the `webshare_platforms` table and calls `_webshare_migrate_default_platforms()` to seed it from the
`webshare.settings:buttons` config. Update hooks: `8001` (create table + migrate), `8002` (reorder
defaults to LinkedIn, Facebook, X, WhatsApp, Copy), `8003` (migrate `alignment` left/right → logical
start/end), `8004` (initialise empty `icon_map` / `native_share_icon`).

## Platform storage — the `webshare_platforms` table
Enabled platforms are stored **in the database, not in config**. `hook_schema()` defines
`webshare_platforms` with fields: `id` (serial PK), `platform_id` (unique machine name), `name`,
`title` (hover/tooltip), `enabled` (tinyint, default 1), `image` (icon path), `weight`,
`url_template` (share URL, may be NULL/empty), `is_custom` (tinyint), `created`, `updated`. Index
`enabled_weight` on `(enabled, weight)`.

## PlatformManager (`webshare.platform_manager`, `src/PlatformManager.php`)
The single write path used by **both** the admin forms and the config-action plugins, so a platform
changed by a recipe is validated and cached identically to one changed in the UI. Constructor args:
`@database`, `@datetime.time`. Methods:
- `loadPlatform(string $platformId): ?object` — one row or NULL.
- `savePlatform(array $values): void` — insert or update. Editing only touches keys present in
  `$values` (omitted keys keep their stored value). Adding requires `platform_id`, `name`, `title`;
  new rows get `is_custom = 1`. Validates a non-empty `url_template` against
  `/^(https?:\/\/|mailto:)/i` (throws `\InvalidArgumentException` otherwise); `[url]`/`[title]`
  placeholders are optional. Empty template = copy-to-clipboard mode.
- `setPlatformEnabled(string $id, bool)`, `deletePlatform(string $id)` — require the row to exist.
- `reorderPlatforms(string[] $ids)` — assigns each listed id its list index as `weight`.
- `setPlatforms(array $platforms)` — desired-state: saves + enables + weights every listed
  platform by position, and **disables** (not deletes) every unlisted one.

Every mutating method calls `Cache::invalidateTags(['webshare_platforms'])`.

## Settings form (`Form/WebshareConfigForm`, route `webshare.config_form`)
Path `admin/config/services/webshare`, permission `administer webshare`, menu link under
System → Services. A `ConfigFormBase` editing `webshare.settings`. Renders a `#tabledrag` table of
all platform rows (name, enabled checkbox, weight, edit/delete operations as AJAX modal links) plus
an "Add Custom Platform" link. `submitForm()` writes back the `enabled` + `weight` of each row
directly via `->update('webshare_platforms')` and invalidates the `webshare_platforms` cache tag.
(Row edits/adds/deletes are done through the separate platform routes below, which go through
`PlatformManager`.)

## Platform add / edit / delete routes
- `webshare.platform_add` — `admin/config/services/webshare/platform/add`, `Form/PlatformForm`.
- `webshare.platform_edit` — `.../platform/{platform_id}/edit`, `Form/PlatformForm`.
- `webshare.platform_delete` — `.../platform/{platform_id}/delete`, `Form/PlatformDeleteForm`
  (a `ConfirmFormBase`).

All three require `administer webshare` and are `_admin_route: TRUE`, opened as AJAX modals from the
settings table.

### PlatformForm
Fields: `name` (required), `platform_id` (`machine_name`, disabled when editing), `title`
(required, hover tooltip), `url_template` (maxlength 512), `icon` (`managed_file`, upload to
`public://webshare/module_icons/`, validators `png svg jpg jpeg`), `enabled`, `weight`.
`validateForm()` requires an icon for **new** platforms and re-checks the `url_template` scheme.
`submitForm()` promotes the uploaded file to permanent, then **copies it into the module's own
`img/` directory** (`DRUPAL_ROOT/<module path>/img/<filename>`) and stores that relative path as
`image`, then delegates to `PlatformManager::savePlatform()`. AJAX callbacks close the modal and
redirect back to `webshare.config_form`.

## Config object `webshare.settings` (schema `config/schema/webshare.settings.schema.yml`)
A `config_object`. Keys:
- `buttons` — sequence of `webshare.image_button` (`name`, `title`, `enabled`, `image`, `weight`),
  the **legacy fallback** used only when the DB table is empty/missing (early bootstrap, 1.x
  upgrades). Ships 13 platforms; LinkedIn/Facebook/X enabled, the rest disabled.
- `icon_map` — sequence of `webshare.icon_reference` (`pack`, `icon`) keyed by platform id;
  maps a platform to a Drupal Core Icons API icon. Empty by default.
- `native_share_icon` — a single `webshare.icon_reference` for the native share button icon.

The schema file also declares `block.settings.share` (the Share block's settings, `FullyValidatable`
for Drupal Canvas) — see [../blocks/share.md](../blocks/share.md).

## Icons
The module is icon-library agnostic. By default it renders the bundled SVGs under `img/`
(`linkedin.svg`, `facebook-share.svg`, `x.svg`, `whatsapp.svg`, `copy-url.svg`, `email.svg`,
`telegram.svg`, `reddit.svg`, `pinterest.svg`, `threads.svg`, `bluesky.svg`, `tumblr.svg`,
`mastodon.svg`, `share-icon.svg`). If `icon_map[<platform>]` (or `native_share_icon`) names a `pack`
+ `icon` and that pack is registered with the Icons API (`plugin.manager.icon_pack`, core 11.1+ or
`ui_icons`), `WebshareService::renderIconHtml()` renders it via `#type: icon` and it takes
precedence over the bundled SVG.
