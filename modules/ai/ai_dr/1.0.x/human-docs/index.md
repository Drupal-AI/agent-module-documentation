# AI Deep Reference — manual setup guide

**AI Deep Reference** (`ai_dr`) is a small, focused helper: it adds Drupal
**tokens** that expose the *description* text of taxonomy terms, including terms
referenced from a node. Out of the box Drupal's token system gives you a term's
name easily, but reaching the description of a term referenced by a node field
is awkward — this module fills that gap.

It registers two tokens. `[term:description]` resolves a term's own description
wherever tokens are supported. `[node:term-description:FIELD_NAME]` walks an
entity-reference field on a node, collects the descriptions of every referenced
term, and joins them into a single string.

The intended use is feeding richer context into AI prompt templates that are
assembled from tokens — for example, giving a language model the glossary-style
description behind a category rather than just its label. But it is a generic
token provider, so it works anywhere Drupal resolves tokens: mail templates,
metatags, Views, and so on.

The module is deliberately tiny. It is implemented purely with Drupal's token
hooks, depends only on the **Token** module, and adds no routes, permissions,
forms, services or settings — so there is nothing to configure once it is
enabled.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — AI Deep Reference has no admin page and no settings. It simply makes
its two tokens available across the site once enabled.

## How to use it

Use the tokens anywhere tokens are supported:

- `[term:description]` — the description of the current taxonomy term.
- `[node:term-description:field_name]` — the joined descriptions of the terms
  referenced by `field_name` on the current node (replace `field_name` with your
  actual entity-reference field's machine name).

For AI work, drop these tokens into a prompt template so the model receives the
descriptive text behind a node's categories. Because descriptions resolve live,
the prompt context stays in sync whenever you edit a term.
