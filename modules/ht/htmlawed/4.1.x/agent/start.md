<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# htmLawed — agent index

A text-format **input filter** (`filter_htmlawed`, type `TYPE_HTML_RESTRICTOR`, weight 50) that runs
content through the bundled htmLawed PHP library to restrict/correct/purify HTML. No standalone
settings page (`configure` is null), no permissions of its own, no Drush, no plugin types defined.
It is configured **per text format** and stores four settings (`config`, `spec`, `help`, `helplong`)
in the format's `filters.filter_htmlawed.settings`.

- **Enable & configure it on a text format; the four settings, default Config., config keys** →
  [configure/filter.md](configure/filter.md)
- **How filtering works (library, `safe`/`elements`/`deny_attribute`, `save_php`, `comment`), filter order** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Plugin id `filter_htmlawed`; settings live at `filter.format.<format>.filters.filter_htmlawed.settings`.
- Default Config.: `'safe' => 1, 'elements' => 'a, em, strong, cite, code, ol, ul, li, dl, dt, dd, br, p', 'deny_attribute' => 'id, style'`.
- The **Config.** string is turned into a PHP array with `eval()`; the form is gated by `administer filters`.
