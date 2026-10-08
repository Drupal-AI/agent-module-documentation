# DeepL Translator — manual setup guide

**DeepL Translator** (`tmgmt_deepl`) plugs the **DeepL** machine‑translation API
into the **Translation Management Tool** (TMGMT), so Drupal content translation
jobs can be translated automatically by DeepL. It supports both the free and the
pro DeepL API, letting you machine‑translate nodes, taxonomy, menus, and other
TMGMT sources into DeepL's 30+ languages.

The module adds two TMGMT **translator** plugins — "DeepL API Free" and "DeepL API
Pro" — which share the same settings form and differ only in the DeepL endpoints
they use. You add a DeepL translation provider under TMGMT's providers list, pick
free or pro, enter your DeepL authentication key, and tune options that map onto
DeepL's own API parameters: formality (formal/informal), sentence splitting,
XML/HTML tag handling, tags to ignore, formatting preservation, outline detection,
and whether to auto‑accept returned translations so jobs complete without manual
review.

Once a provider exists, you translate TMGMT jobs with it just like any other
translator; long jobs can be processed in the background by a cron queue worker.
Actual translation calls DeepL's API and needs a valid key, but the provider and
all its settings are ordinary Drupal configuration. Developers get several alter
hooks and an event to post‑process translated text, and a `tmgmt_deepl_glossary`
submodule adds DeepL glossary management for enforcing term translations.

This guide is written for a **human** setting the provider up through the admin
UI. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and TMGMT) with
   Composer and enable it.
2. [Configuration](configuration/index.md) — add a DeepL provider, enter your auth
   key, and set the translation options.

## Where it lives in the admin menu

You manage DeepL as one of TMGMT's translation providers at **Translation →
Providers** (`/admin/tmgmt/translators`). There is no separate settings page — the
DeepL options live on the provider you create there.

## How to use it

Get a DeepL API key (free or pro), add a DeepL provider under the TMGMT providers
list, enter the key, and adjust the DeepL options to taste. Then create and
translate TMGMT jobs choosing your DeepL provider. Enable the glossary submodule
if you need to enforce specific term translations. See
[Configuration](configuration/index.md) for the walkthrough.
