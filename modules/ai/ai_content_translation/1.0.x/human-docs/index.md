# AI Content Translation — manual setup guide

**AI Content Translation** (`ai_content_translation`) adds machine translation of
content entities to Drupal using **OpenAI**. It plugs into Drupal's core
content-translation workflow, so an editor can auto-generate a translation of a
node (and its fields) into another language and then review and refine it — keeping
a human in the loop while cutting out the slow first pass of translating from
scratch.

The goal is faster multilingual content production without giving up editorial
control: the AI produces a **draft** translation, and your editors review it before
it goes live, exactly as they would a human-drafted translation.

Translation requests send content to OpenAI using the configured API key, which
means both the source text and its translation leave your site to a third-party
API — consider data sensitivity and the per-request cost before enabling it. Access
is gated by the `administer ai content translation` permission. The module depends
on core's Content Translation and Configuration modules and works on Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up your OpenAI key and core translation.

## How to use it

Because the module integrates with core content translation, you work from the
usual **Translate** tab on a translatable content type: choose a target language
and let the module generate a draft translation via OpenAI, then review and edit
before saving. Set up the OpenAI API key in the module's settings first (see the
installation note on keeping the key out of plain config), and grant
`administer ai content translation` only to the editors who should trigger
translations, since each one is a billed external call that sends content to
OpenAI.
