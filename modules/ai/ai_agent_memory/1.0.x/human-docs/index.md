# AI Agent Memory — manual setup guide

**AI Agent Memory** (`ai_agent_memory`) gives AI agents a memory that survives
from one turn of a conversation to the next. Normally an agent starts each turn
more or less fresh; with this module enabled, the agent retains its **tool‑call
history, intermediate results, and conversational context** so that later steps
can build on what happened earlier instead of re‑doing it.

It is a building block for the Drupal AI Agents framework rather than a feature
you interact with directly. Once installed, multi‑step agent workflows become
stateful: an agent can reference the output of a tool it called two turns ago,
carry context forward, and behave more consistently across a longer exchange.

The stored memory holds whatever the conversation surfaced — the agent's
tool‑call history and intermediate results — and is kept in Drupal's private
temp store, which the framework namespaces to the individual user or session
that created it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI Agents /
   AI Assistant API dependencies with Composer, and enable it.

## Where it lives in the admin menu

AI Agent Memory has no settings page of its own. It works as an extension of the
AI Agents framework: enable it and agents built on that framework gain persistent
memory automatically. It does add a permission, so you can control who is allowed
to work with the stored memory.

## How to use it

There is nothing to configure. Install and enable the module alongside the AI
Agents stack, and any agent that runs through that framework will begin retaining
its state across conversation turns. Developers building agents get statefulness
for free; site builders simply see agents that "remember" earlier steps in a
session.
