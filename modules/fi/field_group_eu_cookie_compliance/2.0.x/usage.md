<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group EU Cookie Compliance adds a Field Group display formatter (`eucookiecompliance`) that renders a group's child fields only when the visitor has consented to a chosen cookie category from the EU Cookie Compliance module.

Configured on an entity's *Manage display* by wrapping fields in a field group and choosing the "EU Cookie Compliance" formatter, then selecting the required cookie category. At render time the formatter reads the `cookie-agreed-categories` request cookie; if it is missing or does not contain the configured category, all child elements of the group are unset so they never reach the page. It adds the `cookies:cookie-agreed-categories` cache context and sets `max-age = 0`, and the module README requires disabling the Internal Page Cache module and adding `cookies:cookie-agreed-categories` to `required_cache_contexts` (see `services_example.yml`) so per-consent variation is respected.

This is a privacy/GDPR display gate — for example, to keep third-party embed fields (YouTube, maps) out of the markup until marketing/statistics cookies are accepted. It is a display-time hide keyed on a client cookie, not an authorization control, so it should not be relied on to protect sensitive data. It has no routes, permissions, services, or admin settings pages of its own; requires Field Group and EU Cookie Compliance.
---
A Field Group formatter that hides grouped fields on view until a chosen EU Cookie Compliance category is accepted.
---
- Hide a group of fields until marketing cookies are accepted
- Gate third-party video embeds behind cookie consent
- Gate map/iframe fields behind consent
- Require a specific cookie category before showing fields
- Wrap analytics/pixel fields in a consent-gated group
- Keep non-consented embeds out of the rendered HTML entirely
- Add the cookies cache context to a field group
- Vary rendered output by the visitor's accepted categories
- Configure the required category per field group
- Comply with GDPR for embedded content
- Combine with other Field Group formatters in the display
- Apply per view mode (teaser, full, etc.)
- Prevent cookie-setting embeds from loading pre-consent
- Use on nodes, media, or any fieldable entity display
- Disable Internal Page Cache to keep consent variation correct
- Set required_cache_contexts to cookies:cookie-agreed-categories
