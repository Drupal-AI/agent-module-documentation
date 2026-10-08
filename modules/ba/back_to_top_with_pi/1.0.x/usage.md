Back to top with progress scrollbar provides a block that combines a "back to top" button with a circular scroll-progress ring.

---

Back to top with progress scrollbar ships a single Block plugin (`back_to_top_with_pi`) that renders a floating "back to top" control wrapped in a circular SVG progress indicator. As the visitor scrolls, the ring fills to show reading progress; clicking the control smoothly animates the page back to the top. The block's per-placement configuration form lets an administrator set the stroke, box-shadow, icon and hover colors, choose a left or right position, toggle a drop shadow and a fill color, and pick between an arrow-icon display or a live scroll-percentage display. Presentation is driven by a Twig template (`templates/back-to-top-with-pi.html.twig`, theme hook `back_to_top_with_pi`), a jQuery behavior (`js/custom.js`), custom CSS, and the bundled unicons icon font. It is a pure front-end/UI feature: no routes, permissions, services, config schema, or install hooks, and it depends only on core Block.

---

- Add a floating "back to top" button to long pages.
- Show reading progress as a circular ring that fills on scroll.
- Let visitors return to the top of the page in one smooth-animated click.
- Place the control in any theme region via Block layout.
- Position the control on the left or right of the viewport.
- Set the progress ring's stroke color to match a theme.
- Set the ring's inset box-shadow color.
- Set the arrow icon color and a separate hover color.
- Enable an outer drop shadow and choose its color.
- Fill the ring background with a chosen color once the visitor scrolls past the threshold.
- Display a live scroll percentage instead of the arrow icon.
- Show only the arrow icon for a minimal indicator.
- Restrict the control to specific pages/roles/content types using core Block visibility conditions.
- Reveal the control only after the visitor scrolls down (~500px) via the active-progress state.
- Give each placement its own independent styling (per-block configuration).
- Aid navigation on long articles, documentation, and landing pages.
- Provide a lightweight, dependency-free (beyond core Block) scroll indicator.
- Copy the Twig template into a theme to customize the markup and layout.
- Override the CSS or JavaScript to swap in FontAwesome, Flaticon, or custom icons.
- Add multiple placements with different colors/positions for different sections of a site.
- Improve perceived reading progress on content-heavy pages.
