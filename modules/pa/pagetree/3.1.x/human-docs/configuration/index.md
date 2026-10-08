# Configuration

Page Tree needs two things set up before editors can use it: telling the module
**what** to show in the tree, and placing the **Page Tree Block** so editors can
reach it.

## 1. Choose what the tree displays

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Page Tree**, or navigate directly to
   `/admin/config/pagetree`.

On this settings form you tell Page Tree which parts of the site to render as a
tree:

- **Menus** — which menu(s) supply the page hierarchy. The tree is built from a
  menu's structure, so pick the menu that represents your editorial information
  architecture (for example your main navigation).
- **Languages** — which languages the tree should cover, on a multilingual site.
- **Content types** — which node types appear as manageable pages in the tree.

Save the form when you are done. These choices determine which pages editors see
and can publish, unpublish, reorder, or copy from the tree.

## 2. Place the Page Tree Block

The tree is surfaced through a block so it shows up where your editors work:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose the region of your **front-end theme** where the tree should appear and
   click **Place block**.
3. Find and place the **Page Tree Block**.
4. Configure the block's visibility (for example, restrict it to the pages or
   roles that should see it) and save.

## Permissions

Page Tree provides its own permissions governing who may use the tree widget and
manage pages through it. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant them to the editorial roles that should
manage the page hierarchy.

## A note on the publishing stack

Page Tree assumes the Frontend Publishing stack (Frontend Publishing, REST
Consumer, Pathauto) is installed and configured. The publish/unpublish status
shown in the tree, and the URL aliases for pages, come from that stack — so make
sure those modules are set up per their own documentation for the tree to behave
as expected.
