# better_exposed_filters — agent start

Adds an **exposed form plugin** (`bef`) to Views that replaces default select boxes with
richer widgets (checkboxes, radios, links, sliders, date pickers) for exposed
filters/sorts/pagers. Depends on `views`. Configured per-view in the Views UI (no global
config page — `configure` is null). Defines filter/pager/sort widget plugin types.

- Enable BEF on a view + set per-widget options → [configure/exposed-form.md](configure/exposed-form.md)
- The BEF widget plugin types & adding a custom widget → [plugins/widgets.md](plugins/widgets.md)
- Alter BEF options in code → [hooks/hooks.md](hooks/hooks.md)
- Theme the exposed form (templates & preprocess) → [theming/templates.md](theming/templates.md)
