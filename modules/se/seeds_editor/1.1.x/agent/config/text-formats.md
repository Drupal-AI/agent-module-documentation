<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Editor — installed text formats & editors

The module's real payload is config. On install, `config/install` creates two formats + editors;
`config/optional` adds a third when its supporting modules are present. Each `filter.format.*`
carries an `editor.editor.*` bound to it. None of these formats is granted to any role by the module
— like core's Full HTML they are usable only by users with `administer filters` until you assign
"use the X text format" permissions.

## `simple_editor` — "Simple Editor" (CKEditor 5)

- `config/install/editor.editor.simple_editor.yml` — `editor: ckeditor5`. Toolbar: bold, italic,
  underline, strikethrough, link, bulleted/numbered list, alignment, blockQuote, code, heading,
  sourceEditing. Plugins: alignment (center/justify/left/right), headings h2–h6, list props,
  `sourceEditing` allowed tags (`<cite> <dl> <dt> <dd> <blockquote cite> <h2..h6 id> <a hreflang>
  <ul type> <ol type>`), `editor_advanced_link` (no extra attrs), `linkit_extension` disabled.
- `config/install/filter.format.simple_editor.yml` — filters: `filter_html` **on** (weight -10) with
  a restricted allowlist (headings, lists, links `<a hreflang href>`, `<code> <s> <u>` etc., alignment
  classes, `filter_html_help` on, nofollow off); `ace_filter` off; `blazy_filter` off.
- Net: a safe, restricted rich-text format.

## `advanced_editor` — "Advanced Editor" (ACE source editor)

- `config/install/editor.editor.advanced_editor.yml` — `editor: ace_editor` (theme terminal, syntax
  html, wrap/auto-complete on). This is a raw source-code editor, not CKEditor 5.
- `config/install/filter.format.advanced_editor.yml` — filters: only `ace_filter` (off) and
  `blazy_filter` (off). There is **no `filter_html`** on this format, so it passes markup through
  much like core's "Full HTML". Because it is admin-only by default (no role granted), it functions
  as a trusted-editor raw-HTML format; only assign its use permission to trusted roles.

## `basic_editor` — "Basic Editor" (CKEditor 5, full-featured, optional)

Created from `config/optional` only when its config/module deps exist (`ckeditor_media_resize`,
`editor`, `entity_embed`, `linkit`, `media`, `blazy`, `ace_editor`, plus the four
`cke_media_resize_*` media view modes).

- `config/optional/editor.editor.basic_editor.yml` — `editor: ckeditor5`, `image_upload.status:
  false`. Rich toolbar (heading, style, formatting, alignment + direction, lists/indent, link,
  drupalMedia, insertTable, blockQuote, codeBlock, removeFormat, undo/redo, sourceEditing). Plugins
  include `ckeditor5_codeBlock` (many languages), `ckeditor5_style` (Bootstrap button/alert/table
  classes), `ckeditor_media_resize_mediaResize` (small/medium/large/xl image styles), Linkit
  (`default` profile), `editor_advanced_link` (aria-label, class, id, rel, target, title),
  `media_media` with view-mode override.
- `config/optional/filter.format.basic_editor.yml` — full filter chain: `filter_html` (on) with a
  broad allowlist covering entity_embed's `<drupal-entity …>` and `<drupal-media …>` plus
  `target/rel/data-*` link attributes and table markup; `filter_align`, `filter_caption`,
  `filter_autop`, `filter_htmlcorrector`, `filter_url`, `filter_image_lazy_load`,
  `editor_file_reference`, `entity_embed`, `linkit`, `media_embed` (five media view modes incl.
  the resize modes), `filter_resize_media`, `blazy_filter`. `filter_html_escape` and
  `filter_html_image_secure` are off; nofollow on.
- Note: `<iframe>` is not in the `filter_html` allowlist, so Blazy's iframe handling is still bounded
  by `filter_html`.

## Operating notes

- To expose a format to editors, grant its "use the X text format" permission to the intended role
  under `admin/people/permissions` — the module ships none.
- Removing the module does not delete these formats (they are independent config entities); export or
  delete them manually if uninstalling.
- The `advanced_editor` (no `filter_html`) is the one to review before granting to non-admins, same
  caution as core Full HTML.
