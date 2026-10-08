# AI Answers — manual setup guide

**AI Answers** (`ai_answers`) is a question‑and‑answer engine that gives grounded,
**cited** answers instead of free‑form guesses. It uses a technique called RAG
(retrieval‑augmented generation): when a visitor asks a question, an AI agent
first retrieves the most relevant indexed content from your site, then writes an
answer based on that content and links back to the sources it used.

It builds on two other modules. **AI Search** provides the indexing and retrieval,
and the **AI Agents** framework runs the agent that assembles the answer. AI
Answers brings its own retrieval configuration on top of AI Search, so answers stay
anchored to your real content rather than drifting into hallucination.

Access is split across three permissions: one to **use** the answer engine, one to
**administer** it, and one to **view answer traces**. Traces can reveal the
retrieved content and the prompts behind an answer, so keep trace viewing
restricted to people who genuinely need it for debugging.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI Agents /
   AI Search dependencies with Composer, and enable it.

## Where it lives in the admin menu

AI Answers is governed by three permissions — **use ai answers**, **administer ai
answers** and **view ai answers traces**. Grant "use" to the audience that should
ask questions, "administer" to the site builders who configure retrieval, and keep
"view traces" for debugging only.

## How to use it

1. Set up **AI Search** (index your content) and the **AI Agents** stack, with an
   AI provider configured.
2. Enable AI Answers and configure its retrieval so it draws on the right indexed
   content.
3. Grant the **use ai answers** permission to your users. They can then ask
   questions and receive answers with citations back to the source pages. Use the
   trace view to inspect how a given answer was produced when you need to debug it.
