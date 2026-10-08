# Auto Translation — manual setup guide

**Auto Translation** (`auto_translation`) adds one‑click machine translation to
your multilingual Drupal site. On the add form for a node, media item, custom
block, or taxonomy term, it injects a **Translate** control that walks the
entity's translatable fields — including nested **Paragraphs** and referenced
entities — sends each text value to a translation provider, and writes the results
back as new translations in the site's other languages. Inline HTML is preserved
(only the visible text is translated), and repeated strings are cached for 24
hours to keep output consistent and reduce provider costs.

You pick the translation **provider** on the settings form. The choices are the
free client‑side **Google Translate** endpoint (no key needed), the paid **Google
Cloud Translate** server API, **DeepL** (Free or Pro), **LibreTranslate**,
**Amazon Translate**, and **Drupal AI** (LLM‑based translation via the AI Translate
module). All provider endpoints are fixed in code — you never supply a URL — and
API keys and secrets are escaped and stored **encrypted**, not in plain text.

For translating in bulk, the module ships two **Action** plugins — *Auto Translate
and Publish* and *Auto Translate (save as draft)* — that you can expose as bulk
operations on a content listing, so editors can translate many entities at once
and either publish them or hold them as drafts for review. Two security‑restricted
permissions control who may change the settings and who may run translations.

Auto Translation builds on Drupal core's **Content Translation** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Content Translation.
2. [Configuration](configuration/index.md) — choosing a provider, entering API
   credentials, selecting content types, and the bulk actions.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Auto Translation**
(`/admin/config/system/auto-translation`), reachable by users with the
**Administer auto_translation module** permission.

## How to use it

1. Enable the module and make sure your site has more than one language and
   Content Translation configured (see [Installation](installation/index.md)).
2. On the settings form, pick a provider, enter any required API credentials, and
   choose which content types get the Translate control (see
   [Configuration](configuration/index.md)).
3. Grant the **Auto translation translate content** permission to the roles that
   should be allowed to translate.
4. Create or edit content and click **Translate**, or use the bulk actions from a
   content listing.
