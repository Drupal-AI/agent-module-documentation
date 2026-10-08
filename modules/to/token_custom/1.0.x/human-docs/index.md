<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Tokens — manual setup guide

**Custom Tokens** (`token_custom`) lets you define your own reusable tokens
right in the admin UI — no code required. Each token has a machine name and a
block of formatted content, and it resolves anywhere Drupal's Token system runs.
Store your company name once as `[custom:company_name]`, and every place that
prints that token shows the same value. Change it in one form and it updates
everywhere at once.

Tokens are grouped into *token types*. A default type called **`custom`** ships
with the module, so out of the box the tokens you create resolve as
`[custom:<machine_name>]`. You can add your own types to organize tokens — for
example a `department` type giving you `[department:manager]`. Because each
token's content runs through a text format, a token can hold plain text or rich
HTML (a legal disclaimer, a promo banner, a call-to-action button). And because
tokens are ordinary content entities, they are translatable — translators can
give a token a different value per language.

This is the friendly place to centralize boilerplate copy that editors need to
change without a developer: support email, office address, tagline, seasonal
opening hours, social handles, recurring prices. Anywhere Token-aware modules
run — Pathauto, Metatag, email bodies, node fields — your custom tokens are
available too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Token dependency.
2. [Configuration](configuration/index.md) — create and manage tokens and token
   types, field by field.

## Where it lives in the admin menu

Tokens and types are managed at **Structure → Custom Tokens**
(`/admin/structure/token-custom`). From there you get an *Add Token* action and a
*Custom Token Types* tab for adding new token types.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Custom Tokens** and click **Add Token**.
3. Give it a name, a machine name, pick a token type, and write the content.
4. Reference it as `[<type>:<machine_name>]` — for example `[custom:company_name]`
   — anywhere Drupal accepts tokens.
