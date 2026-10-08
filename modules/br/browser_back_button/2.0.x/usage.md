Browser Back Button provides one placeable block whose label is clickable and runs the browser's native `window.history.back()`.

---

The module registers a single Block plugin, "Browser Back Button Block", that you add through the core Block Layout UI. In the block's configure form you enter the back control's text or image via a `text_format` (rich-text) field, and the block renders that content inside a `#back-button-wrapper` element. A small jQuery behavior (using `core/once`) binds a click handler to that wrapper which calls `window.history.back()`, so the block reproduces the browser Back button anywhere you place it. There is no separate admin settings page, no routes, no permissions, and no dependencies beyond Drupal core; everything is configured per block placement. Note that the `reload_status` option exists only in config schema/defaults and is not wired into the shipped JavaScript, so clicking simply steps back in history rather than force-reloading.

---

- Place a visible on-page "Back" control in a header, sidebar, or footer region without theming a custom template.
- Give editors a consistent Back affordance on content-heavy pages where users navigate deep hierarchies.
- Add a Back control to a landing page or campaign page that lacks native site navigation.
- Provide a large, touch-friendly Back target on mobile layouts where the browser chrome Back button is hard to reach.
- Configure the control's label text (e.g. "Back", "Return", "Previous page") per placement via the block form.
- Use an inline image or icon markup as the Back control instead of plain text, entered through the rich-text body field.
- Style the Back control by targeting the stable `#back-button-wrapper` element ID in your theme CSS.
- Restrict where the Back control appears using core block visibility conditions (by path, content type, role, or region).
- Show the Back control on some pages but not others by placing the block only in specific regions or with path conditions.
- Offer a themed Back button that matches site branding rather than the raw browser button.
- Add a Back control to a print-style or minimal template that hides the main menu.
- Place the control inside a modal-heavy or wizard-style flow to let users step back through pages.
- Provide a Back control on error or 404 pages placed via block visibility rules.
- Give multilingual sites a translatable Back label through the block's configuration and interface translation.
- Combine with other navigation blocks (breadcrumb, menu) to give users multiple ways to move back.
- Present a call-to-action-styled Back control for e-commerce or catalog browsing pages.
- Reuse the same Back block across multiple regions/themes since it carries its own attached library.
- Deploy the block configuration via configuration management (the block's settings are standard block config).
- Prototype quickly: enable the module, place the block, set the label, and the Back behavior works with no code.
