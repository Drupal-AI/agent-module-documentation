# Node by Email — manual setup guide (1.0.x)

**Node by Email** (`node_by_email`) creates Drupal nodes from **incoming email**.
It connects to a mailbox over IMAP, looks for unread ("unseen") messages, and turns
each matching message into a node — the email **subject becomes the node title**
and the email **body becomes the node body**, authored as a user you choose. The
idea is to let people publish from a phone or any ordinary email client (Gmail,
Outlook, Apple Mail) when loading the full Drupal admin isn't practical — on the
road, at a live event, or on a slow connection.

This page documents the **1.0.x** branch. It is a development branch: ingestion
happens on Drupal **cron** (throttled by a configurable interval) and through an
admin **"unseen emails" list** where you can pick messages and create nodes from
them in a batch. (The later **4.0.x** branch adds a dedicated Drush command and
requires the Drush 11 dependency and the PHP IMAP extension explicitly; if you want
CLI-driven ingestion, prefer 4.0.x.) It provides its own permissions and a
configuration screen; the mailbox connection, target content type, author, publish
state, and cron interval are all set there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the PHP IMAP extension is present.
2. [Configuration](configuration/index.md) — the IMAP connection screen and the
   content/publishing options, field by field.

## Where it lives in the admin menu

After enabling, the configuration screen is at
**Configuration → System → Node by Email** — the direct path is
`/admin/config/node_by_email/nodebyemailconfig`. When the connection succeeds the
page shows the message *"IMAP connection is made successfully."* at the top. The
list of unseen messages (from which you can create nodes manually) is a companion
admin page. Both pages are permission‑gated (see Configuration).
