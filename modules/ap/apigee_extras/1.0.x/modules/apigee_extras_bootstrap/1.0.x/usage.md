<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Apigee Extras Bootstrap re-skins the Apigee status_property element as a Bootstrap 5 pill badge, colour-coding each status via a single preprocess hook.

---

This submodule of **Apigee Extras** makes Apigee Edge portal markup Bootstrap 5 compatible. It implements one hook, `apigee_extras_bootstrap_preprocess_status_property()` (in `apigee_extras_bootstrap.module`), which runs on the Apigee Edge `status_property` theme element. The hook reads `$variables['element']['value']`, lower-cases it, and looks it up in a built-in map of status strings to Bootstrap contextual colour classes — active/approved/published/enabled/`1` → `bg-success`, inactive/disabled/`0` → `bg-secondary`, revoked/blocked/deleted/error → `bg-danger`, pending/pending_approval → `bg-warning text-dark`, expired → `bg-dark`, with an unknown-value fallback of `bg-secondary`. It then appends `badge`, `rounded-pill`, the resolved colour class(es) and a BEM modifier `wrapper--status--<status>` to `$variables['attributes']['class']`, so the existing `status-property.html.twig` renders a Bootstrap pill without any template override. It requires a Bootstrap 5-based theme (e.g. the `bootstrap5` contrib theme) to supply the badge styles.

---

- Turn Apigee app/API status labels into Bootstrap 5 pill badges automatically.
- Colour-code an "active" or "approved" app status green (`bg-success`).
- Show "pending" statuses as an accessible amber badge (`bg-warning text-dark`).
- Render "revoked"/"blocked"/"error" statuses in red (`bg-danger`).
- Show "expired" statuses in dark grey (`bg-dark`).
- Show inactive/disabled statuses in muted grey (`bg-secondary`).
- Fall back to a neutral grey badge for any unrecognised status string.
- Keep the Apigee developer portal visually consistent with a Bootstrap 5 theme.
- Style status pills without editing or overriding any Twig template.
- Target a specific status in CSS via the `wrapper--status--<status>` modifier class.
- Pair with a Bootstrap5-based theme to get badges out of the box.
- Combine with Apigee Extras Views to style a status column in a developer-app view.
- Override `status-property.html.twig` in your theme if you need different badge markup.
- Adjust badge classes further via your own `hook_preprocess_status_property()`.
- Provide a drop-in Bootstrap look for Apigee status indicators on portal pages.
- Apply consistent status styling across app, API product and developer status displays.
