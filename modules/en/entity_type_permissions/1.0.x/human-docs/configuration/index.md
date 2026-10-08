# Configuration

Configuring Entity Type Permissions is a two‑part job: first decide which entity
types should generate per‑bundle permissions (on the module's settings form), then
assign those permissions to roles (on the standard permissions page).

## 1. Choose which entity types generate permissions

1. Log in as an administrator.
2. Open the module's **settings form** (route
   `entity_type_permissions.settings_form`, reachable from the module's entry on
   the Extend page or its configuration link).
3. Select the entity types you want to manage. This is the recommended first step
   after installation — it keeps the permissions page focused by generating
   permission scopes only for the entity types you actually care about.

The same settings form also lets you **clear unnecessary permissions**: rather than
the original module's "reverse permissions" approach, you simply remove entity
types you don't need here and their permissions go away.

Save the form when you're done.

## 2. Assign the permissions to roles

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the generated permissions — they are sorted first by base entity type
   (Content, Comment, Media) and then by the specific bundle (for example
   *Article*, *Basic page*).
3. Tick the boxes for the roles that should have each permission, then save.

Note the module's permission model: viewing content still relies on core's **View
published content**, while the per‑bundle permission (for example *Access content
items "Basic page"*) is what enables operations on that bundle.

## Important: this grants, it does not restrict

Entity Type Permissions is an **additive grant**. It grants access to accounts that
hold the matching permission and stays neutral otherwise — it never removes access
that core (or another module) already allows. So:

- Use it to **open up** access to specific entity types/bundles in a granular way.
- If your goal is to *lock down* an entity type, first make sure core permissions
  (or other modules) aren't already granting that access — otherwise this module's
  neutral result won't override the existing grant.
- Always double‑check that the role assignments match your intent after saving.
