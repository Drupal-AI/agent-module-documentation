# Project Browser AI — manual setup guide

**Project Browser AI** (`pb_ai`) makes Drupal's core **Project Browser** searchable
in a smart, AI-assisted way. Instead of matching only on keywords, it lets a site
builder describe what they need in natural language ("a module for scheduling
social media posts") and get relevant module suggestions back. The goal is to make
module discovery feel like asking a knowledgeable colleague rather than guessing
the right search term.

Because the "smart" part is powered by AI, each smart search may make a call to an
AI provider (an LLM). That means two things to keep in mind: you configure an AI
provider and an API key, and each search can incur a request to — and a cost from —
that provider. This is a **beta** release and is minimally maintained, so treat it
as an enhancement to the module-discovery experience rather than a production-
critical dependency.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — connect an AI provider, store the API
   key as a secret, and understand the egress and cost implications.

## How to use it

Once configured, Project Browser AI enhances the normal Project Browser search
experience. Open the Project Browser (**Extend → Browse**, where available) and use
its search — the AI-assisted results surface modules that match the *intent* of your
query, not just the exact words. There is no separate front-end page to visit; the
smart search augments the browser you already use.
