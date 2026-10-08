# Admin RSS — manual setup guide

**Admin RSS** (`adminrss`) provides a moderation / approval workflow for queued
feed items. It lets administrators review items coming through feed queues and
approve or reject them before they are published or processed — in other words, it
adds an editorial gate in front of feed ingestion, so nothing from a feed goes
live until someone has signed off on it.

It is an administrative / moderation tool with no front-end role of its own: it
does not render anything for site visitors, it governs what happens to feed items
behind the scenes. The module requires Drupal 9.5 or newer.

> **Note on the available documentation.** This is a niche module (its release is a
> development snapshot, `1.x-dev`) and its published documentation is thin, so this
> guide describes what the module states about itself rather than a detailed
> click-by-click walkthrough. Review the settings on your own site to confirm the
> exact options.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — where the moderation settings live.

## Where it lives in the admin menu

The module's settings are under **Configuration → Web services → Admin RSS**
(`/admin/config/services/adminrss`), gated by the **Administer site configuration**
permission.

## How to use it

Enable the module, open its settings under Configuration → Web services, and use
the moderation workflow to review queued feed items — approving the ones that
should go live and rejecting the rest. See [Configuration](configuration/index.md)
for where the settings live.
