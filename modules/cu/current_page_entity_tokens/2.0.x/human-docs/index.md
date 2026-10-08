# Current Page Entity Tokens — manual setup guide

**Current Page Entity Tokens** (`current_page_entity_tokens`) exposes the content
entity of the page you're currently on as a set of tokens under a new
`[current-page:*]` group. That lets any token-aware field or setting reference the
*current page's own* node (or term, user, media…) and its fields — even from a
block, paragraph or View that doesn't otherwise know which entity it's rendered on.
For example, a block placed on article pages can pull `[current-page:node:title]`
or `[current-page:node:field_email]` straight from whichever article is being
viewed.

It's a tiny glue layer over the contrib [Token](https://www.drupal.org/project/token)
module. It registers a `current-page` token type with one child per content entity
type that supports tokens (node, taxonomy term, user, media, and so on), then
resolves each token from the current request's route: `[current-page:node]` gives
the node's label, and anything deeper — `[current-page:node:title]`,
`[current-page:node:field_foo]`, `[current-page:node:author:name]` — is handed off
to Token's normal entity token tree, so the entity's full set of existing tokens is
available. Cache metadata is passed through correctly.

There's nothing to configure: it has no admin UI, no settings, no permissions and no
new field or plugin types. Once enabled, you simply use the tokens anywhere Drupal
does token replacement. It requires the **Token** module (`^1.0`). Two things worth
knowing: a token only resolves when the current route actually has that entity as a
parameter (so `[current-page:node]` works on a node page, `[current-page:taxonomy_term]`
on a term page, etc.), and — like any entity token — it doesn't add its own access
checks, so place it only where the surrounding output is appropriate for the
audience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Token.

## Where it lives in the admin menu

Nowhere — there is no admin page. The tokens it adds show up in the standard token
browser (the *Browse available tokens* dialog) under **Current page**, wherever
Drupal offers one.

## How to use it

Use the tokens anywhere Drupal performs token replacement — field and setting
defaults, Views global text areas, block content, metatags, or another module's
token-enabled field. A few examples:

```
[current-page:node:title]
[current-page:node:field_email]
[current-page:taxonomy_term:name]
[current-page:user:mail]
[current-page:media:field_credit]
```

Typical uses include autofilling an embedded Webform field from the host node (e.g.
a reply-to address), feeding the current node's taxonomy into an embedded View
argument, building meta values from the current entity, or pulling the parent node's
data into a paragraph rendered on it. Remember the token only produces a value when
the current page's route carries that entity type as a parameter.
