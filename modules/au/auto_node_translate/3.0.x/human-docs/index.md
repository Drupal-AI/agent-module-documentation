# Auto Node Translate — manual setup guide

**Auto Node Translate** (`auto_node_translate`) adds an **Auto Translate**
operation to your translatable content. Instead of retyping a node's fields in
every language by hand, an editor clicks *Auto Translate*, picks the target
languages, and the module machine‑translates the node's text, link, and paragraph
fields for them — creating (or updating) each translation in one pass.

It builds on core's **Content Translation** and works through a pluggable
translation‑provider backend. **MyMemory** ships built in and needs no API key to
get started (you can optionally register an email to raise the free word quota). If
you want a different engine — DeepL, Google, LibreTranslate, and so on — a
developer can add a provider plugin without patching the module, and you then
select it on the settings page.

The module is thorough about what it translates: plain and formatted text,
summaries, link titles, and it recurses into **Paragraphs** (entity‑reference
revisions) so nested content comes along too. Over‑long machine output is
truncated to fit each field's limit, and non‑translated fields are copied across.
If **Content Moderation** is enabled, you can choose whether new translations land
as *Draft*, *Published*, or keep the source's moderation state — handy for
seeding translations that humans then post‑edit.

Access is controlled by permissions: a per‑content‑type **auto translate** permission
(on top of the usual core content‑translation permissions), plus a restricted
**Configure Auto Node Translate** permission for the settings pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the multilingual prerequisites.
2. [Configuration](configuration/index.md) — the settings forms (provider,
   moderation state, MyMemory email), permissions, and running a translation.

## Where it lives in the admin menu

- **Main settings:** Configuration → Regional and language → Auto Node Translate
  settings (`/admin/config/regional/auto-node-translate-settings`).
- **MyMemory settings:** Configuration → Regional and language → My Memory
  (`/admin/config/regional/my-memory`).
- The **Auto Translate** operation itself appears on each node's **Translate** tab
  and in the content list's operations.
