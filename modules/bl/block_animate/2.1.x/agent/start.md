<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Animate (block_animate) — agent index

Bundles **Animate.css** and exposes its ~70 named animations as options on the **block
configuration form**, storing the choice as a block **third-party setting** and applying
`animate__animated animate__<effect>` classes when the block renders. Version **2.1.1**.
Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Depends only on core **`block`**.

No routes, no permissions of its own, no services, no plugins, no Drush, **no settings page**,
no config schema. The whole module is one procedural `block_animate.module` file plus a bundled
`animate.min.css`. Configuration is per block at **Structure > Block layout** (gated by the core
**`administer blocks`** permission).

- **How it hooks the block form, stores the setting, and applies the class — every function and
  the animation list** → [config/settings.md](config/settings.md)

## What it actually is (from source)

`block_animate.module` implements four hooks:

- `block_animate_help()` — help text on `help.page.block_animate`.
- `block_animate_form_block_form_alter()` — adds a `third_party_settings > block_animate`
  fieldset ("Animate CSS") to the core block form with two elements: `animate` (a `select`
  whose options come from `animation_types_form_options()`) and `infinite` (a `checkbox`).
- `block_animate_block_presave()` — unsets the `animate` / `infinite` third-party settings when
  they are empty, so blank choices are not persisted.
- `block_animate_preprocess_block()` — on render, loads the `Block` entity, reads the `animate`
  third-party setting, and if it is set and not `none`, attaches library `block_animate/animate`
  and appends `[$loop]animate__animated animate__<effect>` to `$variables['attributes']['class']`
  (`$loop` = `animate__infinite infinite ` when the infinite checkbox is on).

`animation_types_form_options()` returns the fixed option list (`none`, `bounce`, `flash`,
`pulse`, `fadeIn*`, `slideIn*`, `zoomIn*`, `bounceIn*`, `rotateIn*`, `flipIn*`, `hinge`, `rollIn`,
etc.). Library `animate` (in `block_animate.libraries.yml`) loads the bundled `animate.min.css`
as a `component` CSS asset — no CDN, no JS.

## Notes / caveats

- The stylesheet loads on every page that contains an animated block.
- Entrance animations fire on **load**, not on scroll — a block below the fold finishes animating
  before it is seen. The module supplies classes, not intersection/scroll logic.
- The animation value is placed into the block's **class attribute**, which Drupal's `Attribute`
  object escapes on render; block config is admin-gated. No user-facing input surface.
