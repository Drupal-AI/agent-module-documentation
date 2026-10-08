<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Icon places an icon as a component, drawing from the suite's icon font.

---

Icons rarely stand alone, but when they do — a row of three feature icons with labels, a decorative divider, a status marker — they need to be placeable like anything else rather than hard-coded into a template.

This component does that, using `vlsuite_icon_font` so the icon comes from the site's defined set rather than being pasted markup.

The accessibility rule is the same as anywhere icons appear and is worth restating because a standalone icon is more likely to be meaningful than a decorative one: if the icon carries information, it needs an accessible name; if it is decoration beside text that already says the same thing, it should be hidden from assistive technology. A row of unlabelled icons is a row of nothing to a screen reader.

---

- Place an icon as a standalone component.
- Build a row of feature icons.
- Add a decorative divider icon.
- Show a status marker.
- Draw icons from the site's defined set.
- Avoid pasted icon markup.
- Give a meaningful icon an accessible name.
- Hide a decorative icon from screen readers.
- Style icon size with utility classes.
- Pair an icon with a text component.
- Keep icon usage consistent.
- Translate an icon's label.
- Audit unlabelled icons.
- Replace hard-coded template icons.
- Restrict icons to a defined vocabulary.
