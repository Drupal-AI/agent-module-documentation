DraggableViews makes the rows of a View draggable so editors can rearrange them by drag-and-drop and persist a custom manual order.

---

DraggableViews adds a special Views field (`Draggableviews: Content`) and a matching sort handler (`Draggableviews: Weight`) to Views. When both are present on a display, the view renders as a table whose rows can be dragged into a new order; a "Save order" button (gated by the `access draggableviews` permission) writes each entity's weight to the `draggableviews_structure` database table. Because ordering is keyed by view name, display and arguments, the same entities can carry different manual orders in different views. A companion sort plugin then reads those weights back so any display — page, block, feed — shows the saved order. It also supports parent/child hierarchy, rendering indentation for nested rows. It works with any entity type exposed to Views (nodes, media, users, taxonomy terms, custom entities) via a `hook_views_data_alter()` that joins each entity base table to the draggableviews structure table. A migrate destination plugin (`draggableviews`) lets you import saved orders during migrations, and the `DraggableViews` helper class exposes depth/parent/ancestor lookups for theming. Typical setup is a "sort" display (a table where you drag) plus a "display" display (page/block) that reads the same weight.

---

- Let editors manually order a list of nodes by dragging rows in a view.
- Build a hand-curated "featured content" block whose order is set by drag-and-drop.
- Order staff/team member profiles for an About page.
- Sequence steps in a how-to or curriculum built from nodes.
- Arrange a photo or media gallery in a bespoke order.
- Curate a homepage promo carousel source order.
- Order taxonomy terms or term-referenced content manually.
- Reorder menu-like link lists rendered through Views.
- Give products a merchandising order independent of price/date.
- Maintain a manually ranked "top picks" list.
- Provide different manual orders of the same content in different views (via args).
- Create a sortable table of users for administrative ordering.
- Build a parent/child hierarchy of rows with visual indentation.
- Persist ordering per view display so a page and block can differ.
- Expose the saved weight as a Views sort on a public-facing display.
- Filter or take the weight as a Views argument for advanced displays.
- Import a legacy manual sort order via the migrate destination plugin.
- Restrict who may re-sort content with the `access draggableviews` permission.
- Order event or agenda items for a program schedule.
- Sort FAQ entries into a deliberate reading order.
- Arrange slides or banners for a rotating hero.
- Reorder testimonials or case studies for emphasis.
- Provide a drag-to-sort admin screen for content moderators.
- Order gallery entities such as media items for a lightbox sequence.
- Invalidate list caches automatically so reordered content updates everywhere.
