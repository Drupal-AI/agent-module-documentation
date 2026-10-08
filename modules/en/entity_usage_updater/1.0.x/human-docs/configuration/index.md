# Configuration

Entity Usage Updater gives you three admin pages: two working forms that edit
content and one settings form. All of them assume Entity Usage is already
tracking the references you want to touch.

> **Back up first.** Both working forms edit your content directly and may create
> new revisions. Take a database backup before running a large update, and
> consider trying it on a staging copy first.

## Grant the permission

The two content-mutating forms are gated by the **`update referenced entities`**
permission, which Drupal flags as a restricted, sensitive capability. Grant it at
**People → Permissions** (`/admin/people/permissions`) only to roles you fully
trust — it lets a user rewrite references across arbitrary content. The settings
form is separate and requires **Administer site configuration**.

## Update entity references

**Content → Update entity references** (`/admin/content/update-references`)

This is the "repoint everything" form. You tell it:

- The **target entity** to find — the entity currently being referenced (for
  example node 21).
- The **replacement id** — the entity references should point at instead (for
  example node 42).

On submit, every tracked reference to the target is rewritten to the
replacement. This spans entity reference fields, HTML links in text fields, core
Link fields, and Linkit links, and it reaches into revisions, Paragraphs, and
content under content moderation. The module validates edits against entity
constraints as it goes. Typical uses are consolidating duplicate entities, or
fixing references *before* deleting an entity so you do not leave broken links
behind.

## Link remover

**`/admin/config/content/link-remover`**

Where the update form *repoints* references, the Link remover *removes* them.
Enter the details of the entity whose links you want gone, and the form strips
links to it out of your content (HTML links, Link fields, and Linkit links). Use
this when the target should simply no longer be linked rather than swapped for a
replacement.

## Settings

**`/admin/config/content/entity-usage-updater`** (requires **Administer site
configuration**)

The settings form configures the module and controls which reference-type
"updater" plugins apply when the forms run. The module ships plugins for entity
reference fields, HTML links, core Link fields, and Linkit links; developers can
add support for new reference types with a custom `EntityUsageUpdater` plugin.
For most sites the defaults are fine — visit this page only if you need to narrow
which reference types are processed.
