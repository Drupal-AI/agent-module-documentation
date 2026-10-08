Adds a dedicated "Page Title" view mode so site builders can control how an entity's page title (H1) is rendered on its full page, straight from Manage display.

---

Entity Page Title Manage Display gives every entity type a "Page Title" view mode (created automatically on install). When a site builder enables and configures that view mode for a bundle on its Manage display page, the module renders the entity in that view mode and swaps the result into the core "Page title" block on the entity's canonical, preview and revision pages. This turns the plain, uncustomisable page title into a fully manageable display: you can change the title field's formatter, wrap it in a custom template, or add extra fields (a cover image, a subtitle, a category) beside the title, all through core's Manage display UI with no custom code. If the "Page Title" view mode is not configured for a bundle, the site falls back to the normal core page-title behaviour, so the module is safe to enable site-wide. It supports Drupal 10 and 11, ships no settings form, no permissions and no dependencies beyond core.

---

- Add a subtitle or tagline underneath the main title on a node's full page.
- Show a cover image above or behind the entity title in the page-title region.
- Change the title field's formatter (for example a heading wrapper) per bundle.
- Combine the title with a category or section label in the page-title area.
- Render an author byline next to the title on article pages.
- Display a publication date beside the title on the canonical page.
- Add breadcrumb-like context fields into the page-title block.
- Build a rich "hero" header for landing-page content types.
- Customise the page title differently for each content type via view modes.
- Customise the page title differently for taxonomy terms, users or media.
- Reorder the title relative to other fields shown in the header.
- Hide or restyle the raw title while keeping the page's H1 semantics through fields.
- Attach a call-to-action button next to the title on product-style nodes.
- Show an event start date/time in the page-title area of event content.
- Include a status or badge field alongside the title.
- Apply a Layout Builder-free custom header without theme template overrides.
- Preview page-title customisations on the entity preview page (full view mode).
- Keep page-title customisations working on revision pages.
- Standardise page-title composition across bundles for editors.
- Let site builders iterate on title presentation without a developer.
- Add a short summary or lead paragraph immediately under the title.
- Surface a taxonomy term's parent or description next to the term title.
- Compose media entity page titles with metadata fields.
- Provide a consistent H1 header block reused across many content types.
- Fall back automatically to the default title when the view mode is unconfigured.
