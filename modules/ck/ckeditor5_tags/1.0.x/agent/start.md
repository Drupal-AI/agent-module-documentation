<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Tags (Dynamic Tags) — agent start

CKEditor 5 widget for inline placeholder tokens. Project `ckeditor5_tags`; **machine name `ckeditor_tags`**
(`drush en ckeditor_tags`). Requires core `ckeditor5`.

- Toolbar item `tags` (label "Dynamic Tags"). Model: `dynamicTag` > `tagId` (code.tag-id) + `tagLabel` (span.tag-label);
  downcasts to `span.dynamic-tag[dynamic-tag=<id>]`. A post-fixer restricts the id to `[a-zA-Z0-9-_]`.
- Runtime API `window.dynamicTags.tags[<id>].replace(value)` — developer/trusted-JS driven, not content driven.
- No routes/permissions/settings form. Key files: `ckeditor_tags.ckeditor5.yml`, `ckeditor_tags.libraries.yml`,
  `ckeditor_tags.module`, `js/lib/tags.lib.js`, `js/plugin/tags/src/*`.
- See ../usage.md.
