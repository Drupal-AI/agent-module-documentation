# AI Schema.org JSON-LD — manual setup guide

**AI Schema.org JSON-LD** (`ai_schemadotorg_jsonld`) uses AI — via the **AI
Automators** framework — to **generate Schema.org JSON‑LD structured data and
attach it to your content**. The result is rich, schema.org‑marked‑up metadata
emitted into your pages for search engines, without you hand‑writing the JSON‑LD.

It works through AI Automators, so schema generation is wired into your content
model as an automated field behaviour: content is analysed, the AI produces the
JSON‑LD, and it is stored (in a JSON field) and emitted on the page. Two optional
submodules extend it — a **breadcrumb** helper and a **log**.

Two things matter before relying on it. The **content is sent to the configured
AI provider** to generate the JSON‑LD (external data egress if the provider is
cloud‑based — confirm that is acceptable; credentials are handled as secrets by
the AI module). And because the generated JSON‑LD is emitted into your pages,
**review the AI output before depending on it**. The module has no
access‑control role of its own.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note its submodules.

## How to use it

1. **Install and enable** the module and its dependencies (see
   [Installation](installation/index.md)).
2. **Configure an AI provider** in the AI module with its API key stored as a
   Key — this is what generates the JSON‑LD.
3. **Set up the AI Automator** on the content where you want structured data,
   mapping it to the JSON field the module uses. Field Widget Actions gives you a
   button to trigger generation on the edit form.
4. **Review the generated JSON‑LD** before publishing, and confirm the content
   egress to your AI provider is acceptable.
