# Configuration

Field as Block has two configuration steps: first tell it which entity types to
expose, then place and configure the field blocks themselves.

## Step 1 — Choose which entity types are exposed

1. Log in as a user with the **Administer fieldblock** permission (`administer
   fieldblock`).
2. Go to **Configuration → Field as block**, or navigate directly to
   `/admin/config/fieldblock/fieldblockconfig`.

The form lists the content entity types on your site and lets you tick which ones
should be available as field blocks. Out of the box the module behaves as if
**Content (node)**, **User**, and **Taxonomy term** are enabled — but that default
only applies until you save this form for the first time, after which your explicit
choices take over.

- **Enable an entity type** to make a matching block appear in the block library
  (for example enabling *Media* gives you a "Media field" block).
- **Disable a type** to remove its field blocks — useful on a site where user or
  term field blocks would just be noise.

If you switch a type off (or remove a custom entity type entirely), any field
blocks you had placed for it become orphaned. This form also offers to **delete
those orphaned blocks** so your Block layout stays clean. Click **Save
configuration** when you are done.

## Step 2 — Place and configure a field block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** on the region you want the field to appear in.
3. In the block picker, find the blocks in the **Field as block** category —
   *Content field*, *User field*, *Taxonomy term field*, and any other type you
   enabled — and click **Place block** next to the one you want.

The block configuration form then offers these settings:

- **Use field label as block title** — when ticked, the field's own label becomes
  the block title. Untick it to type a custom block title instead (or to hide the
  title in the usual block way).
- **Field** — the field to render. The list spans every field defined on that
  entity type's storage, so it covers all bundles (all content types, for example),
  not just one.
- **Formatter** — how the field's value is rendered (for instance the *Image*
  formatter for an image field, or a trimmed text formatter for a body field).
- **Formatter settings** — the chosen formatter's own options appear beneath it,
  such as an image style, a trim length, or a date format.

Below these you'll find the usual core block settings — region, and **Visibility**
conditions (pages, content types, roles) — which you can use to scope the field
block further.

Click **Save block**. The field now renders in your chosen region on the entity's
canonical (and revision) pages, in the page's content language, and it hides itself
automatically wherever the entity or field is not available.

> **Tip:** You can place the same field more than once with different formatters —
> for example a trimmed teaser in one region and the full text in another — because
> each placement is an independent block with its own configuration.
