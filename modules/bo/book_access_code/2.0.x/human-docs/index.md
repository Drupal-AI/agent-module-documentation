# Book Access Code — manual setup guide

**Book Access Code** (`book_access_code`) protects core **Book** content behind
access codes. An administrator creates *Access Code* entities tied to a book, and
visitors must enter a matching code before they can view that book's pages. Once
a visitor enters a valid code, the grant is remembered in their session so they
are not prompted again.

This is handy for gated documentation or member content where sharing a single
code is simpler than managing an account for every reader. It builds directly on
core's Book and Node modules, and supports Drupal 9.2 and 10.

**How the gate works, honestly:** the module watches book *node page* views. If a
book has one or more active codes and the visitor's session holds no matching
code, they are redirected to a `/book_access` form to enter one. Codes are
compared with strict typing, so they are not trivially bypassed by type‑juggling.
Importantly, the gate only covers the **canonical node route** — the normal page
view. Content reachable through other channels such as **JSON:API, REST or
Views is not gated by this module**, so do not rely on it as your only protection
for content that must stay private. Users with the *bypass book access code
checks* permission skip the gate entirely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Book and Node).
2. [Configuration](configuration/index.md) — create and manage access codes, set
   the access‑page text, and understand the relevant permissions.

## Where it lives in the admin menu

- **Manage access codes:** **Structure → Book → Access code**
  (`/admin/structure/book/access_code`) — add, edit and delete the codes for your
  books (requires the *administer access codes* permission).
- **Settings:** `/admin/config/system/book_access_code/settings` — set the text
  shown on the code‑entry page.
- **Code‑entry form:** visitors are sent to `/book_access` when they need to
  enter a code.
