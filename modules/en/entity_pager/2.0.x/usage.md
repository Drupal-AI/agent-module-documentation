Entity Pager adds a Views **style plugin** (`entity_pager`) that renders Next / Previous / All navigation on an entity's canonical page, based on a View that lists the sibling entities.

---

The module provides one thing: a Views style plugin with id `entity_pager` (class `Drupal\entity_pager\Plugin\views\style\EntityPager`). You build an ordinary View (usually a **block** display) that lists the entities you want to page through — e.g. a View of published Article node IDs sorted by created date — and set its Format to *Entity Pager*. When that block is placed on an entity page, the module detects the current entity from the route, finds its row in the View's results, and renders a `< prev / All / next >` pager linking to the adjacent entities' canonical URLs. The style options let you set the prev/next/all labels (HTML allowed), an "All" link URL and label (which accept tokens like `[node:field_company]`), a records count ("5 of 8"), circular paging (wrap last→first), whether to show disabled links at the ends, and an optional Views **relationship** so the pager can navigate related entities rather than the base entity. Links, current index and total count are computed at preprocess time by the `entity_pager.factory` service, which builds an `EntityPager` object per view. The module ships a disabled demo View, `entity_pager_example`, with a block display you can enable as a working example. It has no configure route, no settings form, no permissions and no Drush; its only persistent state is the per-view style configuration stored inside each `views.view.*` config entity.

---

- Add Next / Previous links to node pages so visitors can walk through articles in order.
- Render a `< prev  All  next >` pager on any content entity's canonical page (nodes, users, taxonomy terms, media).
- Build a block View of a content type and page through its members from each member's page.
- Navigate through a brand's products and offer an "All" link back to the brand/listing page.
- Provide sibling navigation ordered by a custom field (weight, date, title) via the View's sort.
- Use circular paging so the last item's "next" wraps to the first item and vice versa.
- Show a "5 of 8" position counter alongside the prev/next links.
- Customise the Next / Previous labels with HTML (e.g. arrow icons or markup).
- Point the "All" link at a Views listing page, the front page (`<front>`), or a token-derived URL.
- Use a token like `[node:edit-url]` or an entity-reference token `[node:field_company]` for the "All" link.
- Auto-display a referenced entity's title as the "All" link text by putting the same entity reference token in the label box.
- Place multiple different Entity Pager blocks on the same entity (e.g. one global, one per-category).
- Add a Views **relationship** so the pager links to a related entity instead of the base row entity.
- Keep disabled (greyed) prev/next links at the first/last item, or hide them entirely.
- Restrict which entities are in the pager sequence using the View's filters (published, type, language).
- Enable the shipped `entity_pager_example` demo block for a ready-made node pager.
- Give editors quick prev/next navigation between records without a custom module.
- Build "previous story / next story" navigation for a news or blog section.
- Page through catalogue items, portfolio pieces, or gallery entries in a defined order.
- Provide language-aware navigation (the pager links to the current language's translation when available).
- Add sub-navigation on related entities, e.g. move between a company's job listings.
- Order the pager by created date ascending to walk a timeline oldest→newest.
- Combine with Entity Reference to create generic "up to parent / prev sibling / next sibling" navigation.
- Style the pager with the shipped `entity_pager/entity-pager` CSS library and the `entity-pager.html.twig` template.
- Expose a count-only or links-only pager by toggling "Display count" and "Display All link".
