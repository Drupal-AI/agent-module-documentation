<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search kint (search_kint) — agent index

Adds search to **Kint** dumps. Depends on `devel ^5.1` and `kint-php/kint ^5.0 | ^6.0`.
Core requirement `^10 || ^11`. **Release is 2.0.0-beta2 — beta.**
No routes, permissions or configuration.

Key facts:
- Whole module: `search_kint.module`, `search_kint.search.js`, **`search_kint.trail.js`**,
  `search_kint.css`, `search_kint.libraries.yml`.
- `search_kint.trail.js` is the genuinely useful half — it shows the **path to a match**, which is
  what you need to reach the value in code. Finding that a key exists is the easy part.
- **Development only.** It depends on Devel, which should not be enabled in production; this
  inherits that restriction entirely.
- Aimed squarely at render arrays and loaded entities — structures where Kint's collapsed tree is
  correct but unnavigable.
- **Entirely front-end**: one `hook_page_attachments()` attaches a JS/CSS library; the JS enhances
  the HTML Devel's Kint already rendered. It never produces a dump itself.

## What you'd do → where

- **Understand exactly what it hooks into, the DOM contract, the search behavior, and how the
  "Get path" trail builds `$var[...]->...` paths / entity-getter code** →
  [hooks/search-kint.md](hooks/search-kint.md)
