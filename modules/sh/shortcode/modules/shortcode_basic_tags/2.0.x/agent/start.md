<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode Basic Tags — agent index

Ships ten ready-made `@Shortcode` plugins for the parent `shortcode` module: `block`, `button`,
`clear`, `dropcap`, `highlight`, `img`, `item`, `link`, `quote`, `random`. No settings form, no
configure route, no permissions, no services of its own — every tag must still be enabled per
text format (see the parent module's `shortcode/2.0.x/agent/configure/enable-filter.md`, i.e.
[../../../../2.0.x/agent/configure/enable-filter.md](../../../../2.0.x/agent/configure/enable-filter.md))
before `[tag]` markup is parsed instead of shown as literal text.

- **What each tag renders, its key attributes, and its template** →
  [plugins/tags.md](plugins/tags.md)

Key fact: every plugin id here doubles as its token (none override `token` in the annotation),
so `[quote]`, `[button]`, `[highlight]`, `[dropcap]`, `[img]`, `[link]`, `[block]`, `[item]`,
`[clear]`, `[random]` are both the plugin id used in `filter_settings.shortcode` and the literal
bracket tag an editor types.
