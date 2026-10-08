# Configuration

There are two things to configure with Field as Block: **placing a field block**
(the main task) and, occasionally, **choosing which entity types** are available
as field blocks. Most sites only ever do the first.

## Place a field block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the region you want the field to appear in and click **Place block**.
3. Choose one of the field-block entries: **Content field** (for node fields),
   **User field**, or **Taxonomy term field**. There is one entry per enabled
   entity type.
4. The block configuration form appears with these settings:
   - **Use field label as block title** *(on by default)* — when ticked, the
     field's own label becomes the block's title. Untick it to set a custom block
     title (or hide the title) instead.
   - **Field** — the field to render. The list contains every field defined on
     that entity type, across all its bundles (so a node field block lists fields
     from every content type). Changing the field reloads the formatter list.
   - **Formatter** — how to render the chosen field. The options are the
     formatters that apply to that field type — for example a body field offers
     *Default* or *Summary or trimmed*, an image field offers *Image* (with an
     image style), a date field offers *Default*, and an entity-reference field
     offers *Label*.
   - **Formatter settings** — the selected formatter's own options (trim length,
     image style, date format, and so on), shown in a sub-form.
5. Set the block's **visibility** conditions and region as you would for any
   block, then **Save block**.

That's it. Now visit an entity of the matching type (for example a node's page)
and the field renders in your chosen region.

## Good to know about how field blocks behave

- **They appear only on the entity's page.** A field block shows up on routes that
  carry the entity — in practice its canonical page (like `/node/12`). It does
  **not** appear on the edit form or on listing pages, and it simply stays hidden
  on unrelated pages.
- **They hide themselves when empty.** If the field has no value on a given
  entity, or the visitor lacks permission to view the field, the block renders
  nothing at all — no empty wrapper markup.
- **One placement covers every bundle.** A "Content field" block is not tied to a
  single content type; it renders the field on any node that has it. Use the
  block's visibility settings if you want to restrict it to particular content
  types.
- **Translations and caching are handled.** The field renders in the current
  interface language, and the block carries the entity's cache tags so it
  refreshes when the entity is saved.
- **Place the same field twice** with different formatters if you want, for
  example a trimmed teaser in one region and the full text in another.

## Choose which entity types expose field blocks

By default you get field blocks for **nodes**, **users**, and **taxonomy terms**.
To add another content entity type (such as media) or remove one you do not need:

1. Log in as a user with the **Administer fieldblock** permission.
2. Go to **Configuration → System → Field as Block settings**
   (`/admin/config/fieldblock/fieldblockconfig`).
3. Under **Enable Entity Types**, tick the content entity types that should offer
   field blocks and untick those that should not.
4. If you previously placed field blocks for an entity type you are now switching
   off (or that no longer exists), the form shows a **cleanup** section listing
   those leftover blocks. Tick the ones you want removed — this deletes those
   orphaned block placements.
5. Click **Save configuration**.

After saving, the new block types appear (or disappear) in Block layout's **Place
block** list. If you make the change from the command line instead, clear caches
(`drush cr`) so the block list rebuilds.

> Note: only **content** entity types are offered here — configuration entities
> are not eligible.
