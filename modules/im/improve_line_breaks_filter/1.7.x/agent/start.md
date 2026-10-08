<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Improve Line Breaks Filter — agent index

A single text-format **filter plugin** (`improve_line_breaks_filter`) that turns empty
paragraphs (`<p></p>`, `<p>&nbsp;</p>`) into `<br />`, or deletes them. No admin page
(`configure: null`), no permissions, no Drush, no plugin types. Its only state is one boolean
setting stored inside a text format's config.

- **Enable the filter on a text format / the setting / where it is stored** →
  [configure/filter.md](configure/filter.md)
- **How it transforms text (skip list, regex, replace vs remove)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the setting lives at
`filter.format.<format>.filters.improve_line_breaks_filter` → `status: true` and
`settings.remove_empty_paragraphs: false|true` (FALSE = replace with `<br />`, TRUE = delete).
