<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Pigeon paywall

## Global settings — `/admin/config/services/pigeon-paywall`
Requires `administer pigeon paywall`. Fields:
- **Subdomain / account** — Pigeon hostname; `pigeon.js` is rewritten to `//<subdomain>/c/assets/pigeon.js`.
- **Fingerprint** — browser fingerprint to reduce cookie-removal fraud (soft paywall).
- **IDP** — enable when the Pigeon subdomain is on a different domain context.
- **Only show on published content** — gate the paywall to published entities.
- **Paywall bypass query argument** — the URL arg used for per-entity bypass codes (default `pigeon`).

## Per-entity setup
1. Add a **boolean** field to the bundle; check it on entities that should be paywalled.
2. On the "full" view mode, use the **Pigeon Paywall controller** (`pigeon_paywall_checkbox`) formatter.
3. Optionally add a plain-text **bypass code** field and select it in the formatter settings.
4. In the entity template, add `pigeon-remove` to the region to hide and a hidden
   `pigeon-context-promotion` teaser (with an optional `pigeon-open` link).

## How enforcement actually works (important)
`viewElements()` returns the normal rendered content and only `#attached` a JS library plus
`drupalSettings.pigeon` (entity id/title/created). The Pigeon script client-side removes the
`pigeon-remove` DOM for non-subscribers. **The full protected content is already in the page HTML**
for anonymous visitors — there is no server-side access check. Treat Pigeon as engagement/soft
gating, not as protection for genuinely restricted content.

## Bypass code
If a bypass field is set and the URL carries `?<bypass_query_arg>=<code>` matching the entity's
stored code (loose `==` comparison), the formatter returns early and the paywall JS is not attached.
