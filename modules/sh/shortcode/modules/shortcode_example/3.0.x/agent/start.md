<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode Example (shortcode_example) — agent index

Teaching submodule of `shortcode` (`dependencies: shortcode:shortcode`). Ships **one reference
plugin** so developers can copy a working shortcode. Package `Input filters`. Core `^11.1 || ^12`,
PHP 8.3+. No permissions, routes, services, hooks, templates, or config of its own. Version 3.0.0.

- **The `[col]` example plugin, annotated** → [plugins/col-example.md](plugins/col-example.md)
- Framework + plugin API → parent: [../../../3.0.x/agent/start.md](../../../3.0.x/agent/start.md)

## What it provides

- `BootstrapColumnShortcode` (`src/Plugin/Shortcode/BootstrapColumnShortcode.php`), id/token
  **`col`**, `#[Shortcode(id: 'col', title: 'Bootstrap column', description: …)]`, extends
  `ShortcodeBase`.
- `process()` reads attributes `class`, `xs`, `sm`, `md`, `lg` via `getAttributes()`, appends a
  `col-<size>-<n>` class for each size supplied (using `addClass()`), and wraps the tag content in
  `<div class="…">…</div>`.
- `tips()` returns the short/long help shown on the text format tips page.
- Usage: `[col xs="12" sm="6" md="4" lg="3" class="custom"]content[/col]`.

## Enable

```bash
drush en shortcode_example -y
drush cr
```

Then enable the *Shortcodes* filter on a text format and tick the **Bootstrap column** tag. This
module is primarily a development reference — copy the class into your own module's
`src/Plugin/Shortcode/` and adapt it.
