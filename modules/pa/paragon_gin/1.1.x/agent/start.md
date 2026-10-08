<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragon Gin (paragon_gin) — agent index

**Gin + Layout Builder authoring-experience refinements for Paragon sites.**

- **Version:** 1.1.x (dev-1.1.x checkout)
- **Core:** ^10.3 || ^11 — requires `paragon_core`, `gin_lb`, `layout_builder_browser`, core `navigation` + `navigation_top_bar`.
- **Mechanism:** CSS/JS assets, Twig templates, hooks, and a Gin theme setting; see `src/`, `css/`, `js/`, `templates/`.
- No routes, permissions, or services.

**Security:** Presentation-only (theme/JS/templates); no endpoints or user-input sinks. No security findings.
