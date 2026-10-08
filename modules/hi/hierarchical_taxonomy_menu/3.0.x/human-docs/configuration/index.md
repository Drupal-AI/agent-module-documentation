# Configuration

There is no global settings page — you configure everything on a **block instance**.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the menu (for example a sidebar), click **Place
   block**.
3. Choose **Hierarchical Taxonomy Menu**.

The block's configuration form then appears. You can place several instances, each
built from a different vocabulary.

## Block settings, field by field

### The essentials

- **Vocabulary** *(required)* — the taxonomy vocabulary the menu is built from. Its
  term hierarchy becomes the menu.
- **Maximum depth** — how many sublevels to show, from 0 to 10, or **Unlimited**
  (the default). Lower it to keep a large vocabulary manageable.
- **Dynamic block title** — make the block's title the name of the taxonomy term
  currently being viewed.
- **Hide block** — hide the block entirely when it would render no items.
- **Cache max‑age** — how long the block is cached; balance freshness against
  performance.

### Collapsing

- **Collapsible** — collapse the menu by default so users expand and collapse
  branches.
- **Stay open** — keep the branch of the current term open (requires *Collapsible*).
- **Interactive parent** — make parent items both collapsible and clickable links
  (requires *Collapsible*).

### Scoping to part of the vocabulary

- **Base term** — limit the menu to the children of a specific term, rather than
  showing the whole vocabulary.
- **Dynamic base term** — automatically scope the menu to the current term's subtree
  as the visitor navigates.

### Term images

If the vocabulary's terms have an image field, the menu can show a thumbnail next to
each item:

- **Use image style** — size the thumbnails with an image style instead of fixed
  pixels.
- **Image style** — the image style to use when the above is on.
- **Image width / Image height** — explicit pixel dimensions (default 16×16) when not
  using an image style.

### Referencing‑entity counts

Show how many pieces of content reference each term:

- **Show count** — off, count **nodes**, or count **Commerce products**.
- **Referencing field** — the reference field used to do the counting.
- **Calculate count recursively** — include descendant terms' content in each count.
- **Exclude empty terms** — hide terms that have no referencing content, for a
  cleaner menu.

Save the block. It renders immediately in its region.

## Theming

The block outputs through the `hierarchical-taxonomy-menu.html.twig` template and
attaches the module's CSS/JS (which powers the collapse behavior). Override the
template in your theme if you want to change the markup.
