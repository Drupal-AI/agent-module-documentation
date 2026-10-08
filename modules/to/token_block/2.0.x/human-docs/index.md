# Token Block — manual setup guide

**Token Block** (`token_block`) gives you a single configurable block whose body
text is run through the [Token](https://www.drupal.org/project/token) module's
`[token]` replacement when it renders. That lets you place a block that shows
dynamic values — the site name, the current date, the current node's title or
author, the logged-in user's name — without writing a custom block plugin. A classic
use is a footer copyright line like `Copyright [date:custom:Y] [site:name]`.

You place and configure it entirely through core's **Block layout**. When you place
a *Token Block*, its configuration form has a single **Body** field with a "Browse
available tokens" link so you can pick from every token the site exposes. On render,
the module takes the body text, replaces the tokens, and outputs the result. The
block is also cache-aware: it re-renders per URL, query, language, and route, and
when the page has a node it adds that node's cache tag so a block using node tokens
updates when the node changes.

**One behavior to understand.** Although the Body field uses a text-format editor
pinned to *Full HTML*, the selected text format's filters are **not** applied at
render time — only the token-replaced string is emitted. Drupal still runs it
through its admin-HTML sanitizer (which strips `<script>` and event handlers but
allows a broad set of admin tags), so placing or editing a Token Block is an
admin-trust operation, gated by core's **Administer blocks** permission. Don't embed
unfiltered untrusted token values expecting the text format to clean them — it will
not.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Token module.

## How to use it

Token Block has no dedicated settings page — you work entirely in core **Block
layout** at **Structure → Block layout** (`/admin/structure/block`).

1. Click **Place block** in the region you want, and search for **Token Block**
   (it appears under the *Token Block* category).
2. In the block configuration form, fill in the **Body** field with your text and
   tokens — use the **Browse available tokens** link to find the right ones, for
   example `[site:name]`, `[date:custom:Y]`, `[node:title]`, or
   `[current-user:display-name]`.
3. Save the block.

The block now shows the token-replaced text wherever you placed it. To show
different content per language, use language-aware tokens; the block re-renders per
language automatically. You can place as many Token Blocks as you like, each with
its own body.
