# Context Control Center — manual setup guide

**Context Control Center** (`ai_context`) manages the **context** that gets fed into
AI agent prompts on your site. AI agents produce much better output when they are
given the right background — organisation facts, tone-of-voice guidance, product
knowledge, editorial policies — but that background usually ends up scattered through
code and hard-coded prompts. This module turns it into editable content that
non-developers can maintain.

Each piece of context is a **context item** — a content entity you can draft, review
through content moderation, and translate, just like any other content. Which items
apply to which prompt is decided by **scope plugins**: shipped scopes let you attach
context globally, or narrow it to a content type (entity bundle), a specific target
entity, a language, a site section, or a tag. A second entity type records where
context was actually **used**, so you can report on and audit which context reached
which prompt — useful for debugging why an agent answered the way it did.

Because context directly steers what an AI agent does, every permission the module
provides is a restricted, trusted permission. Context can be authored in Markdown for
readability, and the module integrates with the AI module's tool/function-call
system, Scheduler, and the Diff module. It is a beta release (installed as
`1.0.0-beta3`), so expect entity schemas and plugin signatures to still shift between
releases.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, note the sizeable
   dependency list, and enable the module.
2. [Configuration](configuration/index.md) — the admin UI, creating context items,
   choosing scopes, and reviewing usage.

## Where it lives in the admin menu

The admin UI is under **Configuration → AI → Context**
(`/admin/config/ai/context`).

## How to use it

In short: create context items holding the background you want your agents to have,
give each item one or more **scopes** so it applies where you intend, review and
publish them through moderation, and then use the **usage** records to see which
context actually reached your prompts. See
[Configuration](configuration/index.md) for the walkthrough.
