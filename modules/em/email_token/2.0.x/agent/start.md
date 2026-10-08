<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Token (email_token) — agent index
**Provides three global `[etf:*]` tokens (page title, page URL, mailto "mail me" link) and a matching text-format filter.**

- **Version:** 2.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Tokens:** `[etf:gin-title]`, `[etf:gin-url]`, `[etf:gin-email]` (see `email_token.tokens.inc`)
- **Filter plugin:** `email_token` ("Email Token Filter", TYPE_TRANSFORM_IRREVERSIBLE) in `src/Plugin/Filter/EmailToken.php`
- **Routes/permissions/services:** none; enable the filter at `/admin/config/content/formats`.
- **Security:** no routes, no permissions, no mutating endpoints; output is emitted through a text filter, so it inherits the text-format's own access gating. The mailto link is a fixed body string plus current title/URL.