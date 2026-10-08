# Microformats — manual setup guide

**Microformats** (`microformats`) adds
[microformats](https://microformats.org/) markup (h-card, h-entry, and related
patterns) to your site's output, making content machine-readable by other tools and
services. Microformats are a lightweight, class-based way of marking up
human-readable content — a name, address, phone number, email — so that software can
reliably extract it. The module renders semantic markup that your theme can still
alter through Drupal's theme subsystem, and it uses the `mf2` PHP library (via
Composer) to implement the common microformat patterns.

Currently it provides two things:

- A **sitewide contact-information block** with full microformats markup —
  individual name, organization name, physical address (including geolocation),
  phone, fax, and email.
- A **field formatter for e-mail fields** that outputs microformat email markup.

It depends on core's **Block** module (the contact block is placed through the block
system). For richer IndieWeb-related features, the module's page points to the
related `linkback` and `indieweb` modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in the
   `mf2` library) and enable the module.

There is **no central settings page** — you place the contact block and set the
e-mail formatter, described in "How to use it".

## Where it lives in the admin menu

The module adds no dedicated settings page. The contact-information block is placed
from **Structure → Block layout** (`/admin/structure/block`), and the e-mail
formatter is chosen on a field's **Manage display**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. To add the contact block: go to **Structure → Block layout**, place the
   Microformats **contact information** block in a region, and fill in the details
   (name, organization, address/geolocation, phone, fax, email). The block renders
   with h-card microformats markup.
3. To mark up an e-mail field: on the relevant **Manage display**, set the e-mail
   field's formatter to the Microformats e-mail formatter so it outputs microformat
   email markup.
