# Node.js Translate — manual setup guide

**Node.js Translate** (`nodejs_translate`) provides **free automatic translation** for
your content by talking to a small **Node.js translation service** you run yourself.
That service uses the `@iamtraction/google-translate` library, which drives Google
Translate's public web page rather than a paid API — so there are **no Google API keys
to buy or store**, and translation is free.

Out of the box it can translate **nodes, blocks, and taxonomy terms** using **Drush
commands** — a single entity at a time, or every entity of a given bundle in one
command. It also exposes a translator service and alter hooks for developers who want to
translate custom fields or map Drupal language codes to ISO‑639 codes. It depends on
core's **Language** module.

A few honest caveats, straight from the module's own docs. Because it relies on an
**unofficial free endpoint** (Google Translate's public page), it is **against Google's
terms of service**; the maintainers frame it as suitable for learning Drupal/Node.js or
personal projects rather than production. Translation quality and reliability vary, and
because content is sent out to the translation service (and on to Google), you should
**not send sensitive content** through it. See [Configuration](configuration/index.md)
for the egress considerations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, set up and run the
   Node.js service, and enable the module.
2. [Configuration](configuration/index.md) — point the module at your Node.js
   service(s), tune request delays, and understand what data leaves your site.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Node.js Translate**
(`/admin/config/regional/nodejs_translate`).

## How to use it

Once the Node.js service is running and the module is pointed at it, translate content
from the command line:

- **Single entity:** `drush nodejs_translate:single_translate node 42`
  (alias `drush nodejs-st node 42`) — translates one entity by type and ID.
- **All entities of a bundle:** `drush nodejs_translate:multiple_translate node article`
  (alias `drush nodejs-mt node article`) — translates every node of the *article* type.

Developers can also call the `nodejs_translate.nodejs_translator` service directly
(`getTranslation()` for short strings, `translateText()` for text over 4000
characters) and use `hook_nodejs_translate_languages_alter()` /
`hook_nodejs_translate_entity_alter()` to map language codes and translate extra fields.
