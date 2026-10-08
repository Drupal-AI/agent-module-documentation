<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kuula Embed (kuula_embed) — agent index

**Field type + widget + formatter that embeds a Kuula 360° panorama (by URL) in an iframe.**

- **Version:** 1.0.x (dev-1.0.x checkout)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Field type:** `kuula_field` (columns: `value` = embed URL, `use_css` = int flag). **Widget:** `kuula_widget`. **Formatter:** `kuula_format`.
- **No routes, no permissions, no services.** Pure Field API plugin set.
- **Setup:** add a "Kuula Embed" field via *Manage fields*, set the URL per entity, configure the formatter.

**Security:** no web endpoints of its own; output is an iframe whose `src` is the editor-supplied field value (rendered via an `inline_template`). Gate the field behind trusted field-edit access. No security findings.