# Auto Node Translate Bulk — manual setup guide

**Auto Node Translate Bulk** (`ant_bulk`) adds a **bulk** path to the
[Auto Node Translate](https://www.drupal.org/project/auto_node_translate) module.
Auto Node Translate hands a single node's fields to a machine‑translation provider
and writes back the translations — perfect for new content, but not much help for
the thousands of *existing* nodes you have when a site goes multilingual. This
module fills that gap: it runs the same translation over many nodes at once.

It provides a bulk translation form at `/ant-bulk/translate`, a settings form for
its own options, and Drush commands so you can run large translation jobs from the
command line instead of a browser. It reuses Auto Node Translate's provider
configuration — you do not set up the translation provider here.

Two things are worth understanding before you use it:

- **It costs money.** Bulk translation sends every selected node's content to your
  translation provider, and providers charge **per character**. The module's
  permission, **Use bulk auto translate**, is marked "restrict access", because in
  effect it means "may spend the translation budget". Treat it as a financial
  control, not just an editorial one.
- **Content leaves your site.** Anything you select — including unpublished nodes if
  they are in the selection — is transmitted to a third‑party provider. Confirm that
  is acceptable, especially for confidential or draft material, before your first
  run. And as with any machine translation, review the output before publishing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Auto Node
   Translate) and enable the module.
2. [Configuration](configuration/index.md) — the settings form, permissions, and
   running a bulk translation.

## Where it lives in the admin menu

- The **bulk translation form** is at `/ant-bulk/translate`, gated by the **Use
  bulk auto translate** permission.
- The **settings form** is at **Configuration → Regional and language → Auto Node
  Translate Bulk settings** (`/admin/config/regional/ant-bulk-settings`), gated by
  **Administer site configuration**.

## How to use it

1. Install and configure Auto Node Translate (its provider settings), then install
   this module.
2. Grant **Use bulk auto translate** only to trusted users.
3. Run a bulk translation from `/ant-bulk/translate`, or — for large runs — from
   the module's Drush commands.
4. Review the machine translations before publishing.
