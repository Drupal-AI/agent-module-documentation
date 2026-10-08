<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Container Query Images extends the Responsive Image module to serve images that respond to their container's width (via CSS container queries) instead of the viewport width.

---

Container Query Images extends Drupal's Responsive Image module so images respond to their
**container's** width rather than the viewport width — using modern CSS container queries. This gives
correct image sizing when the same component appears in different-width regions (a card in a sidebar vs a
wide column), which viewport-based responsive images can't handle well. It depends on core Image,
Responsive Image and Breakpoint.

Use it in component/layout-driven designs where image size should follow the container. It is a
media/performance feature building on responsive images; it governs image variant selection for display,
with no content or access role. Configure the container-query image styles and apply them. (Container
queries require modern-browser support.)

---

- Size images by container width.
- Use CSS container queries for images.
- Respond to container, not viewport.
- Extend Responsive Image.
- Depend on Image, Responsive Image, Breakpoint.
- Handle components in varied widths.
- Serve correct image sizes per container.
- Improve component-based layouts.
- Govern variant selection.
- Have no content/access role.
- Configure container-query styles.
- Apply to image displays.
- Fix sidebar-vs-column sizing.
- Require modern browsers.
- Improve image performance.
- Follow the container size.
- Serve container-aware images.
- Enhance responsive images.
- Handle layout-driven images.
- Size to the component.
