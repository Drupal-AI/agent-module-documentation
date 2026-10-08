# Configuration

All this module needs is a list of the routes that should be rendered with the
admin theme.

## Open the settings form

1. Log in as a user with permission to administer appearance (an administrator by
   default).
2. Go to **Appearance → Use admin theme**, or navigate directly to
   `/admin/appearance/use-admin-theme`.

## Add the routes

On this page you enter the **route names** that must use the site's current admin
theme. Add one route name per line (for example the machine route name of a custom
form or entity-management page). When a visitor loads one of those routes, the
module negotiates the admin theme for it instead of the default front-end theme.

Because the module matches on the route *name* rather than a URL path, it can target
a specific route precisely — useful where a path-based rule would be too broad or
would not distinguish one route from another that shares a similar path.

## Save

Click **Save** and reload one of the routes you listed; it should now render with
the admin theme. If it does not, double-check that you entered the exact route
machine name and clear caches.
