<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Display Suite Chains lets a Display Suite layout place a single field from a referenced entity directly among the host entity's own fields, rendered with any applicable field formatter, instead of rendering the whole referenced entity in a view mode.

---

The requirement is constant on any site with a relational content model. An article references an author profile and the byline needs the author's name and photograph — not the author's rendered teaser, which brings a biography, a link and whatever else that view mode contains. An event references a venue and the listing needs the venue's town. A product references a manufacturer and the card needs the logo. Without field chaining the options are to render the referenced entity in a view mode built solely for this placement — which multiplies view modes until nobody knows which is used where — or to write a preprocess function that loads the reference and extracts the field, which is code for a display decision. Display Suite Chains makes it a placement in the same Manage Display interface where the rest of the fields are arranged. The mechanism is entirely display-time and configuration is admin-gated: it works only on a display that already uses a Display Suite layout, where a details section on Manage Display (added by `ChainsUi::alterFieldUiManageDisplay`) lists the entity reference fields whose target is a content entity with a view builder; ticking one records it in the display's `ds_chains.fields` third-party setting. A deriver (`ChainsDeriver`) then exposes one DS field per reachable `entity_type/bundle/field_name/chained_field_name` combination, offered only on the view modes where the parent reference field was enabled. When placed, the DS field (`ChainedField::build`) walks each delta of the host's reference field, and for each referenced entity renders the chosen chained field through the **target entity type's own view builder** (`viewField`) with the selected formatter — the chained field's view access is checked and each referenced entity is added as a cache dependency. Two operational notes: only formatters applicable to the chained field's type are offered, and a multi-value reference field gains a "UI Limit" setting to cap how many referenced items are rendered — because each chained field is an extra entity load, so a long list reaching through references is the usual reason a chained listing is slow.

---

- Show an author's name in a node byline.
- Display a venue's town in an event listing.
- Show a manufacturer's logo on a product card.
- Place a referenced entity's single field in a DS layout.
- Avoid building a dedicated view mode per placement.
- Show a category term's icon on an article.
- Avoid a preprocess function just to surface one referenced field.
- Show a parent page's title on a child.
- Display an organisation's address on a member profile.
- Show a referenced image field without the whole teaser.
- Place a taxonomy term's field in a node display.
- Show a supplier's contact detail in a listing.
- Display a course's department name.
- Show a referenced date field in a card.
- Show only an author's photograph, not the author teaser.
- Cap a multi-value reference to the first N items with the UI Limit setting.
- Reformat a chained field with a different formatter than the referenced entity's own display.
- Arrange chained fields alongside native fields on the Manage Display tab.
- Surface a referenced field in a teaser view mode.
- Chain a field from any content-entity reference target (node, user, term, media, and so on).
