<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers Eulerian analytics as a service in the Tarte au citron consent manager so the Eulerian tag loads only after the visitor consents.

---

Tarte au citron Eulerian is a small bridge module (package GDPR) between two other contrib modules: Eulerian
(the analytics tag) and Tarte au citron (the consent manager). It adds a single Tarte au citron service plugin,
`eulerian-analytics`, so Eulerian appears as a consent-gated service. By default the Eulerian collect tag and its
`etuix` cookie are prevented from firing on page load and are only built and pushed once the visitor gives
consent through the Tarte au citron banner. An admin can flip a per-service "Need consent" checkbox to instead run
Eulerian without consent (relying on Eulerian's TCFv2 CMP feature for GDPR compliance). The module has no settings
form, routes, permissions, entities or config of its own; its one plugin setting lives inside the Tarte au citron
module's `tarte_au_citron.settings` config, and the Eulerian collect domain/datalayer come from the base Eulerian
module via `drupalSettings.eulerian`. It is purely client-side glue with no access-control role.

---

- Make Eulerian analytics consent-compliant on a Drupal site that already uses Tarte au citron.
- Load the Eulerian tracking tag only after the visitor accepts consent in the Tarte au citron banner.
- Block the Eulerian `etuix` cookie from being set before consent is given.
- Add "Eulerian Analytics" to the list of services Tarte au citron gates.
- Support GDPR / ePrivacy compliance for third-party analytics.
- Prevent the `eulerian/init` library from firing the tag on page load when consent is required.
- Optionally run Eulerian exempt from consent using Eulerian's TCFv2 CMP feature (via the "Need consent" checkbox).
- Keep the Eulerian collect domain configured once in the base Eulerian module and reuse it here.
- Push the Eulerian datalayer built by the Eulerian module only after consent is granted.
- Wire Eulerian into an existing cookie-consent workflow without writing custom JavaScript.
- Re-trigger Eulerian consent handling on Tarte au citron `close_alert` / `close_panel` events.
- Provide a consent-manager integration for sites already running the Eulerian module.
- Let editors manage the Eulerian consent service from the Tarte au citron admin screen.
- Disable the module and clear caches to restore Eulerian's default (immediate) tag loading.
- Document to visitors, via Tarte au citron's UI, that Eulerian sets the `etuix` cookie.
- Combine Eulerian's analytics datalayer (products, orders, custom params) with consent gating.
- Meet CNIL guidance where Eulerian may be exempted from consent when properly configured.
- Standardise consent handling for Eulerian across multiple Drupal sites.
- Ensure the Eulerian tag respects the same consent categories as other Tarte au citron services.
- Test the consent flow as an anonymous visitor before enabling analytics in production.
