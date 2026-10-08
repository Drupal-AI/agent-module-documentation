# CKEditor Advanced Container — manual setup guide

**CKEditor Advanced Container** (`ckeditor_advanced_container`) adds a flexbox-based
container and column layout system directly inside CKEditor 5. Editors can divide
a rich-text area into side-by-side sections — a photo on the left and text on the
right, a feature grid, a pull quote beside article text — and control exactly how
those sections stack on phones and tablets, all without leaving the editor or
asking a developer.

Out of the box, Drupal offers no clean way to build responsive columns inside a
body field short of tables (which are semantically wrong for layout, fragile on
mobile, and inaccessible), Layout Builder, or a framework-dependent module. This
module fills that gap: an editor inserts a container, chooses how many columns
(1–12), and sets widths, gaps, backgrounds, borders, alignment, and responsive
breakpoint behaviour from an inline toolbar. The output is semantic `div`-based
markup rendered with pure CSS flexbox, independent of any CSS framework or theme.

A few things worth knowing. All CSS values are sanitized and validated before
being written, blocking injection via `javascript:`, `expression()`, and similar
vectors. The front-end library loads lazily — only on pages whose content
actually contains a container — so unrelated pages carry no extra CSS or JS.
Containers can be nested up to three levels deep, and it works anywhere a
CKEditor 5 text field does (content types, Paragraphs, Layout Builder blocks). It
depends only on core's CKEditor 5, and has no access-control role: the layout is
markup in the content, so make sure the text format's allowed HTML permits the
container `div`s and their classes so they survive filtering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it creates no new admin
pages or content types. Everything is set up in the editor, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on the CKEditor 5 format you want.
3. In the CKEditor 5 toolbar configuration, drag the container tool into the
   *Active toolbar*.
4. Make sure the format's allowed HTML permits the container `div` markup and its
   classes so the layout survives filtering on save.
5. **Save configuration**.

Now, while editing content with that format, insert a container. An inline
contextual toolbar appears with buttons to add or remove columns and to open
properties panels for the container and each column. There you set:

- **Per container**: width, gap between columns, horizontal alignment, background
  colour, and full border control (style, colour, width, radius).
- **Per column**: width, padding, background colour, vertical alignment, and full
  border control.
- **Responsive widths** for mobile, tablet, and desktop breakpoints, with
  optional auto-stacking on smaller screens. Preview toolbar buttons (Desktop /
  Tablet / Mobile) simulate the breakpoints right in the editor so you can see how
  a layout will stack before publishing.
