<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the accessibility statement

**Form:** `Drupal\accessibility_statement\Form\AccessibilityStatementForm`
**Route:** `accessibility_statement.settings` — `/admin/config/system/accessibility-statement`
**Permission:** `administer accessibility statement` (restricted).

## Statement type
Pick one of two legal frameworks; the form shows conditional fields per type:
- **Public sector body** — EU Directive 2016/2102 / BITV 2.0 (adds an enforcement / arbitration body section).
- **Product or service** — European Accessibility Act 2019/882 / German BFSG (adds a market surveillance authority section).

## Key fields
- **Page path** — default `/accessibility-statement`; change to any path (e.g. `/barrierefreiheitserklaerung`). A `RouteSubscriber` rewrites the public route from config, so a cache rebuild may be needed after changing it.
- **Conformance status** — fully / partially / not conformant, measured against EN 301 549, WCAG 2.1 AA or WCAG 2.2 AA.
- **Non-accessible content items** — repeatable rows grouped by category (non-compliance, disproportionate burden, out of scope), added/removed via AJAX.
- **Contact section** — name, email, phone (rendered as a sanitized `tel:` link), postal address.
- **Enforcement / market-surveillance body** — shown per statement type.

## Output
The public page (`AccessibilityStatementController::page`, `_access: 'TRUE'`) renders semantic HTML from config only — no user input is stored or reflected. A footer menu link (`Accessibility`) is added on install. Override `accessibility-statement.html.twig` in your theme to restyle.
