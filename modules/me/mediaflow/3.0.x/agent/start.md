<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mediaflow (mediaflow) — agent index

**Integrates the Mediaflow DAM: browse, import and embed Mediaflow assets in Drupal media.**

- **Version:** 3.0.x
- **Core:** ^10.2 || ^11
- **PHP:** >=8.1
- **Depends on:** media, media_library, ckeditor5, key
- **Composer:** `drupal/key:^1.0`, `enshrined/svg-sanitize:^0.22`
- **Configure route:** `mediaflow.settings` → `/admin/config/media/mediaflow`
- **Permissions:** `administer mediaflow` (restricted), `use mediaflow` (restricted)
- **Routes:** `mediaflow.token` `/mediaflow/token` (`use mediaflow`), `mediaflow.csrf_token` `/mediaflow/csrf-token` (`use mediaflow`), `mediaflow.download_media` `/mediaflow/add_media` POST (`use mediaflow`, CSRF + flood checked)
- **Config object:** `mediaflow.settings` (keys: `client_id_key`, `client_secret_key`, `refresh_token_key`, `set_alt_text`, `allow_crop`, `allowed_extensions`, `import_limit`, `import_window`)
- **Credentials:** read through Key entities — config stores the Key *id*, not the secret. Env provider uses `MEDIAFLOW_CLIENT_ID` / `MEDIAFLOW_CLIENT_SECRET` / `MEDIAFLOW_REFRESH_TOKEN`. `mediaflow_update_10001` migrates plaintext 2.x values into keys.
- **Services:** `mediaflow.fetcher` (`MediaflowFetcher`, OAuth refresh-token grant + guarded downloads), `mediaflow.usage_manager`, `mediaflow.csp_subscriber`, `mediaflow.svg_sanitizer`, `mediaflow.html_sanitizer`, `mediaflow.selection_validator`, `mediaflow.reference_access`
- **Plugins:** media source `mediaflow`; field type `mediaflow_item` + widget/formatter; CKEditor5 plugin `mediaflow_fileselector`; FormAPI element `mediaflow_selector`; validation constraint `MediaflowAssetReference`
- **Entity:** `mediaflow_asset` (own access handler: `administer mediaflow`, or owner with `use mediaflow`)
- **Notes:** downloads restricted to an HTTPS host allowlist with per-extension/MIME/size/file-validator checks and an executable-extension blocklist; embed HTML and downloaded SVGs are sanitized against a strict allowlist on write and on read; imports are flood-limited per user; the `/mediaflow/add_media` route is CSRF-token protected.

See [configure/mediaflow.md](configure/mediaflow.md)
