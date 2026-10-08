# Interface Translation Auto — manual setup guide

**Interface Translation Auto** (`interface_translation_auto`) machine‑translates
your site's untranslated **interface strings** in one batch, using the **DeepL** or
**OpenAI** API. On a multilingual site there are often hundreds of small UI strings
— from core, contrib modules and themes — that have no translation yet. Rather than
translating each by hand, this module adds a **"Translate untranslated strings"**
link on the Languages page and runs a batch that sends every missing English string
to the translation API and stores the result for the chosen language.

Getting started is a two‑step affair: enter an API key (DeepL or OpenAI) on the
module's settings page, then trigger the batch from the Languages page and wait for
it to finish. The translations land in Drupal's normal interface‑translation
storage, so you can review and refine them afterwards like any other translated
string.

Because it authenticates to an external translation service, treat the API key as a
secret (store it in the environment rather than in code or exported config), keep
the connection on HTTPS, and remember that machine translations always benefit from
a human review pass for quality.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add your DeepL or OpenAI API key and
   run the translation batch.

## Where it lives in the admin menu

The settings page is at **Configuration → Regional and language → Interface
Translation Auto** (`/admin/config/regional/interface-translation-auto`). The
"Translate untranslated strings" link that runs the batch appears on the Languages
page (`/admin/config/regional/language`). See
[Configuration](configuration/index.md).
