# Configuration

Setting up a comparison is a few‑step process: create the comparison, choose which
fields it displays, place the add/remove link where visitors will click it, and
grant the permission that lets people use it. This page walks through each step.

## 1. Create a comparison

1. Log in as a user with the **Administer entity comparison** permission.
2. Go to **Structure → Entity comparison → Add**
   (`/admin/structure/entity_comparison/add`).
3. Fill in the form:
   - **Label** and **machine name** — the human name and internal id.
   - **Add to comparison list** — the text of the *add* link (for example "Add to
     compare").
   - **Remove from comparison** — the text of the *remove* link.
   - **Limit** — the maximum number of items a visitor may add. Enter **0** for no
     limit; a value like 3 or 4 keeps the table readable.
   - **Entity type** and **Bundle** — what visitors will be comparing (for example
     *Content* → *Product*).
4. Save.

Saving a **new** comparison does a fair amount of automatic setup: it creates a
dedicated view mode named after the comparison, rebuilds the site's routes so the
`/compare/...` page exists, and clears caches. If the compare page or its
permission does not show up right away, run `drush cr`.

## 2. Choose which fields are compared

The comparison table shows the fields you enable in the comparison's own view
mode:

1. Go to the target bundle's **Manage display** tab — for example **Structure →
   Content types → Product → Manage display**.
2. Switch to the custom display named after your comparison (it appears in the
   view‑mode list).
3. Enable and order the fields you want in the table. **Row order here is the row
   order in the comparison table**, and formatter settings apply as usual. Only
   the fields you enable appear.

## 3. Place the add/remove link

There are three ways to give visitors the link, all producing the same clickable
add/remove control:

- **In an entity display** — on the target bundle's **Manage display** for any
  view mode (Default, Teaser, …), enable the *"Link for entity comparison"*
  component. This is the usual way to put an "Add to compare" link on listing/
  teaser pages.
- **As a Views field** — in any view of that bundle, add the comparison‑link
  field.
- **As a block** — place the per‑comparison *add/remove link* block from
  **Structure → Block layout**.

There is also a second block per comparison that links to the comparison page and
shows the current item count — handy for a header "Compare (2)" indicator.

## 4. Grant the permission

Each comparison generates its own permission, **"*(label)*: Use entity
comparison"**. A visitor needs it to see the add/remove link and to open the
compare page.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant *Use entity comparison* for your comparison to the roles that should have
   it (including **Anonymous user** if you want logged‑out visitors to compare).
3. Rebuild caches (`drush cr`) after creating a new comparison so its permission
   and route appear.

The separate **Administer entity comparison** permission controls who can create,
edit, and delete comparisons in the admin UI — keep that to trusted administrators.

## The comparison page

The compare page lives at `/compare/{id}`, where the id uses dashes in place of
underscores (a comparison called `my_products` is at `/compare/my-products`). It
loads the visitor's session list and renders each entity's fields through the
comparison's view mode, with a "Remove from the list" row across the top. Lists
are per browser session and clear when the session ends.

## Extending the table (developers)

`hook_entity_comparison_rows_alter(&$header, &$rows, $comparison_context)` lets you
add, remove, or rewrite rows before the table renders — for example to add a
computed "verdict" or "score" row. The context carries the comparison config, the
entities, and the comparison fields.
