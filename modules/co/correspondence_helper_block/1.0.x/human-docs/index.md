# Correspondence Helper Block — manual setup guide

**Correspondence Helper Block** (`correspondence_helper_block`) provides a simple
informational block that shows two pieces of admin‑configured text — a
communication message and a support‑contact message — alongside the **currently
logged‑in user's own email address** on file.

The problem it solves is a small but common source of confusion: when a site tells
a user "we'll email your confirmation," the user often wonders *which* address that
is. This block spells it out, pairing a short reminder message with the actual
account email the site holds for that user. It's handy on account pages,
confirmation screens, or anywhere you want to reinforce where email will be sent.

A couple of things worth knowing. The email shown is always the *current* user's
own address — the block never exposes anyone else's data. And because anonymous
visitors have no account email, the block is meant for authenticated contexts. All
the wording is admin‑driven; the block itself takes no user input.

The module works on Drupal 8, 9, and 10, and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the two text messages and place
   the block.

## Where it lives in the admin menu

The module's text settings live at **`/admin/config/correspondence_helper_block`**.
You place the block itself from **Structure → Block layout**
(`/admin/structure/block`).
