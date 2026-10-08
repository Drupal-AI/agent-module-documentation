# AI Migrate — manual setup guide

**AI Migrate** (`ai_migrate`) adds AI-powered **process plugins** to Drupal's
Migrate system. When you build a migration, each field value passes through a
pipeline of process steps (trim, default value, look up a reference, and so on);
this module lets one of those steps be "send this value to an AI provider and use
what comes back." That means you can transform or enrich source data mid-migration
— for example rewriting messy legacy text, summarising a long field, classifying
content, or generating a value that the source did not contain.

It is a developer-facing add-on to the Drupal AI ecosystem: there is no
click-through UI. You use it by referencing its process plugin(s) inside a
migration's YAML (or a Migrate Plus migration configuration entity). It builds on
the core **AI** module and on **Migrate Plus**, and it runs every transformation
through whichever AI provider you have configured in the AI module — so each step
has a per-call cost.

Because the plugin sends your **source data to the AI provider**, treat that as
external egress and confirm it is acceptable for the content you are migrating.
The provider's API key is stored as a secret through the AI module's Key
configuration, requests go over HTTPS, and the module itself has no
access-control role of its own.

This guide is written for a **human** setting up a migration. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI and Migrate Plus dependencies.

## Where it lives in the admin menu

Nothing. AI Migrate adds no admin pages and no settings form of its own. Its
value is a process plugin you reference from migration definitions, and the AI
provider it uses is configured over in the **AI** module's own settings.

## How to use it

In a migration's `process` section, use the module's AI process plugin on the
field(s) you want to transform, pointing it at the AI operation you need. Run the
migration with Drush or the Migrate UI as usual; each affected row makes an AI
provider call and stores the returned value. Test on a small subset first so you
can review the AI output and estimate cost before running the full import.
