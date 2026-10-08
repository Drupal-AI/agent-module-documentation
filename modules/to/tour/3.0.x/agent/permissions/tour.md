# Permissions

Defined in `tour.permissions.yml`.

| Permission | Gates |
|---|---|
| `access tour` | Seeing/running tours: the toolbar Tour button, the `tour_button_block` block, the Navigation top-bar item, and the `tour.recap` page. Checked in `TourHooks::toolbar()`, `TourHooks::pageBottom()`, `TourButtonBlock::blockAccess()`, and `TourTopBarItem::build()`. |
| `administer tour` | The entire tour admin UI — create/edit/clone/delete tours and tips, enable/disable, and the global settings form. It is the entity `admin_permission` and gates every `/admin/config/user-interface/tour/*` route. Marked `restrict access: true` (trusted). |

Note: JavaScript must be enabled in the browser for a user with `access tour` to actually
see a tour (Shepherd.js renders it).

```
drush role:perm:add editor 'access tour'
drush role:perm:add site_manager 'administer tour'
```

The **tourauto** submodule adds no permissions; it reuses `access tour`.
