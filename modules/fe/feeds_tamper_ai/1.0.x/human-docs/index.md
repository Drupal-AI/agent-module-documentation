# Feeds Tamper AI — manual setup guide

**Feeds Tamper AI** (`feeds_tamper_ai`) adds an AI-powered
[Tamper](https://www.drupal.org/project/tamper) plugin to the
[Feeds](https://www.drupal.org/project/feeds) import pipeline. A Tamper plugin
transforms the value of one source field as it flows through an import; this one
sends that value to a large language model (LLM) and puts the model's response
back in its place. In practice you use it to summarize, translate, classify, or
otherwise rewrite a field during import.

Rather than talking to any one AI vendor directly, the module builds on the
[Drupal AI](https://www.drupal.org/project/ai) project as an abstraction layer, so
you can point it at whichever provider you have configured in Drupal AI without the
module needing its own credentials. Each tamper instance lets you choose the
configured **AI Provider**, set a **System role** (the persona/instructions sent
with every request), and write the **prompt** describing what the model should do
with the field's data.

Because this sends your imported data to an AI model, keep two things in mind: if
the provider is a cloud service, the field content leaves your server (data
egress) — confirm that is acceptable for the data you're importing — and each
import consumes API tokens, which usually costs money. Treat your provider API key
as a secret (see [Installation](installation/index.md) for how to store it safely).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Feeds,
   Feeds Tamper, and Drupal AI dependencies.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. Each AI tamper is configured as an instance on a Feed type, as
described below.

## Where it lives in the admin menu

Feeds Tamper AI adds no admin page of its own. You use it from a Feed type's
**Tamper** tab at **Structure → Feed types** (`/admin/structure/feeds`). The AI
provider it relies on is configured separately under **Configuration → AI**
(provided by the Drupal AI module).

## How to use it

1. Install the module and its dependencies (see [Installation](installation/index.md)).
2. Configure an **AI Provider** with your credentials in the Drupal AI module.
3. Create a Feed type and set up the mapping between your content type's fields and
   the source keys, as you would for any Feeds import.
4. Open the Feed type's **Tamper** tab. On the field you want the AI to transform,
   click **Add plugin** and choose **AI Prompt**.
5. Configure the tamper: pick the configured **AI Provider**, enter a **System
   role** (this defines the model's persona and is sent on every request), and
   write the **prompt** describing what you want done with the data — be clear and
   ask for a concrete answer.
6. Create a feed of that type and import. Each mapped value passes through the
   model before it is saved.
