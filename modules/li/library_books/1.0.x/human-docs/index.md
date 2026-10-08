# Library Books — manual setup guide

**Library Books** (`library_books`) ships a ready‑made content model for
cataloguing physical books in an institution — a school, college, or library. On
install it creates everything you need to get started: a **Library Books**
content type, a **department** taxonomy for organizing books by section, listing
**Views** for browsing them, and a simple **issue‑count** log that tracks how many
times each book has been lent out.

Think of it as a starter kit rather than a full circulation system. Editors create
a node per book, and when a book is marked as issued the module records a log row
(which book, which user, and when). The book's page then shows an "Issued N times"
count. Everything is built from standard Drupal content — content types,
taxonomy, and Views — so it is entirely config‑driven and easy to extend or
customize to fit how your library works.

> **Before you rely on it:** this project is marked **Obsolete** and works only on
> **Drupal 10**. It is best treated as a foundation to build on rather than a
> maintained product.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Node, Taxonomy, and Views.

There is **no settings form** for this module — the content model is created on
install and works out of the box. What you do afterward is ordinary Drupal
content management, described below.

## How to use it

1. On install, the module creates the **Library Books** content type, the
   department taxonomy, the fields, and the listing Views. An install step also
   creates the `library_book_issue_log` table that records issues.
2. Grant your editor roles the usual **node permissions** for the Library Books
   content type under **People → Permissions** — the module defines no custom
   permissions of its own, so core node and taxonomy permissions apply.
3. Editors create a book as a Library Books node, choosing its department and
   filling in its details, including the "is issued" flag.
4. The first time a book is marked issued, the module logs a row (book, issuing
   user, timestamp). The book's page then displays "Issued N times".
5. Use the provided Views for book listings and to browse by department.

If you later uninstall the module, it should remove the content model and the log
table.
