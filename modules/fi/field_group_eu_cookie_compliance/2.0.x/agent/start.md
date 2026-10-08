<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Group EU Cookie Compliance (field_group_eu_cookie_compliance) — agent index

**Field Group display formatter that removes a group's child fields from the rendered output unless the visitor accepted a chosen EU Cookie Compliance category.**

- **Version:** 2.0.x (alpha) · **Core:** ^10.3 || ^11
- **Depends on:** `field_group`, `eu_cookie_compliance`
- **Formatter:** `eucookiecompliance` (context: view) — setting `cookie_category`
- **Mechanism:** reads request cookie `cookie-agreed-categories`; if category absent, unsets group children in `preRender()`
- **Cache:** adds context `cookies:cookie-agreed-categories`, sets `max-age = 0`
- **Setup:** disable Internal Page Cache; add `cookies:cookie-agreed-categories` to `required_cache_contexts` (see `services_example.yml`)

**Security:** A display-time privacy gate keyed on a client-supplied cookie, not access control — do not use it to protect sensitive/authorized data. No routes, permissions, services, or config forms of its own.

See [configure/formatter.md](configure/formatter.md).
