# views_templates — agent start

Developer API to ship pre-built Views as **templates** and clone them into real, editable
View entities. A module registers a `@ViewsBuilder` plugin (in `Plugin/ViewsTemplateBuilder`)
that either builds a View in code or loads a `*.yml` template from its own `views_templates/`
folder. Depends on core `views`. No config/permissions/Drush of its own; UI is gated by the
core `administer views` permission. Not itself configurable (`configure` = null).

- Define a Views template — the `ViewsBuilder` plugin type, base classes, YAML templates, replacements → [plugins/views_templates.md](plugins/views_templates.md)
- Clone a template in code / the loader service / entity flow → [api/views_templates.md](api/views_templates.md)
- Create a view from a template in the admin UI (routes, form, local action) → [configure/views_templates.md](configure/views_templates.md)
