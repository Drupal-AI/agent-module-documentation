<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AT Internet SmartTag for TacJS registers the AT Internet (Piano) SmartTag analytics service as a consent-managed tag inside the TacJS (tarteaucitron.js) tag-and-consent manager.
---
The module is a thin bridge between the `atsmarttag` and `tacjs` modules. `hook_tacjs_content_alter()` declares an `atinternet_smarttag` entry in the TacJS `analytic` group so the SmartTag appears in the consent manager's list of services, and `hook_page_attachments()` attaches the `atsmarttag_tacjs` JS library on every non-admin page. The JS registers an `atinternet_smarttag` tarteaucitron service whose `js()` callback calls `Drupal.atsmarttag.createTagAndDispatch(drupalSettings.atsmarttag)` only after the visitor grants consent, and it overrides the default `Drupal.behaviors.atsmarttag.attach` with a no-op so the tag never fires outside the consent layer. This supports GDPR-style opt-in gating of AT Internet tracking.

It has no routes, permissions, configuration objects, config schema, services, or PHP classes of its own. The SmartTag site/tracking parameters come from the `atsmarttag` module (exposed as `drupalSettings.atsmarttag`) and all consent behaviour and enablement come from `tacjs`. There are no secrets and no server-side external calls in this module — it only wires client-side tag loading through the consent layer, and the operator simply enables the "AT Internet SmartTag" service in the TacJS configuration.
---
- Register AT Internet SmartTag as a consent-managed service in TacJS.
- Gate AT Internet / Piano Analytics tracking behind TacJS consent.
- Show the SmartTag in the TacJS consent banner's analytics group.
- Attach the SmartTag JS only on non-admin (front-end) pages.
- Support GDPR-style opt-in for AT Internet analytics cookies.
- Combine AT Internet with other TacJS-managed tags in one banner.
- Load tracking only after the visitor accepts the analytics category.
- Keep the admin UI free of tracking scripts (admin routes are skipped).
- Reuse existing `atsmarttag` module configuration unchanged.
- Integrate Piano Analytics (formerly AT Internet) with cookie consent.
- Present the "AT Internet (SmartTag)" service label in the consent list.
- Comply with cookie-consent requirements for analytics tags.
- Prevent AT Internet cookies (atidvisitor, atuserid, atsession, etc.) firing before consent.
- Bridge the `atsmarttag` and `tacjs` modules with no custom code to maintain.
- Manage AT Internet as a single entry inside a central tarteaucitron tag manager.
- Override the default atsmarttag auto-attach so the tag never fires unconditionally.
- Let editors toggle AT Internet tracking on/off from the TacJS services list.
- Provide the AT Internet privacy-centre link to visitors inside the consent banner.
- Route consent revocation to remove the AT Internet tracking cookies.
- Deploy consent-gated AT Internet analytics on a multilingual or multi-domain site alongside TacJS for Domains.
