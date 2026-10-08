Extra Block Types (EBT): Webform adds a reusable "EBT Webform" custom block type that embeds a selected Webform inline, wrapped in the shared EBT design/styling controls.

---

The module is one of the standalone Extra Block Types (EBT) block-type modules built on EBT Core. Installing it creates a single `block_content` bundle, `ebt_webform`, with three fields: a required **Form** field (a `webform` entity-reference that points at the webform to render), an optional **Text** (body) field for intro copy, and the shared **Block settings** field (`field_ebt_settings`, field type `ebt_settings`) that all EBT blocks use for design options. The block is displayed through EBT Core's `preprocess_block` hook and the module's own `block--*--ebt-webform.html.twig` templates, which wrap the content in `.ebt-block`/`.ebt-container` markup and append the inline `<style>` that EBT Core generates from the design options (margins, padding, borders, border radius, background color, background media/image, edge-to-edge, container width). The embedded webform is rendered by Webform's own `webform_entity_reference_entity_view` formatter, so the form keeps its own submission handling, access rules, and confirmation behavior. Because it is a block type, it can be placed in Layout Builder, in the block layout, or reused as an inline block, and it inherits EBT Core's site-wide colors and breakpoint settings. The module itself ships no routes, permissions, services, or Drush commands — all configuration lives in the standard block-content / field UI plus the EBT Core settings form.

---

- Place a contact or feedback webform in a Layout Builder section as a styled block.
- Add a newsletter signup webform to a landing page without theming custom block markup.
- Embed a lead-capture form in a sidebar block region across many pages.
- Reuse one "Request a quote" webform block on multiple nodes via inline blocks.
- Give a webform block a colored background and inner padding to make it stand out.
- Add an edge-to-edge, full-width form band between content sections on a homepage.
- Constrain a form block to a narrower container width for better readability.
- Put a survey webform inside a bordered, rounded card using the EBT design options.
- Combine intro text (the body field) above an embedded application form in one block.
- Add a background image with overlay behind an event registration form block.
- Build a "Contact us" footer block that renders a webform with consistent EBT spacing.
- Drop a support-ticket webform into an admin-curated block layout region.
- Present a donation webform as a highlighted, edge-to-edge call-to-action band.
- Reuse a single job-application webform block across several career pages.
- Add a course-enrollment form block styled to match other EBT blocks on the page.
- Place an RSVP webform block in a sidebar with a secondary background color.
- Embed a product-inquiry form inside a grid built from other EBT blocks.
- Add a feedback webform to a documentation page as a bottom-of-page block.
- Show a gated-content request form as a styled block above teaser content.
- Use the body field for a short privacy note above an embedded data-collection form.
- Standardize form presentation site-wide by inheriting EBT Core colors/breakpoints.
- Create per-region form blocks (header, sidebar, footer) that all share EBT styling.
- Add a beta-signup webform block to a marketing section with parallax/cover background.
- Place a multi-step webform in a Layout Builder column alongside supporting text blocks.
