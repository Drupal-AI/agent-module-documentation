<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Author Tokens (revision_author_tokens) — agent index

Adds three `node` **revision-author** tokens via `hook_token_info()` / `hook_tokens()`. The
author of a node's *current revision* is the person who made the latest edit — distinct from
`[node:author]` (the node's owner/creator), for which core has no token. Depends only on core
`token`. No routes, permissions, config, schema, services, or plugins — two functional files
(`.tokens.inc` + empty `.module`). Core `^10 || ^11`.

The three tokens (exact machine names, verified at runtime):

- `[node:revision-author]` — the revision user's **display name** (`getDisplayName()`).
- `[node:revision-author-uid]` — the revision user's **user id** (`id()`).
- `[node:revision-author-mail]` — the revision user's **email** (`getEmail()`).

Each resolves to `''` (empty string) when the revision has no revision user set.

> **README name discrepancy:** the project README/feed calls the mail token
> `[node:revision-author-email]`. That is wrong — the registered token id is
> `revision-author-mail`, so the working token is **`[node:revision-author-mail]`**. Use the
> `-mail` form.

## What you'd do → where

- **Use the tokens, know exactly what each emits, sanitization behavior, and where they work
  (Pathauto / Metatag / mail / ECA / Rules / Views)** → [api/tokens.md](api/tokens.md)

## Key facts

- Source of everything: `revision_author_tokens.tokens.inc` (`hook_token_info` +
  `hook_tokens`). The `.module` file is empty.
- Token group extended: **`node`** (only fires when `$type == 'node'` and `$data['node']` is a
  loaded node).
- Values come from `$data['node']->getRevisionUser()` — the account stored as the revision's
  author, not the node owner and not the acting/current user.
- **Privacy caution:** these tokens name a person (and one exposes their email). A pattern that
  places a revision author into a public URL alias, a meta description, or a rendered field
  discloses who edited a page to every reader. Keep them to internal notifications and admin
  displays unless disclosure is intended.
