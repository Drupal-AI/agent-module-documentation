# Partial Access — manual setup guide

**Partial Access** (`partial_access`) is a lightweight module for building a
simple, paywall‑style barrier on node content. Instead of relying on teaser fields
or extra view modes, it **truncates the body field directly** for visitors who are
not allowed to see the whole thing, and shows a customizable **call‑to‑action
(CTA)** message in place of the hidden portion. Site administrators choose which
user roles get full content; everyone else sees only a percentage of the body plus
the CTA.

It is aimed at content creators, publishers, and membership sites that want to
gate articles — premium posts for members, teasers for anonymous visitors, tiered
educational resources, lead capture via a CTA — without adding a payment gateway
or restructuring content types. It works with any content type that has a body
field and has no external dependencies, depending only on core's **Node** and
**User** modules.

> **Important — this is not real access control.** As shipped (1.0.0), the
> truncation is applied **only on the HTML render path**: a `KernelEvents::VIEW`
> subscriber shortens the loaded node's body just before it renders. It does **not**
> implement Drupal's node‑access or field‑access system. That means the full,
> "restricted" body is still returned in full through **JSON:API**
> (`/jsonapi/node/…`), **REST**, **Views**‑based feeds, and **search indexing** —
> every path that bypasses the HTML rendering. Treat Partial Access as a
> presentation‑layer teaser/soft‑paywall for ordinary web visitors, and do **not**
> rely on it to keep genuinely sensitive content secret. For real gating, use an
> authoritative access or subscription mechanism.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose which roles see full content
   and write the CTA message shown to everyone else.

## Where it lives in the admin menu

After enabling, Partial Access adds a simple settings form — the project describes
it as **Configuration → Partial Access Settings** — where you pick the roles with
full access and set the CTA message. See [Configuration](configuration/index.md).
