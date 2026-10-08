<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Back to top block & library

## Install / enable
`drush en accessible_back_to_top`. No dependencies, no install hook, no config import. After enabling,
go to Block Layout (`/admin/structure/block`) and place **"Back to top block"** in a region. There is
no settings form and no configuration route (`configure: null`); the button works out of the box.

## Block plugin
- File: `src/Plugin/Block/BackToTopBlock.php`
- Class: `Drupal\accessible_back_to_top\Plugin\Block\BackToTopBlock extends BlockBase`
- Annotation: `@Block(id = "back_to_top_block", admin_label = @Translation("Back to top block"))`
- `build()` returns a single static `#markup` string and attaches the library:
  ```
  <div aria-hidden="true" role="button" tabindex="0" class="back-to-top">
    <div class="icon"></div><div class="text">Top</div>
  </div>
  ```
  and `$build['#attached']['library'][] = 'accessible_back_to_top/back-to-top';`
- The markup is a hardcoded constant — no configuration, no user input, no tokens. The label text
  ("Top") is fixed in code; there is no block form (`blockForm`/`blockSubmit`), no
  `defaultConfiguration`, and no stored settings.

## Library
`accessible_back_to_top.libraries.yml` defines `back-to-top`:
- CSS (theme group): `css/back-to-top.css`
- JS: `js/back-to-top.js`
No dependencies (not even core/jQuery — it uses vanilla DOM APIs).

## JS behavior (`js/back-to-top.js`)
Self-invoking IIFE bound on `DOMContentLoaded`, operating on the first `.back-to-top` element:
- **click** → `window.scroll({ top: 0, behavior: 'smooth' })`.
- **keydown** (`Enter` or `Space`) → same smooth scroll, then moves focus to `document.querySelector('.skip-link')`.
- Starts hidden (`el.style.display = 'none'`); on `scroll`, shows (`flex`) when `window.scrollY >= 800`,
  hides otherwise.
- Note: the script assumes a `.back-to-top` element exists and (for keyboard use) a `.skip-link`
  element on the page; if the block is not placed, `querySelector('.back-to-top')` is null and the
  listener setup would error — this is a robustness note, not a security issue.

## CSS hooks (`css/back-to-top.css`)
Restyle by overriding these theme selectors:
- `.back-to-top` — fixed circular button (`position: fixed; bottom: 5vh; left: 90vw; 70x70px; border-radius: 100%`).
- `.back-to-top .icon` — 30x30 arrow via `background: url("../images/arrow.svg")`.
- `.back-to-top .text` — the "Top" label typography.
- `.back-to-top:hover` — fade to `opacity: 0.5`.

## Operate
No permissions gate anything the module itself adds; visibility/placement is governed entirely by
core's block system (region + block visibility conditions). To limit where the button shows, use the
block's standard "Pages"/content-type/role visibility settings.
