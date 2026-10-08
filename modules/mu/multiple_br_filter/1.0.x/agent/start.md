<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiple BR Filter (multiple_br_filter) — agent index

**Text-format filter that collapses runs of consecutive `<br>` tags into a single `<br>`.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10 || ^11
- **Depends:** filter
- **Plugin:** `@Filter(id="remove_multiple_br")`, `TYPE_TRANSFORM_IRREVERSIBLE`; regex `(<br\s*\/?>\s*){2,}` → `<br />`.
- **Setup:** enable per text format at `/admin/config/content/formats`; no config, routes or permissions of its own.
- **Security:** render-time output filter only; no anonymous or mutating endpoints; does not alter stored content.
