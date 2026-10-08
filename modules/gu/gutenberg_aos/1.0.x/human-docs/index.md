# Gutenberg AOS — manual setup guide

**Gutenberg AOS** (`gutenberg_aos`) brings scroll animations to the **Gutenberg**
editor by integrating the **AOS** (Animate On Scroll) module. With it enabled,
site builders can apply animation effects — fade, slide, and the rest of the AOS
repertoire — to individual Gutenberg blocks straight from the block's settings, no
custom code or template edits required. It is a presentation‑layer enhancement: it
has no content model, permission, or access role of its own.

It extends each block's settings with an **AOS section**, exposing AOS's parameters
— animation type, offset, delay, duration, easing, and more — plus boolean options
like `aos-mirror` and `aos-once` for finer control over how and when the animation
plays.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Gutenberg and AOS modules) and enable it.

## Configuration

There is no separate settings page for this module — as the maintainers note, it
simply extends Gutenberg's own block settings. You configure animations per block,
inside the editor:

1. Open the **Gutenberg** editor on a piece of content.
2. Select a block and open its **settings**.
3. Configure the animation under the added **AOS settings** section — choose the
   animation type and adjust offset, delay, duration, easing, and the `aos-mirror`
   / `aos-once` options as needed.

For the precise meaning of each parameter, refer to the AOS library's own
documentation — this module surfaces AOS's options rather than defining its own.
