# Bulk Taxonomy Term Translator — manual setup guide

**Bulk Taxonomy Term Translator** (`taxonomy_translator`) translates a whole
vocabulary's terms into another language in one pass, using batch processing and
the **Google Translate** service. Instead of opening each term and typing its
translation by hand, you pick a source language, a destination language and a
vocabulary, then run the module's action and let it create the translations for
you — a big time‑saver when you are standing up a multilingual taxonomy.

It is an editorial/multilingual helper. The translations it creates still follow
Drupal's normal content‑translation access, so it does not change who can see or
edit what. The module works on Drupal 8.8 through 11 and provides its own
permission for running the translation action.

Because it calls **Google Translate**, there is a real setup prerequisite: you
must have a Google Translate account and place a **Google credential JSON file on
your web server** for the module to authenticate with. That file is a secret —
keep it outside your document root and out of version control. Note too that the
term text you translate is **sent to Google** (a third‑party service), which is a
data‑egress consideration to weigh against your privacy policy if the terms
contain anything sensitive.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up the Google credentials.

## How to use it

Once the module is enabled and the Google credential file is in place, the flow is
simple: choose the **source language**, the **destination language**, and the
**vocabulary** you want to translate, then run the module's translation action. The
work runs as a batch, so large vocabularies process in chunks without timing out,
and each term gets a translation created in the destination language. The module's
built‑in help page has the specifics for your version. Running the action requires
the permission the module provides, so grant that to the appropriate roles first
under **People → Permissions**.
