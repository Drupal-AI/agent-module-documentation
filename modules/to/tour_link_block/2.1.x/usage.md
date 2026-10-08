<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tour link block adds a block that renders a "start tour" link, shown only on pages that have a matching Tour and to users who may access it.

---

The `TourLinkBlock` plugin checks `access tour` permission, then queries `tour` entities whose `routes` include the current route (and match its route parameters). If at least one applicable tour exists, the block renders (via the `tour-link` Twig template) a link with the `?tour=1` query that triggers the core Tour. Otherwise the block is denied, so it never appears where there is nothing to tour.

There is no configuration form, routing or custom permission — it reuses core Tour's `access tour` permission and has no security surface beyond that access check.

---

- Add a visible "start tour" link on pages that have a tour.
- Let users launch the guided tour from a block.
- Show the link only where a matching tour exists.
- Hide the block on pages with no tour.
- Respect the core `access tour` permission.
- Place the block in any region via Block layout.
- Match tours by current route name.
- Match tours by route parameters.
- Improve onboarding with a discoverable tour trigger.
- Provide contextual help entry points.
- Reuse existing core Tour definitions.
- Render the link through a Twig template.
- Add the `?tour=1` trigger query automatically.
- Support multiple tours across different routes.
- Give editors a one-click way to review a page's tour.
- Surface tours that users might otherwise miss.
- Keep block visibility automatic (no manual per-page config).
- Theme the tour link via template override.
- Combine with block visibility conditions if needed.
- Help new users learn an admin screen.
