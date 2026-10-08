<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Icon Font provides the icon vocabulary the suite's components draw on.

---

Icons appear throughout a component library — in buttons, list items, cards, callouts — and the usual outcome without a shared mechanism is three approaches on one site: an icon font in the theme, inline SVGs in some templates, and image files in others. They style differently, scale differently and break differently.

This submodule gives VLSuite one answer. Components that offer an icon draw from the same set, so an icon chosen in a CTA and one chosen in a card behave identically.

It is depended on by `vlsuite_utility_classes` and `vlsuite_bundle_field`, which places it low in the stack — it is infrastructure rather than a feature, and removing it affects more than the components that visibly show icons.

Two things to weigh at design time. An icon font renders as text, so it inherits colour and size naturally but is invisible to a screen reader unless the markup provides an accessible name — decorative icons need `aria-hidden`, meaningful ones need a label. And a font loads as a single file, so a large set costs bandwidth for icons nobody uses; check what the theme actually ships.

---

- Give components a shared icon set.
- Add an icon to a call to action.
- Show icons in a card component.
- Keep icon styling consistent sitewide.
- Inherit text colour and size for icons.
- Avoid mixing fonts, SVGs and images.
- Provide an accessible name for a meaningful icon.
- Hide a decorative icon from screen readers.
- Check the icon font's payload size.
- Ship only the icons a site uses.
- Style icons with utility classes.
- Standardise icon usage across projects.
- Replace ad-hoc icon markup in templates.
- Audit which icons components reference.
- Plan icon accessibility for a design system.