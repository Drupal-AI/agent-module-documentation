# Filter Twig — agent index

One text-format filter (`filter_twig`) that renders a field's stored text as a Twig template
via `inline_template`, executing any Twig it contains. No config UI, no permissions, no routes,
no schema — you enable it by ticking it on a text format.

- **Enable it on a format, where the choice is stored, and the security caution** →
  [configure/enable-filter.md](configure/enable-filter.md)
- **How `process()` renders the text (inline_template, transform-irreversible)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Filter plugin id `filter_twig`, title "Replaces Twig values",
  type `TYPE_TRANSFORM_IRREVERSIBLE`, no settings.
- Enabled state lives in `filter.format.<id>` → `filters.filter_twig.status: true`.
- **Security:** it executes Twig from field content — only enable on formats restricted to
  trusted/admin roles. See the caution in the configure doc.
