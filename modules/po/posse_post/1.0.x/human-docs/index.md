# POSSE Post — manual setup guide

**POSSE Post** (`posse_post`) brings the **POSSE** philosophy — *Publish on your Own Site,
Syndicate Elsewhere* — to Drupal. Your Drupal site stays the canonical home for your content,
and when you publish a node the module automatically **cross‑posts** it to the social networks
you've configured: **Bluesky, Mastodon, Facebook, Instagram, and LinkedIn**.

It's designed to be safe and controllable. Credentials for each platform are read from
**environment variables** rather than stored in the database or exported configuration, so your
tokens never end up in version control. A dedicated `SEND_CROSSPOSTS` environment variable acts
as a master switch, so you can safely run the same codebase on dev or staging without
accidentally posting. Each crosspost's status is tracked (pending, published, or failed), and
you can retry or publish immediately from the admin UI. Per account you can map which fields to
use, set format strings, truncate to a platform's character limit, append the canonical URL, and
optionally generate CamelCase hashtags from taxonomy terms.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — global settings, adding a social account per
   platform, field mapping, and the credential environment variables.

## Where it lives in the admin menu

POSSE Post's settings live under **Configuration → Web services → POSSE Post**. The **Social
Accounts** page there is where you add an account for each platform you want to syndicate to.

## How to use it

Once you've added and authenticated your social accounts and set `SEND_CROSSPOSTS=1` in
production (see [Configuration](configuration/index.md)), simply **publish a node**. POSSE Post
queues a crosspost for each configured account. Crossposts are sent on the next **cron** run, or
you can publish them **immediately** from the admin UI. If one fails, its status is recorded and
you can retry it. Full platform setup and hosting guides live on the module's documentation site
at `project.pages.drupalcode.org/posse_post`.
