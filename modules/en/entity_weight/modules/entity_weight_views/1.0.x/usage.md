Entity Weight Views lets you give a specific Views display its own drag-and-drop order, stored independently of the global entity weight field.

---

This submodule of Entity Weight adds a "Reorder view" contextual link to view displays you select on the main Entity Weight settings form. Each selected display gets its own order stored in a dedicated `entity_weight_views_order` table (keyed by view id, display id, entity id and language), completely separate from the `field_entity_weight` value. The reorder form loads all rows the view matches (overriding its pager) so any item can be dragged into the top positions, and it tells you how many rows fall within the display's own limit. The order is injected into the view query at the highest priority, so it wins over the view's other sorts. Multilingual sites share one order across languages by default; from a language's reorder page you can opt that language into its own order or reset it back to the shared one. It requires the parent `entity_weight` module plus core `views` and `contextual`, and reuses the "assign entity weight" permission.

---

- Give a "Latest news" block its own manual order without touching the underlying nodes.
- Order a promoted-content view differently from the same content's global weight.
- Reorder only the items one view shows, respecting that view's filters and conditions.
- Add a visible "Reorder items" button to a view's header, footer or empty area.
- Curate which items land within a paged view's display limit by dragging them to the top.
- Reorder a full result set even when the view only shows the first N rows.
- Keep two displays of the same view (page and block) in different orders.
- Maintain a single shared order across all site languages by default.
- Opt a specific language into its own custom order for a view display.
- Reset a language's custom order and fall back to the shared order.
- Enable or disable per-view reordering from the central Entity Weight settings form.
- Let editors reorder view items straight from the front end via the contextual link.
- Order a view of taxonomy terms, media or paragraphs, not just nodes.
- Keep changes live immediately, since saving invalidates the relevant view caches.
- Reorder without modifying entities, so no new revisions or edits are created.
- Give editors reorder access through the shared "assign entity weight" permission.
- Order a menu-like listing built as a view exactly as you want it displayed.
- Prioritize featured items at the top of a listing independently of publish date.
