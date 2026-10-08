<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wires the Klaro consent manager into Mautic Audiences so that visitors who have not consented to the configured Klaro app resolve to an empty audience.

---

This optional submodule connects the Klaro Consent Manager to the base Mautic Audiences resolver's consent gate. Klaro stores each visitor's consent choices client-side in a single JSON cookie (default name `klaro`, e.g. `{"mautic":true,...}`). The submodule's `mautic_audiences_klaro.consent_check` service reads that cookie server-side, looks up the configured Klaro app id, and returns the boolean. You point `mautic_audiences.settings:consent_callback` at that service, and from then on the resolver consults it before returning any audience — an absent, malformed, or not-yet-decided cookie counts as no consent (privacy by default). A small settings form lets you choose which Klaro app id governs resolution, populated from the Klaro app config entities on the site. When a visitor changes their mind in the Klaro dialog, the cookie updates and the next request flips the audience; the existing `mautic_audience` cache context invalidates naturally because the audience hash changes. It requires the base module and the Klaro module.

---

- Gate all Mautic audience resolution on the visitor's Klaro consent state.
- Return an empty audience for visitors who have not consented to profiling (GDPR-friendly default).
- Pick which Klaro app id controls resolution from a dropdown of the site's Klaro apps.
- Fall back to a free-text app id field when Klaro app entities are not yet created.
- Read Klaro's client-side consent cookie server-side without extra JavaScript.
- Handle both plain-boolean and richer (`{"consent":true}`) Klaro cookie value shapes.
- Support a custom Klaro cookie name (read from Klaro's own `library.cookie_name` setting).
- Flip audiences immediately when a visitor updates consent mid-session, with cache fragmenting automatically.
- Wire the gate with a single `drush cset mautic_audiences.settings consent_callback mautic_audiences_klaro.consent_check`.
- Revert to ungated behaviour instantly by clearing `consent_callback` and uninstalling the submodule.
- Serve as a reference pattern for wiring other consent managers (eu_cookie_compliance, OneTrust) via their own callback services.
