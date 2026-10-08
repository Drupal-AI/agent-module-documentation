<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-block scroll settings, and how the reveal works

## Install & enable

```bash
composer require drupal/scroll_blocks
drush en scroll_blocks -y
```

Only dependency is core **`block`**. No submodules, no permissions, no Drush commands, no admin
settings page. Everything is configured on the individual block placement.

## Configure a block (UI)

Place or edit a block (*Structure → Block layout → Place block / Configure*). The form gains a set
of fields (added by `scroll_blocks_form_block_form_alter()` in `scroll_blocks.module`):

| Field (form key) | Type | Meaning |
|---|---|---|
| Enable popping up on this block (`enabled`) | checkbox | Master switch for this placement. |
| Reveal scroll distance (`min_scroll_distance`) | number, min 0 | Pixels of scroll after which the block slides up. |
| Hide scroll distance (`max_scroll_distance`) | number, min 0 | Pixels of scroll after which it slides back down. |
| Min window width (`min_width`) | number, min 0 | Only reveal when `window.innerWidth >= this`. `0`/empty = no limit. |
| Max window width (`max_width`) | number, min 0 | Only reveal when `window.innerWidth <= this`. `0`/empty = no limit. |

The four number fields are `#states`-driven: they are only **visible and required** when `enabled`
is checked. `#tree` is TRUE, so Drupal writes them straight into the block's third-party settings
under provider `scroll_blocks`.

`scroll_blocks_block_presave()` prunes on save: if `enabled` is empty it calls
`unsetThirdPartySetting()` for all five keys, so a disabled block stores nothing.

## Where the config lives (config entity + schema)

Settings are stored on the **block config entity** (`block.block.<id>`) under
`third_party_settings.scroll_blocks`, not in a module-owned config object. Schema is in
`config/schema/scroll_blocks.schema.yml`:

```yaml
block.block.*.third_party.scroll_blocks:
  type: mapping
  mapping:
    enabled: { type: boolean }
    min_scroll_distance: { type: integer }
    max_scroll_distance: { type: integer }
    min_width: { type: integer }
    max_width: { type: integer }
```

Example exported placement:

```yaml
# block.block.mycta.yml (excerpt)
third_party_settings:
  scroll_blocks:
    enabled: true
    min_scroll_distance: 400
    max_scroll_distance: 6000
    min_width: 0
    max_width: 0
```

## How the block is marked up (preprocess)

`scroll_blocks_preprocess_block(&$variables)`:

- Loads the block by `$variables['elements']['#id']` (blocks without an `#id`, e.g. Page Manager
  widgets, are skipped) and only acts when `enabled` is set.
- Adds class `scroll-blocks` and five data attributes carrying the thresholds:
  `data-scrollblocks-min-scroll-distance`, `data-scrollblocks-max-scroll-distance`,
  `data-scrollblocks-min-width`, `data-scrollblocks-max-width`.
- Attaches library `scroll_blocks/scroll_blocks`.

These attribute values are integers read from the block's own config (admin-entered), placed as
render-array attribute values that Drupal escapes on output.

## The library (`scroll_blocks.libraries.yml`)

`scroll_blocks/scroll_blocks` = `css/scroll-blocks.css` (component) + `css/scroll-blocks.theme.css`
(theme) + `js/scroll-blocks.js`, depending on `core/drupal`. No external/CDN assets.

## Runtime behavior (`js/scroll-blocks.js`)

`Drupal.behaviors.scroll_blocks.attach()`:

- Selects `.scroll-blocks` in `context`, listens to window `scroll`, debounced with
  `requestAnimationFrame` (cancels the pending frame each event).
- Per block, `parseInt`s the four data attributes. Computes
  `heightOK = pageYOffset >= min_scroll_distance && pageYOffset <= max_scroll_distance`;
  width gates only apply when the value is a non-zero number
  (`min_width` → `windowWidth >= min_width`, `max_width` → `windowWidth <= max_width`).
- If all pass → `showBlock()`: adds class `scroll-blocks--visible`, injects a
  `.scroll-blocks__close-button` (once), sets `data-scroll-blocks--visible="true"`, and dispatches a
  bubbling `scroll_blocks_show_block` CustomEvent (`detail.reason = 'scroll'`). The close button sets
  `data-scroll-blocks--disable="true"` and re-hides — muting the block until the page reloads.
- Else → `hideBlock()`: removes the visible class and dispatches `scroll_blocks_hideblock`.

## Styling (`css/scroll-blocks.css`, `css/scroll-blocks.theme.css`)

The block is `position:fixed; bottom:0; left:50%` and hidden off-screen with
`transform:translateX(-50%) translateY(100%)`; `.scroll-blocks--visible` animates it to
`translateY(0)` (`z-index:9`) over a `transition:all 1s`. The theme CSS gives the visible panel a
translucent white background and styles the round close button (an `×` drawn with two rotated
pseudo-elements). Override in your theme to restyle, to honor `prefers-reduced-motion`, or to change
the fixed-bottom positioning.

## Notes / gotchas

- **Alpha release** (2.0.0-alpha7) — note this when recommending it.
- If you want the block to appear only on certain pages/roles, use the **core block visibility
  conditions**; scroll_blocks only runs when the block is rendered.
- The 1s CSS transition is unconditional (no `prefers-reduced-motion` guard); add one in the theme
  if accessibility requires it.
- `showBlock()` contains a leftover `console.log(mutedByUser)` when a muted block would otherwise be
  shown — harmless but noisy in the console.
