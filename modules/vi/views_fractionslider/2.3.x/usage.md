<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FractionSlider integrates the FractionSlider jQuery plugin, adding a ready-made slider block and an optional `views_fs` submodule that turns a view's rows into animated slides.

---

Enable the module with `drush en fractionslider` (the drupal.org **project** is `views_fractionslider`, but the machine name to enable is **`fractionslider`**, so `drush en views_fractionslider` fails); it depends only on core `block`. **Ready-made block:** at **Structure → Block layout** place the **"Fractionslider Block"** into a region, then edit it — the block form exposes a large **FractionSlider HTML** textarea (one `<div class="slide">…</div>` per slide, each holding `<img>`/`<p>` layers with `data-position`, `data-in`, `data-out`, `data-delay` and `data-step` attributes) plus selects for **Controls**, **Pager**, **Dimensions** (`1000, 400`), **Full width**, **Responsive**, **Pause on Hover** and **Increase**. **From a view:** enable the **`views_fs`** submodule (needs core Views), add fields to a view, then under **Format** choose **"Views Fractionslider"**; its settings form has a **General Settings** group (Div class, Pager, Controls, Dimensions, Full width, Responsive, Increase) and a **Fields Settings** group where each field gets its own in/out animation (`data-in`, `data-out`), sequencing (`data-step`), easing (`data-ease-in`/`data-ease-out`), duration (`data-time`) and top/left spacing (`space`/`lspace`) — this is what lets a heading and an image within one slide animate independently. Both paths attach the `fractionslider/global-styles-and-scripts` library and initialise the slider client-side, so no PHP configuration page exists. Note that it is jQuery-era software (the bundled plugin is *jQuery Fraction Slider v0.9.9.6*) and, being auto-playing animated content, should be paired with attention to reduced-motion preferences and the reality that content past the first slide is rarely seen.

---

- Build an animated slider.
- Drive a slider from a view.
- Animate elements within a slide.
- Build a parallax-style banner.
- Show filtered content in a slider.
- Build a promotions rotation from content.
- Animate a heading and image separately.
- Show recent articles in a slider.
- Build a homepage banner from a view.
- Show events in a rotating panel.
- Keep slider content current automatically.
- Build a designed hero animation.
- Show featured products in a slider.
- Animate a call to action.
- Build a slider with access-checked content.
- Show a curated view as slides.
- Add motion to a landing page.
- Build a multilingual slider from a view.
- Place a ready-made demo slider block.
- Set per-field in and out animations.
