# Theming CSHS

`cshs.module` implements `hook_theme()` and ships three Twig templates in `templates/`:

| Template | Theme hook | Used for |
|---|---|---|
| `cshs.html.twig` | `cshs` | The widget/element wrapper markup (the set of level selects). |
| `cshs-term-group.html.twig` | `cshs_term_group` | Grouped-term output (the `cshs_group_by_root` formatter). |
| `cshs-help.html.twig` | `cshs_help` | The inline help/description shown with the widget. |

- Override any of these by copying the template into your theme and clearing caches
  (`drush cr`), or via a `THEME_preprocess_cshs()` hook.
- Frontend assets (JS/CSS that drive the client-side drill-down) live under `build/` and
  `frontend/` and are attached as a library by the element.
- `cshs.module` also implements `hook_config_schema_info_alter()` to extend widget/formatter
  schema handling — relevant if you add settings, not for normal theming.
