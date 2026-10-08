Contact Block lets you place any of Drupal core's contact forms into a block region, so a contact form can appear in a sidebar, footer, or anywhere else instead of only on its own `/contact` page.

---

Drupal core's Contact module renders each contact form only at its dedicated URL. Contact Block adds a configurable **"Contact block"** block plugin that embeds a chosen contact form directly into the page via the Block layout system. When placing the block you select which contact form to show and which **form display** (form mode) to render, letting you present different field arrangements of the same form in different places. It supports both site-wide contact forms and the **personal** contact form: the personal form is only shown on user-context pages (e.g. `/user/{user}`), where it resolves the recipient from the user in the URL and reuses core's personal-contact access check. Block access mirrors the underlying contact form's permissions, and the block declares a config dependency on the selected form so it exports cleanly. It registers all `contact_message` form modes as usable form displays and adds contextual links (edit form / manage fields) on the rendered block. The module is tiny — one block plugin and a bit of glue — but it makes core contact forms far more flexible for site builders.

---

- Put a contact form in a sidebar block on every page.
- Add a contact form to the site footer.
- Show a contact form on the front page.
- Place different contact forms (sales, support) in different regions.
- Render a contact form inside a specific content type's region via block visibility rules.
- Use block visibility conditions to show a form only on certain paths.
- Display the personal contact form on user profile pages.
- Choose an alternate form display (form mode) for a compact block variant.
- Present a minimal contact form in a modal-friendly block.
- Keep the canonical `/contact` pages while also embedding forms in blocks.
- Add a "Contact us" form to a landing page layout.
- Provide a feedback form block on documentation pages.
- Show a department-specific contact form in that department's section.
- Export the placed contact block as configuration with its form dependency.
- Give editors contextual "Edit contact form" / "Manage fields" links on the block.
- Localize which contact form appears per language using block conditions.
- Reuse one contact form across multiple regions/themes.
- Offer a quick-contact block in a mega-menu or off-canvas area.
- Restrict a contact block to authenticated users via the form's permissions.
- Swap the default site-wide form for a custom one in the block settings.
- Build a "Get in touch" section without a custom module.
- Present multiple contact blocks on a single page for different purposes.
- Add a contact form block to a Layout Builder region.
