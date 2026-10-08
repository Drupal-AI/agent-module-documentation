<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VVJ Core is the shared base for the VVJ family of accessible, framework-free Views display formats — accordion, carousel, tabs and any others in the set.

---

Families of display modules usually duplicate their foundation: each ships its own base classes, its own JavaScript helpers, its own accessibility utilities, and they drift. VVJ Core exists so they do not. It holds the common Views style plumbing and the shared vanilla-JavaScript behaviours the individual formats build on, and it is installed automatically whenever any VVJ module is enabled — you do not choose it directly.

Knowing it exists matters for two reasons. First, when several VVJ formats are on one site, they share one implementation of the keyboard and ARIA behaviour, so accessibility fixes land once rather than three times. Second, when debugging, the behaviour you are chasing is often here rather than in the format module — the format contributes the markup and the core contributes how it responds.

Like the rest of the family it requires Drupal `^11.3 || ^12` and declares PHP 8.3, and depends only on `views` and `filter`.

---

- Provide the shared foundation for VVJ display formats.
- Share accessibility behaviour across accordion, carousel and tabs.
- Keep one implementation of keyboard handling for the family.
- Avoid duplicated JavaScript between display formats.
- Land an accessibility fix once for all VVJ formats.
- Debug VVJ behaviour at its source.
- Install automatically with any VVJ module.
- Build an additional VVJ-style format on the same base.
- Keep the front-end payload small across formats.
- Understand a site's VVJ dependency chain.
- Plan a Drupal 11.3+ Views display stack.
- Audit which VVJ formats a site uses.
- Reuse the base for a custom display format.
- Confirm PHP 8.3 is available before adopting.
- Check which VVJ formats a site has enabled.
