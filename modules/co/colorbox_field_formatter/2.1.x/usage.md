Colorbox Field Formatter provides field formatters that render a field's value as a link which opens in a Colorbox lightbox — pointing at the entity's own page, a manually entered (token-aware) URL, an image, or inline/node content.

---

The module ships three `@FieldFormatter` plugins that you assign on *Manage display*: `colorbox_field_formatter` (for `string` and `computed` fields), `colorbox_field_formatter_image` (for `image` fields, extending the base one), and `colorbox_field_formatter_entityreference` (for `entity_reference` fields). Each field item is wrapped in a `<a class="colorbox ...">` link built with Drupal's Link API; the popup size is passed as `?width=&height=` query parameters, with options for iframe mode, a fragment/anchor, extra CSS classes, and a `rel` group so Colorbox can cycle through a gallery. The **Style** setting is `default`, or `colorbox-inline` / `colorbox-node` when the respective Colorbox submodules are enabled (inline mode adds `data-colorbox-inline`, `data-width`, `data-height` attributes and uses an inline selector). The **Link colorbox to** setting chooses the destination: `content` links to the entity's canonical URL, while `manual` lets you type a URI that is run through the Token service (when the Token module is present, with a token browser in the form). The image variant adds an **Image style** setting (any image style, plus a special `hide` value to suppress the image) and uses the image as the clickable thumbnail; the entity-reference variant hides the link_type/link fields and always links to the referenced content. The formatter attaches Colorbox's JS/CSS via the `colorbox.attachment` service when applicable. It has no admin settings page, no permission, and no config schema of its own; all settings live in the `entity_view_display` component's `settings`. Requires the Colorbox module (`drupal/colorbox ^2.0`).

---

- Open a node's Title field in a Colorbox popup that loads the node page.
- Turn a text field into a lightbox link pointing at a manually entered URL.
- Use tokens (e.g. `[node:field_x]`) in the manual link so each row links somewhere dynamic.
- Display an image field as a thumbnail that opens the larger image in a Colorbox.
- Choose an image style for the clickable thumbnail while linking to the original.
- Hide the image entirely (image style `hide`) but keep the Colorbox trigger.
- Make an entity-reference field open the referenced entity in a lightbox.
- Group several formatted links with a shared `rel` so Colorbox shows next/prev gallery arrows.
- Load external content in an iframe inside the Colorbox (iframe mode).
- Set a fixed popup width and height for consistent modal sizing.
- Jump to a specific anchor/fragment of the linked page inside the modal.
- Add custom CSS classes to the Colorbox link for styling or JS hooks.
- Use `colorbox-inline` style to open hidden inline markup (via a selector) in the lightbox.
- Use `colorbox-node` style (with the colorbox_node submodule) to load a node in the modal.
- Present a "read more" text field that expands into a modal instead of navigating away.
- Show product spec fields in a popup from a product listing View.
- Build an image gallery from an image field where each item cycles within one Colorbox group.
- Provide a quick-preview link on a teaser that opens the full content in a modal.
- Format a computed field's output as a Colorbox trigger.
- Keep users on the listing page by loading detail content in a lightbox rather than a new page.
- Configure the modal entirely through Manage display, exportable as entity_view_display config.
- Reuse the formatter across content types, media, taxonomy terms, or any fieldable entity.
- Offer a manual-URL lightbox link to a PDF or external resource sized to your chosen dimensions.
- Combine with Views field displays to add Colorbox triggers to tabular or grid listings.
