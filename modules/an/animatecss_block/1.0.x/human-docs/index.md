# AnimateCSS Block — manual setup guide

**AnimateCSS Block** (`animatecss_block`) lets you attach an
[Animate.css](https://animate.style/) effect to any Drupal block straight from Block
layout — no hand-written CSS classes or custom JavaScript per block. Animate.css provides
a catalog of ready-made entrance and attention animations (fade, bounce, zoom, slide, and
many more), and this module extends the [AnimateCSS](https://www.drupal.org/project/animatecss)
project so those effects can be assigned to blocks through the admin UI.

Use it to make a hero or call-to-action block fade in on load, bounce for attention, or
slide into view — each with its own duration, delay, and repeat settings. It reuses the
AnimateCSS library already on your site and keeps animation styling consistent site-wide.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.

## Where it lives in the admin menu

The module's own settings form — where you manage block-animation defaults — sits at
**Configuration → User interface → AnimateCSS → Settings → Block**
(`/admin/config/user-interface/animatecss/settings/block`), behind the **Administer
animate css block** permission. The per-block choices are added to the individual block's
edit form under **Structure → Block layout**.

## How to use it

1. Make sure the AnimateCSS UI module and this module are enabled.
2. Set your block-animation defaults on the settings form at
   `/admin/config/user-interface/animatecss/settings/block`.
3. Go to **Structure → Block layout**, edit the block you want to animate, and choose its
   Animate.css effect along with duration, delay, and repeat/iteration options. Save the
   block, then load a page where it appears to see the animation.

The **Administer animate css block** permission gates the settings form, so you can
restrict who is allowed to configure block animations.
