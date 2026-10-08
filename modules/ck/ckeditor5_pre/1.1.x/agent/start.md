<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Pre (ckeditor5_pre) — agent index

Declarative CKEditor 5 plugin that adds a **`<pre>` (preformatted text)** entry to the editor's
**Headings / block-format dropdown**. Version dir **1.1.x** (installed 1.1.0). Core `^10 || ^11 || ^12`.

- **Dependencies:** core `ckeditor5` only. No PHP, no JavaScript, no routes, no permissions, no services.
- **What it provides:** one CKEditor 5 plugin definition, `ckeditor5_pre_customHeadings`, in
  `ckeditor5_pre.ckeditor5.yml`. It carries no CKEditor JS plugin of its own — it extends core's
  `ckeditor5_heading` plugin config with an extra option `{ model: pre, view: pre, class: ck-heading_pre }`
  and declares the `<pre>` element. Availability is gated by the `conditions.plugins: [ckeditor5_heading]`.
- **Library:** `ckeditor5_pre/admin.ckeditor5_pre` (`ckeditor5_pre.libraries.yml`) — a single admin CSS
  file (`css/ckeditor5_pre.admin.css`) that styles the "Pre" toolbar label in a monospace font.
- **Config:** none of its own (no `config/install`, no `config/schema`, no settings route). Behavior is
  controlled entirely by each **text format / editor** config (Headings must be in the toolbar; the
  format's Allowed HTML picks up `<pre>` on save).

## Solution docs
- [Plugin definition & how it works](plugins/pre-heading.md) — the `.ckeditor5.yml` plugin, the
  `heading` option it injects, the `<pre>` allowed element, enabling per format, and the CSS library.
