# Content Translation Access — manual setup guide

**Content Translation Access** (`content_translation_access`) adds **granular
permissions** to Drupal's core content translation. Out of the box, core offers
a fairly coarse control — a role can broadly translate entities or it cannot.
This module lets you decide *who may translate which content*, broken down by
**operation** (view, create, edit a translation), by **entity type and bundle**,
and by **language**. The classic use case is a French editor who should be able
to translate content *into French* but not into other languages, or a role that
may create translations for one content type but not another.

It is a true **access‑control** module, and it is written in the correct Drupal
idiom, which matters for anything that gates access. Its access handler returns
**neutral by default** — it never grants translation access unless a matching
permission is actually held, so it does **not fail open**. It grants access only
when the specific per‑operation / per‑type / per‑bundle permission passes, and it
still honours core's escape hatches such as **bypass node access** and a
**translate any entity** permission. In short: adding this module tightens
control; it does not accidentally loosen it.

The module depends on core **Content Translation** (which must be enabled) and
ships one optional submodule, **`content_translation_access_user`**, for
user‑level handling. It targets **Drupal 10.5 and 11**. It was originally
developed by KEY‑TEC and is now maintained by Metadrop. Note the maintainers'
own caveat: the module leans on core issue #2918354 for hook support, and if
core issue #3056020 is ever resolved, native functionality may eventually make
this module unnecessary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it (and
   optionally its submodule), and confirm core Content Translation is on.

There is **no dedicated settings screen** — as the module's own post‑install
guidance says, "no additional configuration screens are required." Everything is
done at **People → Permissions**, described below.

## How the permission model works

After enabling the module, go to **People → Permissions**
(`/admin/people/permissions`). You will find new, fine‑grained
translation permissions (the module's generated `cta …` permissions) that let
you assign translation rights **per role**, scoped by operation, entity
type/bundle and language. Assign them to the roles that should be able to
**view**, **create**, or **edit** translations for each content type and
language.

Because the access handler is neutral by default:

- A role with **no** matching permission gets **no** translation access from this
  module — it does not silently grant anything.
- A role is allowed to perform a translation operation **only** when a permission
  that matches that operation, entity type/bundle, and (assigned) language is
  granted to it.
- Core's **bypass node access** and **translate any entity** capabilities are
  still respected, so trusted super‑roles keep working as before.

What it controls is *translation* operations specifically. It layers on top of —
it does not replace — Drupal's ordinary entity access for viewing and editing the
underlying content, so continue to set those core permissions as usual.
