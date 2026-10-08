# Configuration

All of Book's settings live in a single configuration object, `book.settings`,
edited from one form. There is also an important set of permissions that decide
who can create, edit, re‑order, delete, and print books.

## Open the settings form

1. Log in as a user with the **Administer book settings** permission.
2. Go to **Structure → Books → Settings**, or navigate directly to
   `/admin/structure/book/settings`.

## The settings, field by field

- **Content types allowed in book outlines** (`allowed_types`) — this is the most
  important setting, and it starts **empty**, meaning nothing can be added to a
  book until you choose at least one type. Pick which content types may join a
  book, and for each you also set the allowed *child type* — the type a page's
  children must be (it has to be one of the types you allowed). Leave it empty and
  the Outline tab has nothing to offer.
- **Book sort** (`book_sort`, default *weight*) — how sibling pages are ordered.
  *Weight* lets editors order pages manually; *title* orders them automatically
  and alphabetically by title.
- **Truncate label** (`truncate_label`, default on) — shortens long page titles in
  the outline and parent‑select widgets so they don't overflow.
- **Use parent selector** (`use_parent_selector`, default on) — shows the
  parent‑page dropdown on the node edit form so editors can pick where a page
  sits. Turn it off to hide that selector.
- **Use alternative form** (`use_alternative_form`, default off) — an experimental
  alternative book‑outline form on the node edit page. Leave it off unless you
  specifically want to try it.

Click **Save configuration** when done. (You can also set any of these from Drush,
for example `drush config:set book.settings book_sort title -y`.)

## Permissions

Book defines eight permissions at **People → Permissions**. Grant them to your
editor and administrator roles as appropriate:

- **Administer book outlines** — the all‑books overview, per‑book re‑ordering, and
  child‑ordering screens.
- **Create new books** — start a brand‑new top‑level book from a node.
- **Add content to books** — place and move nodes within an outline via the node's
  Outline tab, and manage the hierarchy.
- **Reorder book pages** — re‑order the child pages of a book.
- **Access printer‑friendly version** — view a book page and all its sub‑pages as
  one printable document. Note this can be performance‑heavy on large books.
- **Access book list** — see the public list of all books at `/book`.
- **Delete book** — delete an entire book. Flagged as security‑sensitive.
- **Administer book settings** — reach the settings form described above. Also
  flagged as security‑sensitive.

Beyond these permissions, the Outline, remove, and print/export screens layer on
their own access checks (for example, whether a given node can actually be
removed from its book), so a user needs both the permission and the contextual
access to act.

Grant permissions to a role from Drush, for example:

```bash
drush role:perm:add editor 'add content to books'
drush role:perm:add editor 'reorder book pages'
```
