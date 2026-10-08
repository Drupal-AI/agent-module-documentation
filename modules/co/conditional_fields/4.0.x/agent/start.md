# conditional_fields — agent start

UI-driven dependencies between entity-form fields (show/hide/require/fill/disable) via Drupal's
States API. Depends on core `field`. Config UI: **Admin → Structure → Conditional Fields**
(`/admin/structure/conditional_fields`, route `conditional_fields`), plus a "Manage Dependencies"
tab on each bundle.

- Create & configure dependencies (states, conditions, effects, value logic) → [configure/dependencies.md](configure/dependencies.md)
- Add support for a custom widget (handler plugin) → [plugins/handler.md](plugins/handler.md)
- Register pseudo-fields / child fields via hooks → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
