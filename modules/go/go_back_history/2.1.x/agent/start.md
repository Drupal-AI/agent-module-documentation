<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Go Back History (go_back_history) — agent index

A single **block plugin** that renders one anchor whose JS click handler calls
`window.history.back()`. Package `Go Back History`. Version **2.1.0**.
Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.
Depends on core **`block`** only. No routes, no permissions, no config object/schema, no Drush.

- **The block, its render/theme/library, styling & how to place it** →
  [blocks/go-back-block.md](blocks/go-back-block.md)

## What it actually is

- One plugin: `GoBackHistoryBlock` (id **`go_back_history_block`**, admin label *"Go back history
  block"*, category *"Go back history block"*), in
  `src/Plugin/Block/GoBackHistoryBlock.php`, extending core `BlockBase`.
- `build()` returns a render array: `#theme => 'block_go_back_history'`, `#button_value =>
  t('Go back')` (fixed, translatable), and `#attached[library] = go_back_history/go_back_history`.
  There is **no `blockForm()`/`blockSubmit()`** — no custom per-block settings; only standard block
  config (label, region, visibility) applies.
- Hook class `Hook/GoBackHistoryHooks` (OOP hooks via `#[Hook]`, registered as an autowired service
  in `go_back_history.services.yml`, bridged by `#[LegacyHook]` shims in `go_back_history.module`):
  - `hook_help()` — help text on `help.page.go_back_history`.
  - `hook_theme()` — defines theme hook `block_go_back_history` (template
    `templates/block--go-back-history.html.twig`, variable `button_value`).

## Mechanism (from source)

- Template renders `<a class="go-back-history-btn">{{ button_value }}</a>` inside the block
  wrapper. The anchor has **no `href`** and carries **no URL, referrer, or request parameter**.
- `js/go_back_history.js` (`Drupal.behaviors.goBackHistory`, using `core/once`) binds a click
  handler to `.go-back-history-btn` that calls **`window.history.back()`** — nothing else.
- `css/go_back_history.css` styles the block as a 48×48 round button with a left-arrow SVG
  (`images/left-arrow.svg`); the label text is set `color: transparent` (icon-only by default).
- Library `go_back_history/go_back_history` = that CSS + JS, deps `core/drupal`, `core/jquery`,
  `core/once`.

## Notes / caveats

- Purely client-side: it moves the **browser's** history, not the site's. A visitor with no prior
  history (deep link from email/search) gets a no-op — there is **no fallback URL** option.
- Not a navigation structure; keep breadcrumbs / a real parent link for structural relationships.
