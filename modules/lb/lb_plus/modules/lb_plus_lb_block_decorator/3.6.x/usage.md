<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder + Block Decorator teaches the Layout Builder Block Decorator module about Layout Builder +'s nested sections.

---

Layout Builder Block Decorator lets a site add wrapper markup and classes around blocks placed in a layout — the mechanism behind "make this block a card", "give this block a coloured background", "wrap this in a container". It assumes core Layout Builder's flat structure, where a block sits directly in a section.

Layout Builder + introduces nesting: sections inside sections, so a block may be several levels deep. A decorator that walks a flat structure does not find those blocks, and the decoration silently stops applying to exactly the arrangements that most need it. This submodule supplies the nested-layout awareness.

It is a two-module bridge with no configuration of its own, and it is only relevant if both `lb_block_decorator` and `lb_plus` are installed. If block decoration is behaving inconsistently on a Layout Builder + site — working on top-level blocks and not on nested ones — this is the missing piece.

---

- Apply block decoration inside nested sections.
- Keep wrapper markup working after adopting Layout Builder +.
- Decorate a block several levels deep in a layout.
- Add a card wrapper to a nested block.
- Give a nested block a background treatment.
- Fix decoration that applies only to top-level blocks.
- Combine nested layouts with per-block styling.
- Keep a design system's wrapper classes consistent.
- Use block decoration across a nested page structure.
- Diagnose inconsistent block decoration in Layout Builder +.
- Confirm both parent modules are installed before adding it.
- Keep decoration consistent between flat and nested sections.
- Audit a page whose nested blocks lost their wrapper markup.
- Plan an lb_plus adoption that keeps block decoration working.
- Verify decoration after converting a flat layout to nested.
