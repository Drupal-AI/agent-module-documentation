<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wingsuit Page Manager supplies a theme negotiator so Page Manager pages render in the intended theme.

---

Page Manager takes over routes and renders variants, and which theme those variants render in is not always what a site expects — particularly on a build where the front end is a component project and the admin theme is something else entirely. A page that renders against the wrong theme loses its libraries, its templates and its styling, and the symptom looks like a broken page rather than a theme problem.

A theme negotiator is Drupal's supported answer: a service that decides, per route, which theme applies. This submodule provides one for Page Manager routes in a Wingsuit context.

It is a small, targeted fix. The thing to know is that theme negotiators compose by priority — if a site has several (an admin theme negotiator, a domain-based one, this one), the one that wins is a question of priority rather than of which was added last. If a Page Manager page still renders in the wrong theme after installing this, that ordering is where to look.

---

- Render Page Manager pages in the right theme.
- Fix a page that loses its styling.
- Negotiate theme per Page Manager route.
- Combine Page Manager with a component theme.
- Diagnose a page rendering against the admin theme.
- Keep Wingsuit libraries loading on Page Manager pages.
- Support Panels-style page building with Wingsuit.
- Understand theme negotiator priority.
- Debug competing theme negotiators.
- Avoid a custom negotiator in a site module.
- Apply the front-end theme to overridden routes.
- Check which negotiator wins for a route.
- Keep admin routes on the admin theme.
- Audit theme negotiation on an inherited site.
- Document theme negotiation for the site.
