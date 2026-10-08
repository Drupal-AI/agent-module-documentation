<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a block's animation

## Install & enable

```bash
composer require drupal/block_animate
drush en block_animate -y
```

Only dependency is core **`block`**. No sub-modules, no permissions of its own, no Drush
commands, no settings page, no config schema files.

## Where you configure it

There is **no admin/config page**. Every block gains an **"Animate CSS"** fieldset on its own
configuration form:

- UI: **Structure > Block layout** → *Configure* a block (or place a new one). Scroll to the
  **Animate CSS** fieldset.
- Two controls (from `block_animate_form_block_form_alter()` in `block_animate.module`):
  - **Select Animate** (`animate`): a `select` of ~70 effects from
    `animation_types_form_options()` — default `-- No animation --` (`none`).
  - **Apply an infinite loop** (`infinite`): a `checkbox`. The description warns it should not be
    combined with an animation iteration option.

Access to this form is the core block form, gated by the **`administer blocks`** permission.

## How the choice is stored

The values are saved as **block third-party settings** under the provider `block_animate`:

- `block.<region_or_block_id>` config → `third_party_settings.block_animate.animate` and
  `.infinite`.
- `block_animate_block_presave(BlockInterface $entity)` calls `unsetThirdPartySetting()` for each
  key that is empty, so a blank/`none` selection is **removed** from the stored config rather than
  persisted as an empty value.

Config/YAML example (the third-party setting on a block config entity):

```yaml
# block.block.mysite_promo.yml (excerpt)
third_party_settings:
  block_animate:
    animate: fadeInUp
    infinite: false
```

Set it programmatically:

```php
$block->setThirdPartySetting('block_animate', 'animate', 'fadeInUp');
$block->setThirdPartySetting('block_animate', 'infinite', FALSE);
$block->save();
```

> Note: there is **no config schema** shipped for these third-party settings, so strict
> `config:inspect` / schema tooling may flag the `block_animate` keys; they still save and work.

## How the class is applied at render

`block_animate_preprocess_block(&$variables)`:

1. Reads `$variables['elements']['#id']` and `Block::load()`s that block.
2. Reads the `animate` third-party setting; proceeds only if set **and not `none`**.
3. Computes `$loop = 'animate__infinite infinite '` when the `infinite` setting is truthy, else
   `''`.
4. Attaches library **`block_animate/animate`** (`$variables['#attached']['library'][]`).
5. Appends `"$loop"."animate__animated animate__".$animate` to
   `$variables['attributes']['class'][]`.

So a block set to `fadeInUp` with infinite off renders with classes
`animate__animated animate__fadeInUp`; with infinite on,
`animate__infinite infinite animate__animated animate__fadeInUp`. The class string goes into the
block template's `attributes` (a Drupal `Attribute` object) and is escaped on output.

## The library

`block_animate.libraries.yml`:

```yaml
animate:
  version: 1.x
  css:
    component:
      animate.min.css: {}
```

`animate.min.css` (Animate.css) is **bundled with the module** — loaded locally, no CDN origin,
no JavaScript. It is only attached on pages where an animated block is present (step 4 above).

## The animation options

`animation_types_form_options()` returns a fixed map of `machine => label`, including:
`none`, `bounce`, `flash`, `pulse`, `rubberBand`, `shake`, `swing`, `tada`, `wobble`;
`bounceIn`/`bounceOut` (+ `Down`/`Left`/`Right`/`Up` variants);
`fadeIn`/`fadeOut` (+ directional and `*Big` variants);
`flipInX`/`flipInY`/`flipOutX`/`flipOutY`;
`lightSpeedIn`/`lightSpeedOut`;
`rotateIn`/`rotateOut` (+ corner variants);
`hinge`, `rollIn`, `rollOut`;
`zoomIn`/`zoomOut` (+ directional variants);
`slideInDown`/`Left`/`Right`/`Up` and the matching `slideOut*`.
The effect name selected is used verbatim as the `animate__<effect>` class suffix.

## Operating notes

- To remove an animation: set the block back to **-- No animation --** and save (presave unsets
  the key).
- The stylesheet loads for every visitor on any page containing an animated block, so treat it as
  a per-page cost even for a single decorative animation.
- Entrance animations run on page **load**; there is no scroll/IntersectionObserver trigger, so a
  below-the-fold block animates before it is scrolled into view.
