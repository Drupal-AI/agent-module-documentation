<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mediaflow (mediaflow) — agent index

**Integrates the Mediaflow DAM: browse, import and embed Mediaflow assets in Drupal media.**

- **Version:** 2.0.x
- **Core:** ^10.2 || ^11
- **Depends on:** media, ckeditor5
- **Configure route:** `mediaflow.settings` → `/admin/config/media/mediaflow`
- **Permissions:** `administer mediaflow` (restrict access), `use mediaflow`
- **Routes:** `mediaflow.token` `/mediaflow/token` (`use mediaflow`), `mediaflow.download_media` `/mediaflow/add_media` (`administer mediaflow`)
- **Config object:** `mediaflow.settings` (keys: `client_id`, `client_secret`, `refresh_token`, `set_alt_text`, `allow_crop`, `method`)
- **Services:** `mediaflow.fetcher` (`MediaflowFetcher`, OAuth refresh-token grant + downloads), `mediaflow.usage_manager`, `mediaflow.csp_subscriber`
- **Plugins:** media source `mediaflow`; field type/widget/formatter (`MediaflowItem`); CKEditor5 plugin; FormAPI element `MediaflowSelector`
- **Security:** admin routes permission-gated.

See [configure/mediaflow.md](configure/mediaflow.md)
