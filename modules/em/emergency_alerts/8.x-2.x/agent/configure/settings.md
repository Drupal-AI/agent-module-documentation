<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Emergency Alerts

1. Enable the module; configure at `/admin/config/emergency_alerts` (permission `administer emergency_alerts`).
2. Set **title**, **message** (rich text) and **alert level** (`announcement`, `warning`, `danger`).
3. Choose display:
   - **Block:** place the `Emergency Alert` block at `admin/structure/block` (add an `emergency_alert` region to your theme if desired).
   - **Full page:** enable the `override` setting → a `html__emergency_alert` template suggestion is applied on non-admin routes.
4. Style via classes `.emergency-alert.announcement | .warning | .danger`.
5. Optionally copy `emergency-alert.html.twig` and `html--emergency-alert.html.twig` into your theme and customize (keep the `page.emergency_alert` region).

Dismissal: the `persist_close` JS library lets users close the alert and remembers it.

Note: the message is admin-authored rich text rendered as markup — grant `administer emergency_alerts` only to trusted editors.
