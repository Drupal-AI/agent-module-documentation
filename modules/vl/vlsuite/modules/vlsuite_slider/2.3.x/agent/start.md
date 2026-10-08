<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Slider (vlsuite_slider) — agent index

Submodule of **vlsuite**. **Slider/carousel** behaviour for blocks and layout sections.
Version **2.3.3**. Core `^10.3 || ^11`. Depends on `vlsuite`.
Both `vlsuite_block` and `vlsuite_layout` depend on it, so a section of cards becomes a card
carousel without a separate component.

**Two things to say plainly when a carousel is proposed:**

1. **They perform poorly at their stated job.** Usability research consistently finds content past
   the first slide is rarely seen. Fine for optional extras; wrong for the primary CTA.
2. **Accessibility takes work.** Keyboard operation, visible focus, every slide's content
   reachable, and no auto-advance without a pause control. Verify on the shipped implementation.