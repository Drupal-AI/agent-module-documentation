<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Redirect to Front (content_redirect_to_front) — agent index

**Redirects the canonical page of selected content types/bundles to the front page, exempting users with a skip permission.**

- **Version:** 9.0.x
- **Core:** ^9 || ^10 || ^11
- **Package:** Other
- **Route:** `content_redirect_to_front.settings` → `/admin/config/content/content_redirect_to_front_settings` (permission `access content_redirect_to_front form`)
- **Permissions:** `access content_redirect_to_front form`, `skip redirecting to front for all content`
- **Service:** `content_redirect_to_front.redirect_subscriber` (`RedirectSubscriber`), `KernelEvents::REQUEST` priority 28; matches `entity.<type>.canonical`, returns `TrustedRedirectResponse` to `/`
- **Config:** `content_redirect_to_front.settings` (`enabled_types`, `bundle_settings`, `message_settings`)

**Security:** settings route permission-gated; the redirect is a read-only navigation control (no data mutation). Redirect targets the local front page only via `TrustedRedirectResponse` (no open redirect).

See [configure/settings.md](configure/settings.md)
