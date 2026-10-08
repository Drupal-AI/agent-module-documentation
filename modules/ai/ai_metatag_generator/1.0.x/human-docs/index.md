# AI Metatag Generator — manual setup guide

**AI Metatag Generator** (`ai_metatag_generator`) writes SEO meta tags for your
content automatically. Instead of an editor typing a meta title and description
by hand for every node, the module reads what is already in the node's body and
asks your configured AI provider to draft the metadata for you — then hands the
suggested values to the standard **Metatag** module to store and output.

It is a small add-on to Drupal's AI ecosystem. It does not talk to any LLM
vendor directly; it uses whichever provider you have already set up in the core
**AI** module (OpenAI, Anthropic, a local model, and so on), so every generation
runs through that provider and counts against its usage/cost. It also relies on
the **Metatag** module to actually hold and render the tags on the page.

Access is controlled by two permissions: **Administer AI Metatag Generator**
(`administer ai metatag generator`) for configuring the feature, and **Use AI
Metatag Generator** (`use ai metatag generator`) for editors who trigger a
generation. Because prompts and your content are sent to the AI provider, keep
the provider's API key stored as a secret (see the AI module's own setup).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI and Metatag dependencies.

## Where it lives in the admin menu

The module does not add a top-level configuration screen of its own. It works
alongside the Metatag module, so you meet it where you already edit a node's meta
tags — on the content's edit form, in the Metatag section, gated by the **Use AI
Metatag Generator** permission.

## How to use it

Edit a node that has some body content, open its meta tags, and use the
generator to draft the title and description from that content. Review the
AI-suggested values, adjust anything you want, and save — the tags are stored and
output by Metatag exactly like any hand-written meta tags. Every run costs an AI
provider call, so it is meant as an editor aid, not a bulk background job.
