# Configuration

Entity Weight has two screens: a **settings** page where you turn weighting on for
the bundles you care about, and an **ordering** page where you actually drag items
into order. There is also a per-bundle display option if you want editors to set
weight while editing content.

## Enable weighting per bundle

Go to **Configuration → Entity Weight** (`/admin/config/entity-weight`).

1. **Set the weight range** — the **minimum** and **maximum** weight values
   (default **−100 to 100**). The range also affects the field widget: a small
   range (roughly 40 or fewer options) shows a select dropdown, while a larger
   range shows a plain number input.
2. **Enable bundles** — expand each entity type section and tick the bundles you
   want to weight (for example Content → Article, Taxonomy → Tags, Media →
   Image).
3. **Include unpublished entities** *(optional)* — toggle whether unpublished
   items appear in the ordering interface. This works generically with any entity
   type that has a published status.
4. Click **Save configuration**. The `field_entity_weight` field is created
   automatically on every selected bundle, and an admin menu link is generated for
   each enabled bundle.

## Reorder entities

Go to **Structure → Entity Weights** (`/admin/structure/entity-weight`) and pick
a bundle. You will see a per-bundle table where you can:

- **Drag rows** to reorder them, or
- **Type a weight value** directly into each row.

Then click **Save order**. Ascending weight means "lightest first". Saving runs
as a batch, so large sets are handled without memory problems, and the table is
paginated at 50 entities per page. The list filters by the current language, and
weight values are translatable.

## Show the weight field to editors (optional)

By default the weight field is **hidden** on entity edit forms — its value is
still stored, so nothing is lost when editors save. If you want editors to set
weight directly while editing content:

1. Go to the bundle's **Manage form display**.
2. Click the gear icon on the **Weight** field.
3. Uncheck **Hide weight field** and save.

## Sort by weight in Views

Once a bundle is weighted, add **`field_entity_weight`** as a **Sort criteria** in
any View to order the listing by weight (ascending = lightest first).

## Cleanup

If you later uninstall the module, all the weight fields and their storage are
removed automatically.
