# Domain Path Redirect — manual setup guide

**Domain Path Redirect** (`domain_path_redirect`) makes the **Redirect** module
domain-aware, so the same source path can redirect to a *different* destination on
each domain of a Domain Access site. It is part of the **Domain** ecosystem and
requires both the `domain` module and the **Redirect** module (version 1.12.0 or
newer).

Ordinary Redirect stores one redirect per source path for the whole site, which
breaks down as soon as several domains share a Drupal install and each needs the
same path to go somewhere else. For example, `/node/2` might need to point to
`/node/25` on `example1.com`, `/node/17` on `example2.com`, and `/user/7` on
`example3.com`. This module adds a dedicated *domain path redirect* entity so you
can create exactly that: an alternative redirect scoped to a single domain,
managed from its own admin listing.

The module reuses Redirect's own **`administer redirects`** permission rather than
inventing a new one — so anyone who can administer redirects can manage every
domain's redirects; there is no per-domain permission split. One thing worth
planning for: these redirects are stored as **content**, not configuration, so
they do not travel with a config export — move them with a content migration or
entity export when promoting between environments. The entity is also
non-translatable, so on a multilingual multi-domain site the domain itself must
carry the language distinction.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain and Redirect.
2. [Configuration](configuration/index.md) — create and manage per-domain
   redirects from the admin listing.

## Where it lives in the admin menu

Domain path redirects are managed from their own listing at **Configuration →
Search and metadata → Domain Path Redirect**
(`/admin/config/search/domain_path_redirect`), gated by the Redirect module's
**Administer redirects** permission.
