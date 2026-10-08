<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Modular Finance integrates the third-party service modularfinance.se by embedding its investor-relations widgets (share price, financial calendars, press releases, etc.) into Drupal pages as blocks.

---

You define reusable "Modular finance type" config entities, each carrying a widget type and a widget token, and a global client token on the settings form. The `modular_finance_block` block plugin lets you place a chosen type; when rendered it attaches the `modular_finance/modular-finance` JS library and pushes the widget token, widget type, current locale and the global client token into `drupalSettings.modularFinance`, keyed by the widget token, so the third-party script can find its `[data-token]` container and render the widget client-side.

Security/operational notes: there is **no server-side HTTP call** in the module — all data fetching happens in the browser via the Modular Finance JS library, so there is no server-side TLS setting to review. The `client_token` is stored in plain module config (`modular_finance.settings`, not a Key entity) and is intentionally rendered into `drupalSettings` (client-side) because it is a publishable widget token; treat it as public, not as a secret. The settings form is gated by the `access administration pages` permission and the type collection/CRUD by entity admin permissions.
---
- Embed a Modular Finance share-price or IR widget as a Drupal block.
- Define reusable widget "types" as config entities with a token and widget type.
- Set the global Modular Finance client token on the settings form.
- Place multiple different Modular Finance widgets on the same page.
- Pass the current interface language as the widget locale.
- Render widgets client-side via the bundled JS library (no server calls).
- Manage widget types through the config-entity collection UI.
- Add, edit and delete Modular Finance types with dedicated forms.
- Key each widget by its token so several blocks coexist on one page.
- Show investor-relations content (calendar, press releases, price) on the site.
- Reuse one widget type across many block placements.
- Localize widget output by placing language-specific blocks.
- Keep widget configuration in exportable Drupal configuration.
- Integrate a financial data provider without custom JS wiring.
- Restrict widget-type administration to entity-admin roles.
- Target a specific container with the `[data-token]` selector.
- Swap the client token in one place for all placed widgets.
