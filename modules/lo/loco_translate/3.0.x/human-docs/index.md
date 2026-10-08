# Loco Translate — manual setup guide

**Loco Translate** (`loco_translate`) connects your Drupal site's **interface
translations** to **[Loco](https://localise.biz)** (localise.biz), a hosted
translation-management platform. It gives you a normalized way to collect the
site's internationalization strings and push them up to Loco, and to pull
translations back down into Drupal — so translators work in Loco's polished
interface and their work syncs into your site, rather than everyone editing strings
through Drupal's own translation UI.

It's aimed at teams who want Loco to be their master translation platform: push a
`.po` file from Drupal up to Loco, let translation happen there, then have your
Drupal environment updated (manually or as part of your workflow) from Loco. It
offers a dashboard to see translation progress on Loco, a utility to push string
keys from Drupal to Loco, and **Drush commands** to push and pull. Because it works
through Drupal's core Translation (Locale) API, it plays nicely with any module
built on that API.

The one thing to get right up front is credentials. Loco Translate authenticates
to the Loco API with **API keys** — a read-only key for exports and a full-access
key for pushes. These are secrets: store them via a Key entity or an environment
variable, keep them out of exported configuration, and make sure the connection is
over HTTPS. It depends on core's **Locale** module and requires **Drush 10+** for
the command-line workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Loco PHP SDK) and enable the module.
2. [Configuration](configuration/index.md) — store your Loco API keys securely and
   use the push/pull workflow.

## Where it lives in the admin menu

Loco Translate provides a **dashboard** that shows your translation progress on
Loco, and its work is driven largely from **Drush** (`drush loco:push`,
`drush loco:pull`). API keys are configured in your site's `settings.php` (see
[Configuration](configuration/index.md)).
