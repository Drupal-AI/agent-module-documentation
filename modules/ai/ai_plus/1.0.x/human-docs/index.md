# AI + — manual setup guide

**AI +** (`ai_plus`) adds an AI chatbot assistant to Drupal's **Edit Mode**. It
brings the AI Chatbot and AI Agents into the **Navigation Plus** editing
experience (together with **Entity Blueprint**), so an editor working in edit
mode can ask an AI assistant to help build and change content and configuration
right where they are, without leaving the page they are editing.

It is a front-of-site authoring add-on to the Drupal AI ecosystem, and it stitches
several pieces together: **Navigation Plus** (the edit-mode experience), the AI
module's **AI Chatbot** submodule, **AI Agents**, and **Entity Blueprint** (plus
its AI companion). It requires Drupal 11.

This is a powerful assistant: it runs through your configured AI provider (so
there is a per-call cost) and, because it uses AI Agents, it can **create and
modify entities** on your behalf. Access is gated by the **Use AI assistant**
permission (`use ai assistant`) — keep it to trusted editors, since the assistant
can change content and configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm its Navigation Plus, AI Chatbot, AI Agents, and Entity
   Blueprint dependencies.

## Where it lives in the admin menu

There is no standalone settings screen; AI + surfaces the assistant **inside Edit
Mode** through Navigation Plus. The AI provider it uses is configured in the
**AI** module's settings, and who may use the assistant is controlled by the
**Use AI assistant** permission.

## How to use it

Enter Edit Mode (via Navigation Plus) on the page you're working on and open the
AI chatbot tool. Ask it, in plain language, to build or adjust content and
configuration; because it uses AI Agents, it can act on entities directly.
Restrict the **Use AI assistant** permission to trusted editors, and review what
the assistant changes.
