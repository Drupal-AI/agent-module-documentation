# Quick Edit — manual setup guide

**Quick Edit** (`quickedit`) brings back front-end, in-place content editing — the
contrib continuation of the Quick Edit module that used to live in Drupal core.
With it enabled, a permitted user browsing the rendered page can hover over content,
click a contextual "pencil" link, edit a field right where it appears, and save via
AJAX without ever opening the full node edit form or reloading the page. It's the
fast way to fix a typo or tweak a line of copy on the live site.

Each editable field is matched to an **in-place editor**: a plain-text editor for
simple string and number fields, a full **WYSIWYG** editor for formatted text (via
core's Editor/CKEditor integration), an image editor for image fields, and a generic
form-based editor as a fallback for anything else. Quick Edit works out of the box
once enabled — there's no settings page to fill in. It also stays compatible with
**Layout Builder**, so fields placed into layouts remain editable in place.

The module builds on core's **Contextual Links**, **Editor**, **Field**, and
**Filter** modules, all of which Drupal enables automatically. Access is governed by
a single permission, **access in-place editing** — but note that even with it, a
user can only edit fields they already have normal edit access to; Quick Edit
respects field- and entity-level access, it doesn't bypass it. Quick Edit was moved
out of Drupal core in 10.3, so sites that still want this inline-editing experience
install this module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Quick Edit has no configuration form. Getting it working is a matter of the right
permission and knowing where the controls appear:

1. **Grant the permission.** Go to **People → Permissions** and give the roles you
   trust the **Access in-place editing** (`access in-place editing`) permission.
   Those users must also have normal edit access to the content and fields they'll
   be editing.
2. **Use the pencil links on the page.** Logged in as such a user, browse to a piece
   of content. Contextual "pencil" links appear on editable areas (the same
   contextual-links system core uses). Click one to enter Quick Edit mode, click a
   field to edit it in place — a WYSIWYG editor opens for formatted-text fields,
   plain input for simple fields — and your change saves via AJAX with no page
   reload.

Developers can add a custom in-place editor by implementing the `InPlaceEditor`
plugin type, or alter which editor a field uses via hooks — see the sibling
[`agent/`](../agent/start.md) docs for those extension points.
