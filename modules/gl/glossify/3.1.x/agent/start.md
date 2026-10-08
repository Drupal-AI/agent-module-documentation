# Glossify — agent index

**API/base module.** Provides the abstract `GlossifyBase` filter plugin + two theme hooks/templates
that its submodules subclass to auto-link or tooltip matching entity labels in text. On its own it
does nothing — enable **Glossify Node**, **Glossify Taxonomy**, or **Glossify Commerce**. No settings
form of its own (`configure` points at core's Text formats page), no permissions, no Drush.

- **`GlossifyBase`: the matching engine (`parseTooltipMatch`), synonyms, exclude/ignore rules, shared settings** →
  [api/glossifybase.md](api/glossifybase.md)
- **Theme hooks & templates (`glossify_link`, `glossify_tooltip`) and how to override the markup** →
  [theming/templates.md](theming/templates.md)
- **Query-alter hooks the filters invite (`hook_query_glossify_*_tooltip_alter`, `glossify_taxonomy_vocabs`)** →
  [hooks/alter-hooks.md](hooks/alter-hooks.md)

Submodule docs (each is a real text-format filter):
- Glossify Node → `../modules/glossify_node/3.1.x/agent/start.md`
- Glossify Taxonomy → `../modules/glossify_taxonomy/3.1.x/agent/start.md`
- Glossify Commerce → `../modules/glossify_commerce/3.1.x/agent/start.md`

Key fact: output markup is `<abbr tabindex="0" class="glossify-tooltip-tip" title="…">word</abbr>`
(tooltips) or `<a class="glossify-tooltip-link" href="…">word</a>` (links). Wrap text in
`class="glossify-exclude"` to skip it.
