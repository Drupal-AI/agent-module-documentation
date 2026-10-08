<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alerts Kit is a configuration kit that installs an `alert` content type, an `alert_severity` taxonomy, and a view for authoring and displaying site-alert banners.

---

On install the module imports config (`config/install`, `config/optional`): an `alert` node type with a required `field_severity` taxonomy reference and a `body`, an `alert_severity` vocabulary carrying a `field_color` color field, and an `alerts` view that lists published alerts newest-first. `alerts_install()` (`alerts.install`) seeds three severity terms — Emergency (#C70000), Warning (#E06C00), Notice (#018403). At render time `alerts_views_pre_render()` (`alerts.module`) loops the published severity terms and injects a `<style>` block into the page head defining `.alert-severity-{tid}` background colors from each term's `field_color`, so banners are colored per severity.

The optional `alerts_olivero` submodule attaches its `olivero_display` library to the alerts view, adding Olivero-tuned banner styling and JavaScript that records dismissed banner IDs in the browser's `localStorage` so a dismissed banner stays hidden across pages and later visits. Editors create alerts as ordinary nodes — the `add_content_by_bundle` dependency provides the bundle-scoped "Add Alert" link in the view header — and severity colors are managed by editing the taxonomy terms. There are no custom routes, permissions, entities, or services; access to alert content is governed by standard node and taxonomy permissions and the view's `access content` permission. Version 2.0.x reworks the same configuration as a Drupal recipe.

---
- Install the kit to get an alert content type, severity vocabulary, and listing view in one step.
- Author an alert by adding an `alert` node with a title, body, and severity.
- Choose Emergency / Warning / Notice severity, or add your own terms.
- Add new severity levels by creating `alert_severity` taxonomy terms.
- Set each severity's banner background color via its `field_color` value.
- Display recent alerts through the provided `alerts` view (page at `/alerts`).
- Place the `alerts` Views block near the top of the site to show banners.
- Enable `alerts_olivero` on an Olivero site for header-banner styling plus dismissal JS.
- Let visitors click to dismiss a banner and have it stay hidden via localStorage.
- Reorder severities by taxonomy term weight.
- Restyle banners in a custom theme by mirroring the Olivero submodule's CSS.
- Show alerts chronologically (newest first) out of the box.
- Grant editors the node permissions for the `alert` bundle to author alerts.
- Keep severity colors consistent site-wide via the shared color field.
- Uninstall the module if you prefer to hard-code banner colors in your theme.
- Translate alert nodes like any other content type (body/severity are translatable).
- Add fields (e.g. a link or an icon) to the alert bundle or severity terms to extend banners.
- Embed the alerts listing in any region via the Views block display.
- Cap the header banner block to the five most recent alerts (block display default).
- Filter or theme the alerts view for a custom banner layout.
- Use the severity term ID CSS classes (`.alert-severity-{tid}`) to target banners in theme CSS.
- Drive alert visibility by publishing/unpublishing the alert nodes.
