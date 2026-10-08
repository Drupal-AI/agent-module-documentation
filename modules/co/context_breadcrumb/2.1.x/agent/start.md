# Context Breadcrumb — agent index

Define breadcrumbs through the Context module (a "Breadcrumb" reaction), with token support and an
optional Schema.org JSON-LD output. Depends on `context` (Token/Ctools recommended). `configure` route
`context_breadcrumb.settings_form`. Permission: `administer context breadcrumb`.

- **Settings form (JSON-LD toggle) + the Breadcrumb context reaction rows/tokens** →
  [configure/settings.md](configure/settings.md)
- **The plugins it defines (context reaction, taxonomy vocabulary condition, context provider) and the
  breadcrumb builder / JSON-LD services** → [plugins/plugins.md](plugins/plugins.md)

Key facts:
- Reaction `context_breadcrumb`: up to 9 rows of {title, url, token flag, weight}.
- `ContextBreadcrumbBuilder` is a `breadcrumb_builder` at priority 9999 (wins over most builders).
- Config object `context_breadcrumb.settings` → single key `enable_json_ld` (default false).
- JSON-LD: placeholder `<script type="context_breadcrumb_ld">` injected by
  `hook_page_attachments_alter`, replaced with `application/ld+json` BreadcrumbList by `ResponseSubscriber`.
