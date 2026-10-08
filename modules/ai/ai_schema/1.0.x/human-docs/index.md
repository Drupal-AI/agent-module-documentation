# AI Schema — manual setup guide

**AI Schema** (`ai_schema`) exports Drupal's **entity and field definitions as
compact, machine‑readable JSON** designed for an LLM to read. It describes your
site's content model — which entity types and bundles exist, and what fields and
field types they have — in a form an AI agent or external tool can consume
directly, without crawling your configuration.

This is a building block for AI features, not something with a front‑end of its
own. If you are building an AI tool that needs to *reason about your site's
structure* (for example, function‑calling or an agent that maps content types),
this module gives it a clean structural description to work from.

Note that the exported schema describes **structure, not content** — it lists
fields and types, not the values stored in them. Even so, it does reveal your
content model, so expose the output only where that is appropriate. The module is
a developer/API utility with no content or access role of its own.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. **Install and enable** the module (see [Installation](installation/index.md)).
2. **Consume the JSON schema** it produces from your AI feature, agent, or tool
   to give it an understanding of your entity and field structure.
3. **Expose it appropriately** — because the schema reveals your content model,
   make it available only to the tools and people who should see it.
