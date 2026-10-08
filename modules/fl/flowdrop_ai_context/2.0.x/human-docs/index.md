# FlowDrop AI Context — manual setup guide

**FlowDrop AI Context** (`flowdrop_ai_context`) connects the **AI Context** module
(also known as the Context Control Center) to **FlowDrop**, the visual workflow
editor. It adds a FlowDrop node processor that injects structured, reusable AI context
into a workflow — so the AI steps in your flow get the background information they need
to produce more accurate, consistent results.

There are two ways to add context to a node. You can **pin** a specific piece of
context while building the workflow, or let the **dynamic selector** read the incoming
request at run time and automatically choose the most relevant context for the job.
Context is grouped in a hierarchy — select a main topic and its supporting details
come along too — and it is delivered in a clean, AI‑friendly format that models parse
reliably. Because context is defined once in a central library, you can reuse it across
many workflows and update it in one place. When the node is connected to an AI agent,
it automatically follows that agent's own context rules.

This is an integration/bridge module with **no settings page of its own**. The context
entries themselves are managed in the AI Context module, and you place and configure
the context node inside the FlowDrop editor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with its FlowDrop and AI Context dependencies.

There is **no configuration page** for this module. Define your context entries in the
[AI Context](https://www.drupal.org/project/ai_context) module, then add and configure
the context node inside a workflow in the
[FlowDrop](https://www.drupal.org/project/flowdrop) editor.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and define one or more
   context entries in the AI Context module.
2. Open a workflow in the FlowDrop editor and add the **AI Context** node processor.
3. Either pin a specific context entry, or leave the node on automatic selection so the
   dynamic selector picks the most relevant context for each run.
4. Connect the node upstream of the AI steps that should be grounded by that context.
