<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AOS (Animate On Scroll) — manual setup guide

**AOS (Animate On Scroll)** integrates the [AOS](https://michalsnik.github.io/aos/)
JavaScript library into Drupal, so page elements animate as they scroll into
view — fading, sliding or zooming in as the reader reaches them. It is a
front-end/theming feature only: it attaches the AOS library and its animation
attributes to your markup and does nothing to your content, users or access
control.

**Heads up — the names don't all match.** The project (and its Composer package)
is called `aos-aos`, but the **module machine name you actually enable is
`aos`**. So you install `drupal/aos-aos` with Composer but turn the module on
with `drush en aos`. The project is filed under the *Other* package. Keep this in
mind whenever you type a command or look for the module in the extend list.

The module works once enabled and the library is attached — there is no settings
form to fill in. You add animations by giving elements the AOS data attributes
(for example `data-aos="fade-up"`) in your theme templates, blocks or filtered
markup. It supports Drupal 9, 10 and 11.

This guide is written for a **human** setting the module up through the site and
its theme. If you want terse, token-cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (`drupal/aos-aos`) and enable it (`aos`).

## How to use it

There is no configuration screen. Once the module is enabled, the AOS library is
available, and you apply animations by adding AOS's own data attributes to the
elements you want to animate — typically in your theme's Twig templates or in any
markup you control. For example, an element marked up as
`<div data-aos="fade-up">…</div>` will fade upward into place as it scrolls into
view. Refer to the upstream AOS library documentation for the full list of
animation names and tuning attributes (delay, duration, easing, anchor). Because
the library is a front-end asset, remember to clear caches after enabling so the
library attaches.
