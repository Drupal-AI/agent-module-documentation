<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Companion styling module for the Alerts recipe that colors the 'alerts' View's banners by severity via an injected inline stylesheet.

---

Alerts Format is a small presentation helper for the Drupal Alerts recipe. It ships one `hook_views_pre_render()` implementation that fires only for the View whose id is `alerts`. On that View it loads every published taxonomy term in the `alert_severity` vocabulary, reads each term's `field_color` value, and attaches an inline `<style>` element to the page head containing one `.alert-severity-<tid> { background: <color>; }` rule per term. Alert markup that carries the matching `alert-severity-<tid>` class then renders with the color configured on its severity term. The module declares no dependencies, routes, permissions, services, plugins, or config of its own — the `alerts` View, the `alert_severity` vocabulary, and the `field_color` field are all expected to be provided by the Alerts recipe (or an equivalent custom setup). An optional submodule, Alerts Format - Olivero (`alerts_format_olivero`), adds a small CSS/JS library for full-width header banners and a client-side dismiss button when the same View renders under the Olivero theme.

---

- Add severity-based background colors to alert banners produced by the Alerts recipe.
- Drive alert colors from taxonomy: each `alert_severity` term's `field_color` becomes its banner background.
- Recolor all alerts by editing term colors, without touching CSS files or templates.
- Provide a ready-made styling layer so you do not have to hand-write per-severity CSS.
- Use as a reference implementation for equivalent custom-theme code (per the project's own description).
- Style a site-wide "alerts" Views block placed in a header or banner region.
- Support any number of severity levels — one CSS rule is generated per published term.
- Keep unpublished severity terms out of the output (only `status: 1` terms are loaded).
- Pair with the Olivero submodule for full-bleed header alert banners on the Olivero theme.
- Give Olivero alert banners a dismiss ("close") button rendered entirely client-side.
- Remember dismissed banners per browser using `localStorage` (no server round-trip).
- Extend the Alerts recipe install with zero configuration — enable and it works if the recipe's View/vocabulary exist.
- Serve as part of the broader Recipes Support package/ecosystem.
- Work across Drupal core 10 and 11.
- Attach styling only on the specific `alerts` View, leaving all other Views untouched.
- Inject styles via Views' render pipeline (`#attached['html_head']`) rather than a global stylesheet.
- Localize the dismiss control label through `Drupal.t()` in the Olivero submodule.
- Scope Olivero banner CSS to the `views_block__alerts_block_1` block for consistent header placement.
- Uninstall cleanly: removing the module removes the injected styles with no residual configuration.
