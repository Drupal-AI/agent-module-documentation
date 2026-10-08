Twig VarDumper adds `dump()` and `vardumper()` Twig functions that render variables using Symfony's VarDumper, giving you a collapsible, syntax-highlighted dump instead of core's plain output when debugging templates.

---

The module registers a single Twig extension (`Drupal\twig_vardumper\TwigExtension`) that exposes two identical functions, `dump()` and `vardumper()`, both backed by `Symfony\Component\VarDumper\VarDumper::dump()`. Call either in any `.html.twig` template to inspect one or more variables — `{{ dump(page.content) }}`, `{{ vardumper(node, user) }}`, or `{{ dump() }}` with no arguments to dump the whole template context. The output is the rich, interactive VarDumper HTML widget (the `sf-dump` block): expandable arrays/objects, type colouring, and search — far more readable than `var_dump()` or core's `{{ dump() }}`. Crucially, output is only produced when **Twig debug is enabled** (`$env->isDebug()`); with debug off the functions return `FALSE` and render nothing, so it is safe to leave calls in templates on production-like configs. The functions are variadic and marked `is_safe: html`, so the dump markup is not escaped. There is no admin UI, no configuration, no permissions, and no Drush commands — the entire surface is these two Twig functions. It requires the `symfony/var-dumper` Composer library (checked by `hook_requirements` at install time); Drupal core already ships it, so no extra dependency is usually needed.

---

- Dump a single template variable in a pretty, collapsible widget: `{{ dump(node) }}`.
- Dump the entire current template context at once with a bare `{{ dump() }}`.
- Inspect several variables in one call: `{{ vardumper(node, user, page) }}`.
- Explore deeply nested render arrays interactively (expand/collapse each level).
- Debug why a field or region is empty by dumping `page.content` or `content.field_x`.
- Use `vardumper()` as an alias when a template or theme already overrides core `dump()`.
- Search inside a large dumped structure using VarDumper's built-in search box.
- Read object types and visibility (public/protected/private) with colour coding.
- Leave dump calls in templates safely: they emit nothing unless Twig debug is on.
- Inspect the variables available inside a Views row or field template.
- Debug Single Directory Component (SDC) or paragraph templates during development.
- Check what an entity reference or media field actually exposes to Twig.
- Verify preprocess additions by dumping the variable you set in `hook_preprocess_*`.
- Compare two variables side by side by passing both to one `dump()` call.
- Inspect `attributes`/`title_attributes` objects rendered in a template.
- Get a more readable alternative to core's Twig `{{ dump() }}` for large arrays.
- Confirm a Twig `{% set %}` value by dumping it right after assignment.
- Debug menu, breadcrumb, or block render arrays in region templates.
- Teach or document a theme's available Twig variables with a shared reference dump.
- Inspect the loop variable inside a `{% for %}` to see each item's structure.
- Quickly diagnose "why isn't this rendering" issues without adding PHP breakpoints.
- Dump the `form` render array in a form template to find the right element keys.
- Verify translation/interface values exposed to a template via `t()` or `{% trans %}`.
