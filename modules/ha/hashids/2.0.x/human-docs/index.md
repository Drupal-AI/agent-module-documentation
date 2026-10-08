# Hashids — manual setup guide

**Hashids** (`hashids`) generates short, unique, non-sequential IDs from
integers. It turns a number like `347` into a string like `yr8`, or an array of
numbers like `[27, 986]` into `3kTMd`, and it can decode those strings back into
the original numbers. The typical use is tidier URLs and identifiers: instead of
exposing a raw, obviously-sequential node ID, you show a short YouTube-like code.
It wraps the well-known [Hashids](http://hashids.org/) algorithm and exposes it
to Drupal.

The module ships a submodule, **Hashids Hash field** (`hashids_hash_field`),
which lets you generate a hashid from reference IDs you pick in a field's
settings (it supports entity reference, Commerce, and relation references), and
it provides its own permissions.

> **Important — this is obfuscation, not encryption or a security control.**
> A hashid is fully **reversible**: anyone can decode it back to the original
> integer, and the salt is *not* a secret key. It only *obscures* a sequential
> ID; it does **not** protect it. Never rely on hashids to control access or to
> prevent enumeration/IDOR attacks — an object addressed by a hashid is still
> just an integer ID underneath. Access must be enforced by proper
> permission and entity-access checks, exactly as it would be without hashids.
> Use hashids purely for tidier identifiers, never as a security boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally turn on the Hashids Hash field submodule.

This module has **no dedicated configuration page** in the sense of a big
settings form; the salt and alphabet that shape how IDs are encoded are managed
through the module's configuration, and the field behaviour is configured
per-field on the Hash field (see below). Everything you need for setup is on the
Installation page and here.

## How to use it

- **Encode and decode from code.** Hashids exposes helper functions so custom
  code can turn integers into short strings and back — for example generating a
  hashid from a node ID for a cleaner URL, then decoding it when the request
  comes back in.
- **The salt and alphabet.** Hashids uses a *salt* and an *alphabet* to shape the
  output strings. Changing the salt changes the codes that get produced, so
  settle on it early: if you change the salt after codes are already in use
  (bookmarked, shared, indexed), previously issued hashids will decode
  differently. Remember the salt is not secret — it only varies the output, it
  does not make the codes unguessable in a security sense.
- **The Hash field submodule.** Enable `hashids_hash_field` to add a field that
  produces a hashid based on reference IDs you choose in the field settings
  (entity reference, Commerce, or relation references). Configure it on the
  relevant content type or entity bundle under **Manage fields** and **Manage
  display**.

Keep the security note above in mind at every step: hashids make identifiers
tidier, nothing more.
