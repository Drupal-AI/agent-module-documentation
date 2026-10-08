# GearTranslations Translator — manual setup guide

**GearTranslations Translator** (`tmgmt_geartranslations`) is a provider plug‑in
for the [Translation Management Tool](https://www.drupal.org/project/tmgmt)
(TMGMT). It connects Drupal to the **GearTranslations** translation platform, so
that content you queue up as a TMGMT job can be sent out to GearTranslations for
translation and the finished text imported back into your site — all through
TMGMT's normal review‑and‑approve workflow. It supports more than 40 languages
and lets you pick a translation level (Web, Expert, Premium, and so on).

This is an integration module, not a standalone feature: it adds GearTranslations
as one of the translation providers you can choose inside TMGMT. It therefore
depends on the TMGMT module and its content source, `tmgmt_content`. Using it
also requires a registered account on the GearTranslations platform — you contact
GearTranslations (drupal@geartranslations.com) to get set up and receive an API
access token. The module works only once you have added a GearTranslations
translation provider and entered that token; there is nothing useful it does on
enable alone.

Please read this before you put the module into production. As shipped, the
module has two real security weaknesses you should be aware of. First, its
inbound callback (`/tmgmt_geartranslations_callback`) accepts posted translation
text into any active job **without verifying that the request genuinely came from
GearTranslations** — an anonymous caller who knows an active job ID could inject
arbitrary "translated" content, which is a content‑injection (and potential
stored‑XSS) risk. Second, the module's API connector disables TLS certificate
verification, which means your GearTranslations access token could be exposed to
a man‑in‑the‑middle. Treat the access token as a secret (store it in an
environment variable, not in committed config), and weigh these caveats before
exposing the callback on a public site. The module is currently marked *Seeking
new maintainer* and is not covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the TMGMT dependencies are in place.
2. [Configuration](configuration/index.md) — add the GearTranslations provider in
   TMGMT and enter your access token, with the security points to keep in mind.

## Where it lives in the admin menu

The module has no settings page of its own. Once enabled, GearTranslations shows
up as a choice when you add a translation provider under **TMGMT →
Providers** (**Configuration → Regional and language → Translation providers**,
`/admin/tmgmt/translators`). You configure it there, and you drive translation
jobs from **TMGMT → Jobs** (`/admin/tmgmt/jobs`) as with any other provider.
