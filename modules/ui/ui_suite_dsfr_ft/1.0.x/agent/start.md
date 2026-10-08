<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Suite DSFR Feature (ui_suite_dsfr_ft) — agent index
**Extra UI Patterns blocks (button, modal, consent banner, footer-top) plus an admin SVG-picker autocomplete for the UI Suite DSFR theme.**

- **Version:** 1.0.x (release 1.0.0-rc7)
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** ui_patterns (expects the `ui_suite_dsfr` theme)
- **Blocks:** `DisplayButtonBlock`, `DisplayModalBlock`, `ConsentBannerBlock`, `FooterTopBlock` (`src/Plugin/Block/`).
- **Route:** `ui_suite_dsfr_fr.display_svg.autocomplete` → `/admin/ui-suite-dsfr-fr/autocomplete/svg`, permission `administer site configuration`, `_format: json`.
- **Requirements:** `hook_requirements` demands the `ui_suite_dsfr` theme enabled and > 1.0.0-rc3.
- **Security:** the only route is admin-gated (`administer site configuration`); input is `Xss::filter`-ed and matched against a fixed SVG base directory (no path traversal from the request). No custom permissions, no mutation, no external HTTP.

See [plugins/blocks.md](plugins/blocks.md)
