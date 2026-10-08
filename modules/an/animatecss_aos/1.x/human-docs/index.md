# AnimateCSS AOS — manual setup guide

**AnimateCSS AOS** (`animatecss_aos`) adds **Animate On Scroll (AOS)** options to the
[AnimateCSS](https://www.drupal.org/project/animatecss) module's user interface.
AnimateCSS provides the animations; AOS is what triggers them at the right moment —
when an element scrolls into the viewport. Together they let you set up animations that
play as the visitor scrolls down the page, all from the AnimateCSS UI rather than
hand-written code.

This is a front-end presentation enhancement with no security surface of its own. It
extends AnimateCSS, so it needs both the AnimateCSS UI and the AOS.js library module in
place.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, then enable it.

## How to use it

Once enabled, the AOS options appear on the AnimateCSS "add animation" form in the
AnimateCSS UI. Configure an animation there and choose the AOS (on-scroll) trigger so the
effect plays as the element enters the viewport.

### Accessibility and performance notes

- **Respect reduced motion.** Confirm that scroll animations honour the visitor's
  `prefers-reduced-motion` setting before using them on a public site — scroll motion is
  among the effects most likely to affect people with vestibular disorders.
- **Weigh performance** on long pages, where many on-scroll animations can add up.
