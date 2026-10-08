# Configuration

Configuring Custom Permissions means creating the permissions you want, then
assigning them to roles. This page walks through both.

## Open the management form

1. Log in as a user with the **Administer custom permissions** permission (grant
   this only to trusted admins — it lets someone create permissions and change
   which routes they gate).
2. Go to **People → Custom permissions**, or navigate directly to
   `/admin/people/custom-permissions/list`.

## Create a custom permission

The form is a list of rows. Each row has:

- **Enabled** — a checkbox. A disabled permission provides nothing and leaves its
  routes untouched, so you can turn a permission off without deleting it.
- **Name** — the human label. This becomes the **permission's title** on the
  Permissions page, and the machine ID is generated automatically from it.
- **Route(s)** — one or more Drupal route *machine names* (not URLs/paths). To
  gate several routes with one permission, list each route name on its own line.

Fill in a row and click **Save**. To delete a permission, clear its name and
route and save, or use the delete link.

Some common route names you might gate:

| Route machine name | The page it controls |
|--------------------|----------------------|
| `system.site_information_settings` | Basic site settings (site name, slogan) |
| `system.file_system_settings` | File system settings |
| `system.performance_settings` | Performance / caching settings |
| `entity.date_format.collection` | Date and time formats |
| `entity.user.admin_form` | Account settings |
| `dblog.overview` | Recent log messages |

## Rebuild the router

After you create, enable, disable, or change the routes of a permission, rebuild
the cache so the access override is applied (or removed):

```bash
drush cr
```

## Assign the permission to a role

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find your new permission by its **Name/label** and tick it for the roles that
   should have it. (Each custom permission carries the fixed warning "This
   permission may have security implications.")
3. **Important:** for the scoping to actually restrict anyone, remove the broad
   **Administer site configuration** permission from those roles. Custom
   Permissions *replaces* a route's normal access check, so a role that could
   previously reach the page via `administer site configuration` is blocked unless
   it holds the matching custom permission. **User 1 always keeps access**
   regardless.

## Deploying across environments

Because each permission is a config entity, you can export them as configuration
and deploy them like any other config — handy for seeding a consistent set of
scoped admin permissions across environments or in an install profile.
