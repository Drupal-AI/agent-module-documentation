# views_bulk_operations — agent start

Adds a checkbox + actions field to any View to run bulk Action plugins on selected (or all)
results, via Batch API. Depends on core `views`. No central config UI — configured per View
by adding the **Views bulk operations** field to a display.

- Add & configure the VBO field on a View → [configure/views-field.md](configure/views-field.md)
- Write a custom bulk action (VBO Action plugin) → [plugins/vbo-action.md](plugins/vbo-action.md)
- Services & running VBO programmatically → [api/services.md](api/services.md)
- Alter the available action list (event) → [extend/events.md](extend/events.md)
- Run a view's action from the CLI → [drush/commands.md](drush/commands.md)
- Per-role, per-action permissions (submodule) → see module `actions_permissions`
