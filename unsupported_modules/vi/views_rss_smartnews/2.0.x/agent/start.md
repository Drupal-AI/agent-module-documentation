<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views RSS: SmartNews (views_rss_smartnews) — agent index
**Adds SmartNews SmartFormat feed elements to Views RSS so a view can output a SmartNews-compliant feed.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10
- **Depends:** views_rss (2.x)
- **Provides:** SmartNews-specific RSS channel/item elements via `views_rss` hooks (`.module` only).
- **Routes / permissions / services:** none.

**Security:** Pure element-definition extension of `views_rss`; no routes, endpoints, outbound calls or secrets. No security findings.
