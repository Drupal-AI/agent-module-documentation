<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The five Bootstrap block styles

Declared in `block_styles_bootstrap.themes.yml` (all `type: block`, `category: Block`,
`base hook: block`, `render element: elements`). Each id is also its theme suggestion, so
`block__bootstrap__card` → `block--bootstrap--card.html.twig`.

| Style id | Label | Template dir | `extras.label` | Library (CSS/JS) |
|---|---|---|---|---|
| `block__bootstrap__card` | Bootstrap Card | `templates/bootstrap_card/` | — | — |
| `block__bootstrap__collapse` | Bootstrap Collapse | `templates/bootstrap_collapse/` | 1 | `block_bootstrap_collapse` (CSS) |
| `block__bootstrap__dropdown` | Bootstrap Dropdown | `templates/bootstrap_dropdown/` | 1 | `block_bootstrap_dropdown` (CSS+JS) |
| `block__bootstrap__modal` | Bootstrap Modal | `templates/bootstrap_modal/` | 1 | `block_bootstrap_modal` (CSS) |
| `block__bootstrap__popover` | Bootstrap Popover | `templates/bootstrap_popover/` | 1 | — |

- **`extras.label: 1`** on collapse/dropdown/modal/popover makes the parent Block Styles module
  enable the **"Text for button label"** field on the block form (stored as `text` on the
  `block_styles` config entity) — used as the trigger button's label. `card` has no label field.
- Libraries are declared in `block_styles_bootstrap.libraries.yml`; the templates attach them for the
  modal/dropdown/collapse interactivity. (The dropdown ships a small JS file; the modal/collapse ship
  CSS.) The markup uses Bootstrap classes, so a Bootstrap-based theme (or Bootstrap's own CSS/JS) is
  expected for correct appearance/behaviour.

## Using one

Pick the style in a block's *Block Styles Template* fieldset (or set it in config). It is saved as the
`theme` of the block's `block_styles.blocks.<block_id>` entity, e.g.:

```php
\Drupal::entityTypeManager()->getStorage('block_styles')
  ->create(['id' => 'my_block', 'theme' => 'block__bootstrap__modal', 'text' => 'Open', 'classes' => ''])
  ->save();
```

For the full config-entity mechanics see the parent module's
[configure/block-styles.md](../../../../2.0.x/agent/configure/block-styles.md).
