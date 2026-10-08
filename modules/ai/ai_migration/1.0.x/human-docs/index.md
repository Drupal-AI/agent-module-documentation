# AI Migration — manual setup guide

**AI Migration** (`ai_migration`) uses AI to make *building* a content migration
easier. Where the similarly named AI Migrate module adds AI steps you run
*during* a migration, this module aims one level up: it helps you author the
migration itself. It reads a source described through **JSON:API** and JSON
**schema** (via the schemata tooling) and leans on AI to help generate the
migration mappings and configuration — the tedious modelling work of matching
source fields to Drupal fields — so you spend less time hand-writing YAML.

It is an add-on to the Drupal AI ecosystem and pulls in a fair number of moving
parts: the core **AI** module plus Drupal core's **JSON:API**, **Migrate**,
**Migrate Plus**, **Serialization**, and the **Schemata** modules. AI operations
run through whichever provider you have configured in the AI module, so the
mapping-generation work has a per-call cost.

Because it works from schema and JSON:API descriptions of your data, it is a
tool for developers and site builders standing up new migrations rather than an
everyday editor feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm its AI, JSON:API, Migrate, and Schemata dependencies.

## Where it lives in the admin menu

The module does not register a dedicated top-level settings screen; the AI
provider it uses is configured in the **AI** module's own settings, and its work
centres on the Migrate/Migrate Plus and JSON:API/Schemata tooling.

## How to use it

Point it at a source exposed through JSON:API with an available JSON schema, and
let it help draft the migration mapping/configuration rather than writing every
field mapping by hand. Review and refine the generated migration, then run it
with Migrate/Migrate Plus as usual. As with any AI-assisted step, check the
output before trusting it on a full import.
