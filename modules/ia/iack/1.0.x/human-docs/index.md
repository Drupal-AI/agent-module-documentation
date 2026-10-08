# IA Creation Kit — manual setup guide

**IA Creation Kit** (`iack`) — the Information Architecture Creation Kit — turns a
spreadsheet describing your site's information architecture into a working content
model. You fill in a template workbook that lists your content types, fields,
vocabularies, and terms; you upload it; and behind the scenes the module drives an
AI agent to create those structures in Drupal for you. It's a way to go from an IA
spec — the kind of thing a stakeholder or content strategist might hand you as a
spreadsheet — to real content types and taxonomy without clicking through the
field UI dozens of times.

Under the hood, the module parses the workbook (sheets such as *Vocabulary*,
*Taxonomy terms*, and *Fields*) and builds natural‑language prompts — for example
"Create Taxonomy vocabulary — X" and "Add the following terms…". Those prompts are
handed to Drupal's AI Assistant API, and the configured AI assistant/agent
executes the structural changes. The heavy lifting, and any calls to an external
LLM, happen inside the AI provider you've configured — not in this module itself.

Because it commands an AI agent that can create content types, fields, and
taxonomy, this is a **powerful administrative capability**. Its permission is
marked restricted for good reason: grant it only to trusted administrators, and
try it on a non‑production environment first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies and enable it.

## Where it lives in the admin menu

The upload screen is at **`/admin/config/ai/iack`** (Configuration → AI →
Information Architecture Creation Kit), gated by the restricted **Upload
information architecture** permission.

## How to use it

1. **Configure the AI ecosystem first.** IACK relies on the Drupal AI modules, so
   set up an AI provider and an AI assistant before you start — that's where the
   actual model calls happen. Without a working assistant, the prompts have
   nothing to run against.
2. **Fill in the IA template.** The module ships a template workbook
   (`template/iatemplate.xlsx`). Use it as your starting point and describe your
   vocabularies, terms, content types, and fields across its sheets.
3. **Upload the workbook.** Go to `/admin/config/ai/iack` and upload your
   completed `.xlsx` file.
4. **Let the agent build the structures.** The module converts the sheets into
   prompts and sends them through the AI Assistant API runner, which creates the
   vocabularies, content types, and fields.
5. **Iterate.** Refine your spreadsheet and re‑upload to adjust or extend the
   information architecture.

Grant the **Upload information architecture** permission only to administrators
you trust, since the agent it drives can make sweeping structural changes to your
site.
