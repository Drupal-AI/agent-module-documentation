# highlight.php — agent index

Text-format filter that syntax-highlights `<code>` tags server-side using `scrivo/highlight.php`
(PHP port of highlight.js). Emits escaped `hljs` span markup — it does **not** execute code.
Depends on core `filter`. Config UI at `/admin/config/content/highlight-php`
(`highlight_php.settings` route, permission `administer site configuration`). No permissions of its
own, no Drush, no plugin types defined (it *implements* a core filter plugin).

- **Settings (mode/auto/manual, regex, language whitelist) + enabling the filter on a text format** →
  [configure/settings.md](configure/settings.md)
- **The `|highlight` Twig filter and the `highlight_php_highlight()` function for custom code** →
  [api/twig.md](api/twig.md)

Key facts:
- Filter plugin id `filter_highlight_php`, type `TYPE_TRANSFORM_IRREVERSIBLE`; title "Highlight
  &lt;code&gt; tags in HTML." Enable it per text format on `/admin/config/content/formats`.
- Config `highlight_php.settings`: `mode` (`auto`|`manual`), `auto_languages` (space-separated
  whitelist, default `html php javascript css twig yaml go protobuf sql`), `manual_regex`
  (default `language-([a-zA-Z1-9]*)`).
- CSS library `highlight_php/main` (`css/a11y-light.css`, `css/main.css`) auto-attached when
  highlighting runs; style `.hljs` / `hljs-*` classes for further theming.
- Requires a `<code>` element in the markup — pairs with CKEditor's "Code block" button.
