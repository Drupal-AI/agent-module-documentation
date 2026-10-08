<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig - Remove HTML comments — agent index

A single Twig extension that adds two filters for stripping `<!-- ... -->` HTML comments from
rendered markup. No config, no permissions, no routes, no plugins, no Drush.

- **The two filters, what each returns, and the exact stripping behaviour** →
  [theming/filters.md](theming/filters.md)

Key facts:
- Service id `twig_remove_html_comments.remove_html_comments` (class `RemoveHtmlComments`,
  tagged `twig.extension`; `getName()` returns the same id).
- Filters: `remove_html_comments` → `['#markup' => <cleaned>]` (render array);
  `remove_html_comments_as_string` → cleaned **string**.
- Regex applied to both: `/<!--(.|\s)*?-->\s*|\r|\n/` → removes HTML comments (incl. multi-line)
  **plus all `\r` and `\n` newlines** and whitespace right after a comment. `NULL` → `''`.
