# Google cloud batch translation — manual setup guide

**Google cloud batch translation** (`tmgmt_google_batch`) is a machine‑translation
provider for the [Translation Management Tool](https://www.drupal.org/project/tmgmt)
(TMGMT). It plugs Google's Cloud Translation service into TMGMT so you can
machine‑translate content with a few clicks, and it is built specifically around
Google's **batch** translation API — which is what makes it a good fit when you
have large amounts of content to translate at once rather than a page or two.

Under the hood the provider (the `GoogleBatchTranslator` plugin) sends your source
text to a Google translation endpoint, authenticating with an API key that you
store in the provider's settings. The endpoint URL is configurable, and the
module validates your API key when you save the provider so you find out
immediately if it is wrong. There are no inbound callback routes: translations
are fetched synchronously through TMGMT's normal provider flow, and requests use
Drupal's standard HTTP client with ordinary TLS verification.

To use it you need a Google Cloud Platform account with an app that has the Google
Cloud Translation API enabled. The module depends on TMGMT and does nothing on its
own until you add a Google provider and enter a valid API key. It is sponsored and
developed by Vardot, is actively maintained, and is covered by Drupal's security
advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Google provider, enter your
   API key, and (optionally) set a custom endpoint.

## Where it lives in the admin menu

The provider is configured on the TMGMT **Translation providers** page —
**Configuration → Regional and language → Translation providers**
(`/admin/tmgmt/translators`, the `entity.tmgmt_translator.collection` route). You
add a translator there, choose the Google plugin, and enter your key. Everyday
translation is driven from **TMGMT → Jobs** (`/admin/tmgmt/jobs`).

## How to use it

Because it works in batches, the natural use is bulk machine translation: select
one or many entities, create a TMGMT job, choose the Google provider, and submit.
Being machine translation, results come back automatically without a human
language service provider in the loop — ideal for a first‑pass or continuous‑
localization workflow that a human editor then reviews.
