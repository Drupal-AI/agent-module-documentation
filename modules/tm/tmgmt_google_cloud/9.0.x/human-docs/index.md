# TMGMT Google Cloud — manual setup guide

**TMGMT Google Cloud** (`tmgmt_google_cloud`) is a machine‑translation provider for
the [Translation Management Tool](https://www.drupal.org/project/tmgmt) (TMGMT).
It adds a translator plugin that uses the **Google Cloud Translation** service, so
content you queue for translation in TMGMT can be machine‑translated by Google
Cloud and imported back into your site.

It is similar to the older TMGMT Translator Google module, but it can handle much
larger chunks of text — currently up to about 200 KB per request — which makes it
a better choice when your content items are long. It is an integration feature in
the Translation Management package; TMGMT itself governs the review‑and‑approve
workflow, and this module simply provides Google Cloud as one of the translation
providers you can pick.

To use it you need a Google account and Google Cloud credentials (an API key) with
the Translation service available. The module sends the **content you translate to
Google Cloud** — an external data‑egress consideration, so confirm that is
acceptable for the material in question — and it authenticates with your Google
Cloud credentials, which you should store as a **secret** (an environment variable
or a Key entity, never committed config) and send over HTTPS. The module has no
access‑control role of its own. It is maintained by Ukrainian developers, is
minimally maintained (maintenance fixes only), and is not covered by Drupal's
security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Google Cloud provider and
   enter your credentials.

## Where it lives in the admin menu

The module has no settings page of its own. Once enabled, Google Cloud appears as
a choice when you add a translation provider under **Configuration → Regional and
language → Translation providers** (`/admin/tmgmt/translators`). You drive the
actual work from **TMGMT → Jobs** (`/admin/tmgmt/jobs`).
