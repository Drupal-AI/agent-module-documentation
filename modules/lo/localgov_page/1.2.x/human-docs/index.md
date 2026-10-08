# LocalGov Page — manual setup guide

**LocalGov Page** (`localgov_page`) ships the general‑purpose **Page** content type
for the **LocalGov Drupal** distribution. It is the content type editors reach for
when they need a rich, structured page that does not fit one of the more
specialised LocalGov types — a landing page, an information page, a microsite home.

Rather than a single body field, a LocalGov page is built from **Paragraphs** and
**Layout Paragraphs**: editors assemble the page from reusable component blocks
(text, image, links, contact details and the rest of the LocalGov paragraph
library) and arrange them into columns and sections. The content type also gives
you a summary field, a banner field, and a toggle to hide the summary from the full
page view when you don't want it shown.

The module is almost entirely configuration — it installs the content type, its
fields, the field‑group layout on the edit form, and the view displays (full,
teaser, search). There is no settings screen and no special permissions: who can
create and edit LocalGov pages is governed by Drupal's standard node permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Paragraphs and LocalGov dependencies.

This module has **no configuration page**. You work with it by creating content and,
if you wish, extending the content type through the standard **Field UI** and
**Layout Paragraphs** tools.

## Where it lives in the admin menu

LocalGov Page adds no settings screen. It contributes a content type you use from
the usual places:

- Create pages at **Content → Add content → Page** (`/node/add/localgov_page`).
- Adjust the content type's fields and displays at **Structure → Content types →
  Page** (`/admin/structure/types/manage/localgov_page`).
- Access to pages uses Drupal's standard node permissions under **People →
  Permissions**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); it pulls in the
   Paragraphs and LocalGov paragraph stack it needs.
2. Create a page at **Content → Add content → Page**.
3. Build the body with **Layout Paragraphs** — add component blocks from the
   LocalGov paragraph library and arrange them into sections and columns.
4. Optionally add a **banner**, write a **summary**, and tick **Hide summary** if
   you don't want the summary shown on the full page.
5. Add the page to a menu if it needs to appear in navigation.

Because it is part of the LocalGov Drupal distribution, LocalGov Page expects the
LocalGov paragraph and media modules to be present — it is designed to run as part
of a LocalGov site.
