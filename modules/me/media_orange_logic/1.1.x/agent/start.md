<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Orange Logic (media_orange_logic) — agent index

**Integrates an Orange Logic (Cortex) DAM with Drupal media via an entity browser widget, media source and field type.**

- **Version:** 1.1.x
- **Core:** ^10.1 || ^11 (dep: media; composer requires `drupal/media_library_extend` + patches)
- **Admin route:** `/admin/config/media/media-orange-logic` (`MediaOrangeLogicAdminForm`, perm `access administration pages,administer orange logic`)
- **AJAX route:** `/media-orange-logic/eb/ajax/selected-assets` (`EntityBrowserController::ajaxSelectedAssets`, perm `access content`)
- **Services:** `media_orange_logic.manager`, `.token.manager`, `.renderer`, `.asset_public_link.manager`
- **Provides:** entity browser widget `OrangeLogicMediaBrowserWidget`, media source `OrangeLogicMediaSource`, field type/widget/formatters
- **Submodules:** `media_orange_logic_samples`, `orange_logic_media_library`

**Security:** admin credential form is permission-gated (`administer orange logic`, restricted). BUT the AJAX route `/media-orange-logic/eb/ajax/selected-assets` is gated only by `_permission: 'access content'` — effectively anonymous — and `EntityBrowserController::ajaxSelectedAssets` (`src/Controller/EntityBrowserController.php`) proxies request-supplied `asset_ids` into a DAM `SystemIdentifier` search (`routing.yml`) using the site's stored DAM token, returning rendered thumbnails/metadata. This lets any 'access content' user enumerate/retrieve DAM asset data with site credentials — review against your DAM's access model. `OrangeLogicManager::search()` also calls `die()` on a Guzzle exception (`src/OrangeLogicManager.php:98`).

See [configure/setup.md](configure/setup.md) and [api/search.md](api/search.md)
