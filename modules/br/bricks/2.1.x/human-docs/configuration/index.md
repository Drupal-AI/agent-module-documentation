# Configuration

Bricks has no settings page. You "configure" it by adding a **Bricks** field to an
entity bundle and wiring up its widget and formatter through the standard Field
UI. This page walks through that setup.

## 1. Add a Bricks field

1. Go to the bundle you want to build pages on — for example **Structure →
   Content types → Article → Manage fields** — and click **Add field**.
2. Choose the **Bricks** field type (its preconfigured options are the normal
   entity-reference ones with " (bricks)" appended).
3. On the field settings, pick the **entity type this field references** (nodes,
   custom blocks, ECK entities, paragraphs — anything). Set the number of values
   to **unlimited** if you want a genuine tree rather than a single item.
4. Save. Behind the scenes the field stores, per item, a **depth** (its place in
   the tree) and an **options** blob (view mode, layout, CSS class/id) alongside
   the entity reference.

## 2. Choose a widget (Manage form display)

On the bundle's **Manage form display** tab, pick a widget for the Bricks field.
Bricks does not require a special widget — it works with **any** widget that
supports entity reference (for example the standard autocomplete). Whatever you
choose, Bricks adds the tree editing UI on top:

- A **drag-and-drop table** (tabledrag) where editors reorder items and, crucially,
  **indent** them to nest one item under another — this sets each item's depth.
- An inline **options** area per row, containing:
  - **View mode** — override the view mode used to render that referenced item
    (e.g. show one block as "featured").
  - **Layout** — shown for a *layout*-bundle item when Layout Discovery is enabled;
    choose the Layout API layout whose regions its child items drop into.
  - **CSS class** and **CSS id** — added to that individual brick's wrapper.

> The older `bricks_tree_autocomplete` widget still exists for backward
> compatibility but is **deprecated** — prefer a standard entity-reference widget.

## 3. Choose the Bricks formatter (Manage display)

On the bundle's **Manage display** tab, set the Bricks field's format to the
**Bricks** formatter (`bricks_nested`). This is what renders the referenced
entities recursively as a nested tree; without it you'd just get a flat list.
Every brick is wrapped with automatic classes — `brick`, `brick--type--<bundle>`
and `brick--id--<id>` — plus any CSS class/id you set per item, which gives you
stable hooks for theming.

## 4. Build a page

Now edit an entity of that bundle. In the Bricks field, add referenced items, drag
to reorder, and indent to nest. Set per-item options (view mode / layout / CSS)
inline. On save, Bricks normalises the depths so every child sits exactly one level
below its parent, and on display it folds the flat list into the nested tree —
distributing children of a layout item into that layout's regions, and dropping any
item the viewer isn't allowed to see (along with everything beneath it).

## Notes

- **Any depth, any entity type.** A single Bricks field can nest items arbitrarily
  deep and reference any entity type you configured in step 1.
- **Multi-column sections** come from nesting bricks inside a *layout* brick.
- **Integrations** work automatically: Entity Usage tracks where bricks reference
  entities (via a `bricks_field` tracker), and the Replicate module — if installed
  — clones bricky content correctly.
