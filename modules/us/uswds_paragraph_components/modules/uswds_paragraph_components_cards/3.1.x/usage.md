Submodule of USWDS Paragraph Components that installs USWDS **card group** paragraph types (regular and flag layouts) with responsive per-breakpoint columns, media images and optional card-wide links.

---

Enabling this submodule (which requires `uswds_paragraph_components_breakpoints`) imports two container bundles and two card-item bundles plus an `image` media type and a `uswds_classes` taxonomy. Containers: `uswds_card_group_regular` and `uswds_card_group_flag` each hold `field_cards` (nested card items), `field_uswds_classes` (extra utility classes from the `uswds_classes` vocab); the flag group adds `field_alternating_flags` to alternate the media side down the list. Item bundles: `uswds_card_regular` and `uswds_cards_flag` carry `field_card_title`, `field_text` (formatted text), `field_card_image` (media reference), `field_button` (link), `field_make_card_link` (make the whole card a link), and `field_card_breakpoints` (nested `uswds_card_breakpoints` rows → responsive `grid-col-*`). Regular cards add `field_title_first`, `field_indent_media`, `field_extend_media`; flag cards add `field_image_position` (media left/right). Templates emit `usa-card-group` / `usa-card` / `usa-card--flag` markup and attach the `uswds-cards` CSS shim in non-preview view modes. Expose only the two `*_group_*` bundles on your field.

---

- Build a responsive group of USWDS cards for a landing page or listing.
- Use the flag card layout with media beside the text instead of above it.
- Alternate the image side left/right across flag cards automatically.
- Set per-breakpoint column counts (e.g. 3 across on desktop, 1 on mobile) via card breakpoint rows.
- Add a media-library image to each card.
- Turn an entire card into a single clickable link to the card's URL.
- Add a call-to-action button/link in the card footer.
- Indent or extend (exdent) the card media within regular cards.
- Put the card heading before the media with the title-first option on regular cards.
- Apply extra USWDS utility classes to the whole card group via the `uswds_classes` taxonomy.
- Show a title-only, text-only, or fully populated card depending on which fields are filled.
- Compose a mixed grid of cards with different content but consistent USWDS styling.
- Default cards to a 6-column (half) width when no breakpoints are configured.
- Reference the shipped `image` media type for card imagery without extra setup.
- Override `paragraph--uswds-card-group-regular/flag.html.twig` to customize card markup.
- Provide accessible, standardized card components across a federal site.
- Nest a card group inside a columns component to build multi-region layouts.
