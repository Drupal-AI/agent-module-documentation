# Collapse Text — agent index

One input filter, `filter_collapse_text` ("Collapsible text blocks"), that converts
`[collapse]…[/collapse]` / `<collapse>…</collapse>` markers into HTML5 `<details>` sections.
Depends on core `filter`. No permissions, no services, no Drush. Config lives on each text
format (`configure` route = `filter.admin_overview`). Provides a config schema for its two
per-format settings and two overridable Twig templates.

- **Enabling the filter on a format, ordering rules, settings keys, the `[collapse]` syntax, and
  the XSS/sanitization responsibility** → [configure/filter.md](configure/filter.md)
- **The two theme hooks/templates and how the render tree is built** → [theming/templates.md](theming/templates.md)

Key facts:
- Plugin: `src/Plugin/Filter/CollapseText.php`, `@Filter(id="filter_collapse_text", type=TYPE_TRANSFORM_IRREVERSIBLE)`.
- Per-format settings (schema `filter_settings.filter_collapse_text`): `default_title` (string), `form` (bool, default 1 = wrap in `<form>`).
- Must run **after** "Limit allowed HTML tags", "Convert line breaks into HTML", and any HTML corrector filter.
- Section body is emitted via `Markup::create()` (marked safe); titles are `htmlspecialchars`-escaped. Sanitizing body HTML is the job of the format's other filters.
