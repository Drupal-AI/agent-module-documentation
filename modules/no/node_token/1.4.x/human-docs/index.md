# Node Token — manual setup guide

**Node Token** (`node_token`) gives every content type its own token type. Instead
of one generic `[node:…]` token type covering all content, you also get
`[node-article:…]`, `[node-page:…]` and so on — one per node bundle — and each of
them lists only the fields that actually exist on that content type.

On a site with many content types and many fields, the standard token browser
becomes an unusable wall of options, many of which will silently resolve to
nothing on a given content type. Node Token fixes this at the discovery level. It
clones the generic node token type for each bundle, labels it with the content
type's name, and then prunes the token list so that fields which don't exist on
that bundle are removed. An editor configuring a Pathauto pattern or an email
template for Articles no longer sees tokens for Page-only fields.

This is purely a usability improvement — the actual token *values* still come from
the Token module exactly as before. There is nothing to configure, no permissions,
and no content changes; the new token types simply appear wherever tokens are
offered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Node Token adds no admin pages, permissions or settings. Its effect shows up
inside any **token browser** — the pop-up token list on Pathauto patterns, Metatag
configuration, email templates, views, and similar — where you will now see a
per-content-type token type alongside the generic node one.

## How to use it

There is no setup beyond enabling the module. After it is on (and after a cache
rebuild), open any token browser and you will find token types named after your
content types, for example **Article** (`node-article`) or **Basic page**
(`node-page`), each showing only that type's fields.

Things worth knowing:

- **The generic `[node:…]` type is not removed.** Both the generic type and the
  new per-bundle types are available.
- **Tokens update as you change fields.** Add or remove a field on a content type
  and, after `drush cr`, the offered tokens for that bundle change to match.
- **In the UI it just works.** When you pick a per-bundle token in Pathauto,
  Metatag or similar, the integration passes the node through for you.
- **For developers calling the token service directly**, the data key must match
  the token type name — pass `['node-article' => $node]` (not `['node' => $node]`)
  to resolve `[node-article:…]` tokens. See the
  [`agent/`](../agent/start.md) docs for the exact call.
