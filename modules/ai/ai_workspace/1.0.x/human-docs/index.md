# AI Workspace — manual setup guide

**AI Workspace** (`ai_workspace`) gives each user their own persistent AI chat
workspace inside Drupal — a ChatGPT‑style interface with saved conversation
history, streaming responses, and provider‑agnostic model selection driven by the
AI module. Staff can hold ongoing conversations, come back to them later, and
switch between the AI models and tools you have made available, all without
leaving the site.

Conversations are stored per user and persist over time. Because those saved
prompts and replies can contain sensitive information, the module keeps usage to
authenticated users and separates the permissions: using the workspace, managing
which models are offered, managing which tools are offered, and administering the
feature are each gated independently. Keep usage to trusted staff and scope the
model/tool management permissions to administrators.

It relies on the AI module for the actual model calls, so every conversation runs
through your configured provider and incurs that provider's cost.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The workspace is a user‑facing chat interface for authenticated users; its
administration and the model/tool management are gated by the module's
permissions (set under **People → Permissions**). The AI providers and models it
can use are configured in the **AI** module.

## How to use it

1. Make sure the **AI** module has a working provider and the models you want to
   offer.
2. Enable AI Workspace and grant permissions:
   - `use ai workspace` — to the staff who should chat.
   - `manage ai workspace models` / `manage ai workspace tools` — to admins who
     curate the available models and tools.
   - `administer ai workspace` — to administrators.
3. Users open their workspace, start conversations, and switch models as allowed;
   their history is saved per user.

> **Sensitive data:** conversations persist per user and may contain sensitive
> prompts. Keep usage to authenticated staff.
