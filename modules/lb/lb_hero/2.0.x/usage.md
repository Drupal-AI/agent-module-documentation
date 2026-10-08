<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Y Layout Builder Hero provides the full-width introduction block for YMCA Layout Builder pages.

---

The band at the top of a location or programme page: background media, a heading, supporting text and usually a call to action.

Two things matter more here than for any other component, and both are properties of heroes generally rather than of this implementation. It is almost always the page's **largest contentful paint**, which makes its responsive image configuration the highest-value performance lever available and preloading that image usually worth doing. And **text over a photograph is a contrast problem the design has to solve structurally** — an overlay, a scrim or a constrained text area — because the image is the thing editors change, and legibility over one photograph tells you nothing about the next.

On a multi-location site the second point compounds: dozens of branches each choosing their own hero image means the design has to hold for images nobody reviewed.

**This module cannot be enabled as composer resolves it, and the cause is now familiar.** It depends on `y_lb` (Y Layout Builder), and `ycloudyusa/y_lb` on Packagist has exactly one published version — **0.1, from 2022**, declaring `core_version_requirement: ^8 || ^9`. The current releases (3.x, 4.x, 5.x) live in the YMCA's own composer repository, which this campaign does not add.

Modules in this family that require `y_lb` **without a version constraint** install cleanly and then fail at enable time with *"Its dependency module 'y_lb' is incompatible with this version of Drupal core."* Modules that **do** constrain it — `ws_event` requires `^4.0 || ^5.0` — fail earlier and more usefully, at composer time with a resolvable explanation. The stricter-looking module behaves better.

Add the YMCA composer repository before requiring anything in this family. See `modules/y_/y_lb` for the full characterisation.

---

- Add a hero to a location page.
- Show a heading over background media.
- Place a call to action in the hero.
- Serve a responsive hero image.
- Preload the hero image.
- Improve largest contentful paint.
- Keep hero text legible over any image.
- Apply an overlay or scrim.
- Design for unreviewed branch images.
- Test contrast with several photographs.
- Set a consistent hero height.
- Add the YMCA composer repository.
- Diagnose a y_lb core incompatibility.
- Audit hero image sizes across locations.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
