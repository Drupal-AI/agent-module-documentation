# Edition Guard — manual setup guide

**Edition Guard** (`editionguard`) bridges Drupal with the
[EditionGuard](https://www.drupal.org/project/editionguard) DRM ebook service,
letting you add books and create per‑user download transactions. It models both as
Drupal content entities: an **`editionguard_book`** (title, EditionGuard resource
id, DRM type, and a source file kept in Drupal's *private* file scheme) and an
**`editionguard_transaction`** (owner, book, EditionGuard transaction id, download
link, uses‑remaining, and watermark details).

When you create a transaction, the module calls the EditionGuard REST API through
its required companion module, **EditionGuard API** (`editionguard_api`): it
requests a new transaction for the book's resource id — optionally applying an
EditionMark watermark carrying the buyer's name and email — and stores the returned
download link on the transaction entity. Regenerating a transaction deletes the old
one and requests a fresh download link. There's an optional **`rh_editionguard_book`**
submodule that adds [Rabbit Hole](https://www.drupal.org/project/rabbit_hole)
behavior to book entities.

Two things matter for setup. First, the **API credentials live in the separate
`editionguard_api` module**, not here — you configure them there, and that module
talks to `https://app.editionguard.com` over HTTPS. Second, this module models
personal data: creating a watermarked transaction **sends the buyer's name and
email to EditionGuard**, so disclose that transfer in your privacy policy. Every
operation is permission‑gated (granular book and transaction permissions), and book
source files are stored privately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (which pulls in EditionGuard API).
2. [Configuration](configuration/index.md) — set up the EditionGuard API
   credentials, then add books and create transactions.

## Where it lives in the admin menu

Books are managed at **Structure → EditionGuard books**
(`entity.editionguard_book.collection`,
`/admin/structure/editionguard_book`), where you can also create transactions. The
API credentials are set on the **EditionGuard API** module's own settings form.
See [Configuration](configuration/index.md).
