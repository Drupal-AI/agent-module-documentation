# Library Management System — manual setup guide

**Library Management System** (`library_management_system`) is a complete
in‑Drupal catalogue and **circulation** tool for a library. It manages books,
publications, and authors, and it handles the lending workflow — patrons request
a book, staff issue it, and the return is recorded when it comes back. It suits
schools, universities, libraries, and bookshops that want to run their collection
inside Drupal rather than a separate system.

It is built around a set of **custom content entities** — books
(`LmsBook`), publications (`LmsPublication`), authors (`LmsBookAuthor`), requested
books (`RequestedLmsBook`), and issued books (`IssuedLmsBook`) — each with its own
admin list, add, edit, and delete screens. On top of that it adds practical
day‑to‑day tools: CSV/JSON/Excel **import** forms for bulk‑loading authors,
publications, books, and users; **fine‑amount** settings for overdue items;
**reports** covering authors, publications, books, requested books, and issued
books; and search across the catalogue. Admin list screens use Views Bulk
Operations so staff can act on many rows at once.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Views Bulk Operations.
2. [Configuration](configuration/index.md) — the permissions that gate the admin
   area, the fine‑amount settings, and the import tools.

## Where it lives in the admin menu

The module adds admin management screens for each entity type (books,
publications, authors, requested books, issued books), plus import forms, fine
settings, and report pages — all gated by its own permissions. Patrons request a
book from that book's own page.

## How to use it

1. Give staff the appropriate **`administer …`** permissions (see
   [Configuration](configuration/index.md)).
2. Build the catalogue: add authors, publications, and books — by hand through the
   add forms, or in bulk through the CSV/JSON/Excel import forms.
3. A patron opens a book's page and **requests** it, which creates a request tied
   to their account (the module prevents duplicate requests for the same book by
   the same user).
4. Staff review the requested‑books list and **issue** a book to the patron.
5. When the book is returned, staff update its details; overdue items can carry a
   fine based on the amount you configured.
6. Use the report pages to see the state of the collection and its circulation.
