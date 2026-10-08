# Configuration

You create tabs on the Dynamic Local Tasks listing. Each tab is a configuration
entity, so it exports with `drush config:export` and moves between environments like
any other config.

## Open the listing

1. Log in as a user who has the permission to administer dynamic local tasks (grant
   this only to trusted administrators — see below).
2. Open the **Dynamic Local Tasks** listing from the module's **Configure** link on
   the **Extend** page (`/admin/modules`).

You'll see any tasks you've already created, with edit and delete links, plus a
button to add a new one.

## Add a dynamic local task

Add a new task and fill in its details:

- **Title** — the label shown on the tab.
- **Route** — the route the tab links to. This is the destination the tab points
  at; the route continues to enforce its own access, so the tab only appears for
  users who may actually reach it.
- **Placement / base route** — which page(s) the tab attaches to and, where offered,
  its position among the other tabs.

Save. The tab appears on the relevant page(s). Because Drupal caches its menu and
local‑task definitions, you may need to rebuild caches (`drush cr`) for a new tab to
show up.

## Edit or remove a task

Return to the listing at any time to edit a task's title, route, or placement, or to
delete it. Deleting a task removes its tab.

## A note on access and intended use

- **The module's permission gates who can create tasks**, not who can use the routes
  those tasks point to. A tab never grants access — the target route's own access
  rules still apply. Keep the administer permission limited to trusted
  administrators, since creating tabs changes the admin/entity UI site‑wide.
- **Prefer code for permanent tabs.** As the module itself notes, local tasks that
  are part of a feature should normally be defined in a module. Reach for Dynamic
  Local Tasks for the special, one‑off, or configuration‑managed cases where hand
  authoring a module is overkill.
