# Character Generator — manual setup guide

**Character Generator** (`charactergen`) does one small, focused job: it provides
a token that produces a random 10‑character alphanumeric string. It's meant to be
dropped into an **Automatic Entity Labels** pattern so new content can be labelled
with something like a registry number, reference code, or tracking identifier —
without you typing one by hand.

The generated string draws from a character set that deliberately leaves out
easily confused characters (no `I`/`1`, no `O`/`0`), so the codes are readable
when written down or read aloud. Under the hood the value is derived from the
current time down to the millisecond plus a small random number, which makes
collisions unlikely in practice.

One important caveat: this string is a **labelling convenience, not a secret**.
It is not guaranteed to be unique, and it is not unguessable — do not use it as a
password, security token, or anything that must be collision‑free. There is no
duplicate check.

The module works out of the box with no configuration. It depends on the
**Token** module, which provides the framework the `[charactergen:random]` token
plugs into.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Token dependency.

There is **no configuration page** for this module — it works out of the box. You
use its token wherever tokens are accepted, described in "How to use it" below.

## Where it lives in the admin menu

Character Generator adds no admin page of its own. It contributes the
`[charactergen:random]` token, which you use in places that accept tokens — most
commonly in the **Automatic Entity Labels** settings for a content type.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The Token
   module is required and comes along with it.
2. Go to the entity‑label configuration for your content type (for example, the
   **Automatic Entity Labels** settings on a content type's edit form).
3. Insert the token **`[charactergen:random]`** into the label pattern — on its
   own, or combined with other text/tokens (for example, `REF-[charactergen:random]`).
4. Save. New entities of that type will now be labelled with a fresh random
   10‑character code.
