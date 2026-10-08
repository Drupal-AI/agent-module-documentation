# Apsis mail — manual setup guide

**Apsis mail** (`apsis_mail`) connects your Drupal site to the **APSIS**
email‑marketing platform through its REST API. Once configured, it gives site
visitors a way to subscribe to your APSIS mailing lists: it ships a **subscribe
block** and subscribe **form**, and it hands new subscribers off to a queue so
the actual API calls happen in the background rather than making the visitor wait.

You would use this module if APSIS is the tool your organisation uses to send
newsletters and campaigns, and you want people browsing your site to opt in to
those lists directly. Place the subscribe block in a region (a sidebar or
footer, for example), and each submission is queued and synced to APSIS. You can
also map site user roles to specific mailing lists so that different kinds of
users land on the right list.

The connection to APSIS is authenticated with an **API key**. This module keeps
that key in Drupal's `state` store rather than in exported configuration, so it
is not written into your config files and does not get committed when you export
config. The key is sent to APSIS as an HTTP `Basic` authorization header (never
in the URL). One thing to get right: the module has an `api_ssl` setting that
decides whether it talks to APSIS over `https://` or plain `http://` — keep it
**on** in production so the key is never sent over an unencrypted connection. See
[Configuration](configuration/index.md) for the details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your APSIS API key and
   endpoint, place the subscribe block, and map roles to lists.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Apsis mail**
(`/admin/config/services/apsis_mail`), reachable by users with the **Administer
apsis mail** permission. The subscribe block is placed the usual way, through
**Structure → Block layout**, and shows to visitors who have the **View apsis
mail block** permission.
