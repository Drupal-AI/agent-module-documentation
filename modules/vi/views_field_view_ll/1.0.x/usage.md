<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Field View Lazy Load adds a view field handler to embed views inside views by lazy loading the embedded views.

---

Views Field View Lazy Load provides a Views field handler that embeds one View inside another's rows —
loading the embedded (child) View **lazily via AJAX**, so a parent listing with per-row embedded Views doesn't
render all child Views up front (improving performance and cacheability). It depends on core Views.

Use it for per-row embedded Views without the up-front render cost. It is a content-display/Views feature;
the embedded View's results respect **that View's own access**, and it has no access-control role of its own.
Configure the embedded View and its arguments on the field.

---

- Embed a View inside another View's field.
- Lazy-load the embedded View via AJAX.
- Avoid rendering all child Views up front.
- Depend on core Views.
- Improve performance/cacheability.
- Handle per-row embedded Views.
- Respect the embedded View's own access.
- Have no access-control role of its own.
- Configure the embedded View + arguments.
- Handle nested Views.
- Embed Views lazily.
- Configure the field.
- Load child Views on demand.
- Handle the field.
- Embed listings.
- Configure embedding.
- Handle Views-in-Views.
- Lazy-load Views.
- Configure the View.
- Embed Views.
