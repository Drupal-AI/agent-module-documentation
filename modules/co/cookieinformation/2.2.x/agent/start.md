# Cookie Information — agent index

Injects the third-party Cookie Information (cookieinformation.com) consent popup site-wide, with
optional Google Consent Mode (v1/v2), IAB TCF, and client-side iframe blocking. Requires a Cookie
Information subscription/template on their platform. Depends on core `path_alias`.

- **Settings form keys, visibility/exclusion logic, GCM, iframe blocking, permissions** →
  [configure/settings.md](configure/settings.md)
- **The two blocks (Cookie Policy, Privacy Controls) and their access rules** →
  [plugins/blocks.md](plugins/blocks.md)

Key facts:
- Config route `cookieinformation.settings` → `/admin/config/system/cookie-information`
  (permission `administer cookie information settings`). Config object `cookieinformation.settings`.
- Popup script (`.../uc.js`) attached in `cookieinformation_page_attachments_alter()` when
  `VisibilityService::checkAll()` passes; `data-culture` from `LanguageService` (validated culture list).
- Permissions: `administer cookie information settings`, `disable cookie information consent`
  (the latter suppresses the popup for any non-UID-1 user holding it).
- Blocks: `cookieinformation_cookie_policy_block`, `cookieinformation_privacy_controls_block`.
- Ships no secret; only fixed vendor script URLs are injected.
