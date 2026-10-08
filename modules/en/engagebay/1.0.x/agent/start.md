<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EngageBay Module (engagebay) — agent index

**Connects Drupal to the EngageBay CRM and embeds EngageBay forms/landing pages through CKEditor.**

- **Version:** 1.0.x
- **Core:** `^10.1 || ^11` — **PHP 7.4**. **Deps:** ckeditor, filter.
- **Configure:** `/engagebay/configure` (`engagebay.settings`, `access administrator pages`).
- **Routes:** `engagebay.home`, `engagebay.settings` (`access administrator pages`); `engagebay.forms_dialog` & `engagebay.landingpage_dialog` (`_entity_access: 'filter_format.use'`).
- **Service:** `EngageBayAPI` (Guzzle, default TLS on) → `https://app.engagebay.com/...`. **Plugins:** CKEditor `Form`, `LandingPage`.
- **Config keys:** `domain`, `email`, `rest_api_key`, `js_api_key` in `engagebay.settings`.

**Access:** Admin/settings routes are permission-gated; dialog routes require `filter_format.use` access. TLS verification is left at Guzzle default (enabled). `.module` does server-side `file_get_contents()` against fixed EngageBay hosts (`<domain>.eb-sites.com`, `share.ebforms.com`) using ids parsed from node body.

See [api/embed.md](api/embed.md).