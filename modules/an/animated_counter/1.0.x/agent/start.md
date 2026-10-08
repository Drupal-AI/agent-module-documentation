<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animated Counter (animated_counter) — agent index

A single **block plugin** that renders animated "count-up" number tiles which animate from 0 to a
target value when scrolled into view. Package `UI Enhancements`. Depends on core **`block`** and
contrib **`block_animate`** (auto-installed by `hook_install`). Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.0. **No routes, no permissions, no services, no config entities, no
config schema.**

- **The block plugin, every setting, the tile table, and how to place/operate it** →
  [blocks/animated_counters_block.md](blocks/animated_counters_block.md)

## What it actually is (from source)

- One plugin: `AnimatedCountersBlock` (id **`animated_counters_block`**, admin label *"Animated
  Counters (Multiple)"*), `src/Plugin/Block/AnimatedCountersBlock.php`, extends core `BlockBase`.
  Configured entirely through the block placement form — there is no admin settings page.
- `blockForm()` builds block-level selects (`columns`, `style`, `gradient`), a `ripple` checkbox, a
  `top_content` **`text_format`** field, a `wrapper_class` textfield, and a draggable `#type =>
  table` of counter items (`value`, `suffix`, `label`, `icon`, `icon_color`, `url`, `duration`,
  `weight`) with **Add item** / **Remove** submit handlers (`addItem()` / `removeItem()`, both
  `setRebuild(TRUE)`). `blockSubmit()` filters empty rows, sorts by weight, stores everything in
  `$this->configuration`.
- `build()` returns `#theme => 'animated_counters'` with the items + layout settings and attaches
  library `animated_counter/counter`. Empty item list → renders nothing.

## Rendering / behavior

- `hook_theme` (`animated_counter.module`) registers theme `animated_counters` →
  `templates/animated-counters.html.twig`. The template loops items into `.counter` tiles carrying
  `data-target` / `data-suffix` / `data-duration`.
- `js/counter.js` (`Drupal.behaviors.animatedCounter`): an `IntersectionObserver` (threshold 0.4)
  starts each tile's count-up once visible, animating with `requestAnimationFrame`; also wires the
  click ripple on `.ripple-enabled .counter-link`.
- `js/admin-preview.js` (`Drupal.behaviors.counterAdminPreview`): renders the "Live Preview" details
  element in the block form from the current field values on `input`/`change`.
- `animated_counter.module` also implements `hook_page_attachments()` — it attaches the
  `animated_counter/counter` library on **every page** (see caveats).

## Libraries / dependencies

- `animated_counter/counter`: `css/counter.css` + **Font Awesome 6.5.0 from cdnjs** (external CSS) +
  `js/counter.js`; declared deps `core/drpupal` (a typo for `core/drupal`) and `core/once`.
- `animated_counter/admin-preview`: `css/counter.css` + `js/admin-preview.js`; deps `core/drupal`,
  `core/once`.

## Caveats (functional, from source)

- `animated_counter.libraries.yml` lists a dependency **`core/drpupal`** (misspelled); an aggregator
  may warn about the missing library.
- `hook_page_attachments()` attaches the counter CSS/JS (including the Font Awesome CDN request) on
  **every page of the site**, not only where the block is placed.
- The `counter` library pulls Font Awesome from a third-party CDN (`cdnjs.cloudflare.com`) — an
  external asset request on every page.
