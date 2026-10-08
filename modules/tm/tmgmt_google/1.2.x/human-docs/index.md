# Google Translator (TMGMT) — manual setup guide

**Google Translator** (`tmgmt_google`) plugs Google's cloud translation service into
the **Translation Management Tool (TMGMT)** as a machine translator. Once it's set up,
you can send TMGMT translation jobs — nodes, taxonomy terms and other translatable
content — to Google and get automatic translations back, ready for review or automatic
acceptance.

The module adds a single TMGMT **translator plugin** called "Google". You use it by
creating a TMGMT translation provider of type Google and pasting in a **Google Cloud
Translation API key**. From then on the provider behaves like any other TMGMT
translator: submit a job to it interactively, or wire it up as a continuous translator
so new content is translated automatically. Behind the scenes it batches your source
strings and calls Google's Translate API, then stores the results on the job items;
it also supports source-language detection and lists Google's supported languages so
you can map them to your Drupal languages.

There's very little to configure — essentially the API key, plus an optional
"automatically accept" toggle. When you save the provider, the module validates the key
by asking Google for its supported languages, so a bad key is caught immediately. The
module depends on **TMGMT**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer alongside
   TMGMT, and enable it.
2. [Configuration](configuration/index.md) — create a Google translation provider,
   enter the API key, and submit jobs.

## Where it lives in the admin menu

You set it up as a translation provider at **Configuration → Regional and language →
Translation providers** (`/admin/tmgmt/translators`). Translation jobs themselves are
managed through TMGMT's usual screens under **Translation**.
