# Node by Email — manual setup guide (4.0.x)

**Node by Email** (`node_by_email`) creates Drupal nodes from **incoming email**.
It connects to a mailbox over IMAP, finds unread ("unseen") messages, and turns each
matching message into a node — the email **subject becomes the node title** and the
email **body becomes the node body**, authored as a user you choose. It exists so
people can publish from a phone or any ordinary mail client (Gmail, Outlook, Apple
Mail) when reaching the full Drupal admin isn't practical — on the road, at a live
event, or on a slow connection.

This page documents the **4.0.x** branch. It ingests mail three ways:
**automatically on Drupal cron** (throttled by a configurable interval in seconds),
**on demand from the command line** via the Drush command
`node_by_email:generate_node` (alias `nbe-gn`), and **manually** through an admin
*"Unseen Emails"* form that lists unread messages and lets you create nodes from the
ones you select. Compared with the older 1.0.x branch, 4.0.x adds the Drush command
(and therefore requires **Drush 11**) and depends explicitly on the **PHP IMAP
extension**. It provides its own permissions and a configuration screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm the PHP
   IMAP extension and Drush 11, and enable the module.
2. [Configuration](configuration/index.md) — the IMAP connection and
   content/publishing options, field by field, and the permissions that gate the
   two admin pages.

## Where it lives in the admin menu

After enabling, the configuration screen is at
**Configuration → System → Node by Email** — route
`node_by_email.node_by_email_config_form`, direct path
`/admin/config/node_by_email/nodebyemailconfig`. When the connection succeeds the
page shows *"IMAP connection is made successfully."* at the top. The companion
*"Unseen Emails"* page (`/admin/config/node_by_email/unseenEmailList`) lists unread
mail and creates nodes from selected messages. Both pages are permission‑gated (see
Configuration).

## How ingestion runs

Once configured, you can leave ingestion to **cron**, kick it off from the CLI with
`drush node_by_email:generate_node` (alias `drush nbe-gn`), or use the **Unseen
Emails** form to review and create nodes by hand. All three select mail with an
IMAP search for unseen messages from your configured sender, and mark each processed
message as seen and flagged so it is not picked up twice. Whichever path runs, the
new node's author is always the configured author user — not the person who ran the
command or opened the form.
