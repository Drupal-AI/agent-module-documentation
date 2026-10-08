Address display adds a configurable field formatter, "Address Display" (`address_display_formatter`), for `address` fields — letting you choose which address components are shown, in what order, and with what separators.

---

The module provides a single field formatter plugin, `address_display_formatter`, that extends the Address module's `AddressPlainFormatter` and works on any field of type `address`. You select it on an entity's *Manage display* page. Its settings form renders a draggable (tabledrag) table listing every address component — organization, address_line1/2/3, locality, postal_code, country_code, administrative_area, given_name, family_name, langcode, etc. — each with a **Display** checkbox, a **Glue** text field (a separator string appended after that component), and a **Weight** to control order. Only the ticked components are rendered, in weight order, each wrapped in a `<span>` with classes like `address-display-element` and `<component>-element`; the configured glue is appended after every component except the last. The `country_code` value is rendered as the country's human-readable name. Settings are stored on the entity's `entity_view_display` config as the formatter's `settings.address_display` sequence (keyed by component, each with `display`, `glue`, `weight`). The module has no settings page, configure route, permissions, or Drush commands — all configuration is per field, per view mode, through the formatter settings.

---

- Show only the city and country of a stored address, hiding street and postal details.
- Render a member directory that displays organization and locality but not the full street address.
- Reorder address components so the country appears first for an international audience.
- Add a comma-and-space separator between locality and postal code with the Glue field.
- Display a compact single-line address on a teaser view mode and the full address on the full view.
- Hide personal name components (given_name / family_name) when showing a business address.
- Show the administrative area (state/province) that the default address formatter omits.
- Present a store-locator listing with just address_line1, locality, and country.
- Control the separator between address lines without writing a custom template.
- Build a print-friendly address block by trimming components to the essentials.
- Format a "contact" paragraph's address field to show only what's relevant per context.
- Reorder components to match a locale's conventional address order.
- Display the country as its full name (e.g. "United States") rather than its ISO code.
- Provide different address presentations across multiple view modes of the same field.
- Suppress the postal code on a public-facing view for privacy.
- Show organization + country only, for a partner logos-and-locations grid.
- Add custom punctuation between components using per-component glue strings.
- Present a profile entity's address with only city and region shown.
- Keep the underlying address data intact while varying only which parts are displayed.
- Configure the display entirely via exported config (`settings.address_display`) for deployment.
- Give editors a consistent, minimal address rendering across content types.
- Emphasize locality by placing it at the top via weights.
- Render address components with semantic CSS classes for targeted styling.
- Trim a commerce store address down to city and country for a summary card.
