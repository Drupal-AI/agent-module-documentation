<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Plain Text Formatter (link_plain_text_formatter) — agent index

One field formatter that renders a core **`link` field as plain text** — the link *title* when it has
one, otherwise the URL string — instead of an `<a>` anchor. Trivial module: no config page
(`configure` null), no settings form of its own, no routes, no services, no permissions, no config
schema, no plugin types. The only hook is `hook_help()` (renders an About blurb on the module's help
page). Depends only on core `link`. Version **8.x-1.3**, core `^8 || ^9 || ^10 || ^11`, package
*Field types*.

Everything you need:
- **Formatter plugin:** id `link_plain_text_formatter` (label "Plain text"),
  `src/Plugin/Field/FieldFormatter/LinkPlainTextFormatter.php`, extends core `FormatterBase`. Applies
  to field type `link`. Full reference: [`fields/link-plain-text-formatter.md`](fields/link-plain-text-formatter.md).
- **Use it:** on *Manage display* for any entity/bundle that has a Link field, set the field's Format
  to "Plain text". It exposes no formatter settings of its own.
- **Logic (`itemText()`, LinkPlainTextFormatter.php:51):** if `$item->title` is empty, take
  `$item->getUrl()` (falling back to the `<none>` route) and use `$url->toString()`; otherwise use the
  title. The chosen string is passed through `Html::escape()` and returned as the item's `#markup`.
- **No security surface** — pure render formatter; the emitted string is HTML-escaped, and there are
  no routes, services, or permissions.
