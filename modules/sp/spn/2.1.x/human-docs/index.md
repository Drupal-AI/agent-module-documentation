# Simple Petitions (SPN) — manual setup guide

**Simple Petitions** (`spn`) lets you run petition campaigns on your Drupal site.
It helps an organisation or a user create a petition, collect and validate
signatures from the public, manage the emails and notifications around signing,
and view the results — a self‑contained petitions toolkit built on Drupal content.

When you enable it, the module sets your site up for petitions automatically: it
creates a **Petition** content type with the fields it needs (title, body, and the
validation and confirmation email subjects/bodies), and it adds two blocks — a
**Petition signing form** and a **Petition results** block. It also adds two
database tables of its own, *Petition Signatures* and *Petition Users*, to store
each signature and the details of anonymous signers. Creating a petition is then
just like adding any other content: go to add content, choose *Petition*, fill in
the fields and save.

Signing works for both logged‑in and anonymous visitors. A signer fills in the
required details (and an optional comment), and can choose to sign anonymously —
in which case their details and comment are hidden from the results block but
their vote still counts. After signing they receive a validation email; the vote
counts only once they click the link, and a confirmation email follows. Since
version 2.0 administrators can export a petition's signatures to CSV.

It depends on core **Link**, **Views** and **Node** (plus the usual Field, Path,
User and Block), in the *bluedrop* package, and runs on Drupal 9, 10 and 11. The
older CAPTCHA/reCAPTCHA dependencies were removed in 2.0.

A word on privacy: petition **signatures are personal data** — names and often
email addresses. Store and expose them in line with your privacy policy, and add
your own spam/bot protection (such as CAPTCHA or Honeypot) to the signing form so
you are not flooded with fake signatures. CSV export also requires a properly
configured **private file system**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module (which
   creates the Petition content type and blocks).
2. [Configuration](configuration/index.md) — set the default notification emails
   and place the petition blocks.

## Where it lives in the admin menu

- **Default emails and notifications:** `/admin/config/spn/notifications` — the
  default validation and confirmation messages used by any petition that does not
  set its own (Tokens are available for petition variables).
- **Export signatures to CSV:** `/admin/spn/content/petitions`.
- **Create a petition:** add content at `/node/add` and choose *Petition*.
- **Place the blocks:** **Structure → Block layout** (`/admin/structure/block`).
