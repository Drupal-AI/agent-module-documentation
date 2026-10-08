<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Same Height supplies a JavaScript library that makes a set of elements (such as teaser cards, columns or list items) appear the same height, faking uniform alignment without CSS grid/flex tricks.

---

The module is essentially a library wrapper: `same_height.libraries.yml` defines a JS asset that, when attached to a page or view, measures the target elements and equalises their heights. There are no routes, permissions, services, config forms or PHP logic — a theme or module attaches the `same_height` library and adds the expected class/selector to the elements it should apply to. It is packaged under the Views group because a common use is equalising Views row cards. Being pure front-end JavaScript, it has no server-side attack surface.

---

- Equalise the height of teaser cards in a Views grid row.
- Align columns of differing content length to the same height.
- Fake uniform card heights without CSS flexbox hacks.
- Attach a lightweight JS library to a theme region.
- Tidy up product or article listings visually.
- Keep call-to-action boxes aligned across a row.
- Apply equal heights to arbitrary selected elements.
- Improve the look of multi-column layouts.
- Use in a custom theme by attaching the library.
- Avoid ragged bottoms on grids of mixed content.
- Pair with Views to align dynamic result cards.
- Add consistent alignment to marketing sections.
- Re-run on resize to keep heights synced (client-side).
- Keep the solution CSS-framework agnostic.
- Provide alignment without changing markup structure.
