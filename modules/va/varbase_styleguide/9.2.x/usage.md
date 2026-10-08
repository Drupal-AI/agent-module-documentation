<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Styleguide adds Varbase's own component examples to the Styleguide module's living style guide, so a theme can be checked against every element it has to render.

---

The Styleguide module builds a single page containing an instance of every text style, form element, list, table and message type Drupal produces. That page is the fastest way to answer "did my theme change break anything" — one scroll shows you elements you would otherwise only find in production, weeks later, on a page nobody looks at.

This module extends that set with the components Varbase adds, so on a Varbase site the style guide covers the distribution's own patterns rather than just core's. `Hook/VarbaseStyleguideHooks` is where the examples are registered.

It earns its place in a theming workflow rather than a production one: build the theme, open the style guide, find the elements that look wrong, repeat. It is equally useful during an upgrade, where the question is which components changed appearance between versions, and during handover, where a style guide is the fastest way to show someone what a theme covers.

The core requirement is `~11.4.0`, a single Drupal minor, consistent with the rest of the Varbase family — this tracks the distribution.

---

- Review every element a theme must style in one page.
- Include Varbase components in the style guide.
- Check a theme change against all element types.
- Find unstyled elements before users do.
- Compare component appearance across an upgrade.
- Hand over a theme with a visual reference.
- Test typography and spacing systematically.
- Verify form element styling.
- Verify message and status styling.
- Verify table and list styling.
- Review a theme against a design system.
- Onboard a front-end developer to a Varbase theme.
- Spot regressions after a Varbase update.
- Keep a living reference for a design team.
- Align with the distribution's release cycle.