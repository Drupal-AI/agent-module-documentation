# Configuration

Content filter is configured from one small settings form. You pick which content
types get their own admin listing page, and decide whether to add quick links under
the Content menu.

## Open the settings form

1. Log in as a user with the **administer content_filter** permission (grant it at
   **People → Permissions** to your site builders; administrators have it by
   default).
2. Go to **Configuration → User interface → Content filter**
   (`/admin/config/user-interface/content-filter`).

## Choose which content types get a page

Tick the content types that should each get their own dedicated listing page. For
every type you select, the module creates a page at
`/admin/content/filtered/{node_type}` showing only that type's content through the
core Content view, with the content‑type filter locked to that bundle and hidden.

## Choose how the pages are reached

There is a toggle for whether Content filter should add **submenu links under the
Content menu**:

- **On** — a submenu item appears under **Content** for each filtered page, so
  editors can jump straight to a specific content type from the menu.
- **Off** — no menu items are added, but the pages are still reachable as
  **sub‑tabs** within the Content area, keeping your menu structure untouched.

## Save

Click **Save**. For each selected content type a dedicated listing page is
generated immediately, and — if you enabled menu links — the Content submenu
updates to include them. No content types are created, and your existing content,
permissions, and text formats are left exactly as they were.

## Using the pages

Each generated page behaves like the normal content overview, but scoped to one
type:

- It offers the familiar core content filters and bulk actions.
- The content‑type filter is fixed to that page's bundle, so editors can't
  accidentally widen the list.
- An **Add {bundle}** button in the page header lets editors create new content of
  that type in one click.
- The index page at `/admin/content/filtered` links to all the filtered pages.

## A note on access

The generated pages are admin routes: reaching them requires the appropriate admin
permission, and the embedded Content view additionally applies its own access
checks, so users only ever see the content they're allowed to see. Combine this
with your role permissions to scope exactly who can use each page.
