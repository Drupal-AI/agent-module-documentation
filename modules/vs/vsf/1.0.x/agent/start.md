<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Voice Search Feature (vsf) — agent index

**Adds a browser Web Speech API microphone to site search, with configurable prompt strings.**

- **Version:** 1.0.x · package Search
- **Core:** ^9 || ^10 || ^11
- **Configure:** `vsf.config_form` → `/admin/config/system/voice-search` (permission `administer site configuration`)
- **Routes:** `vsf.config_form` / `vsf.config_page` (admin), `vsf.search_controller` → `/voice-search-feature/data` (`access content`, no-cache, returns AJAX widget markup)
- **Settings:** `enable_feature`, `speak_now_text`, `listening_text`, `did_not_get_text`
- **Library:** `vsf/vsf_styles`; mic injected via `hook_page_attachments` when enabled

**Security:** speech recognition is client-side (no audio reaches the server). The `access content` data route only renders configuration-derived label text into a template fragment — no server-side search, external fetch or mutation, so not an SSRF/injection surface. Admin config is permission-gated.

See [configure/settings.md](configure/settings.md)
