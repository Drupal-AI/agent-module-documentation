# Logo per language — manual setup guide

**Logo per language** (`lpl`) lets a multilingual site show a **different logo for
each installed language**. Drupal's core site logo is a single theme setting with
no language dimension, which becomes a problem the moment a brand's mark contains
words: an Arabic or Japanese site showing a Latin‑script logo looks unfinished,
and organisations with legally distinct names per market can't use one image at
all. This module solves that by swapping the logo according to the visitor's
active language.

It's deliberately tiny and integrates where you'd expect. Rather than adding an
admin page of its own, it **extends the existing theme settings form** with one
logo field per installed language, and swaps the correct logo in at render time.
So there's nothing new for an administrator to learn — you set the per‑language
logos in the same place you already set the site logo. It keeps all of core's
default logo behaviour intact, and has no dependencies, routes, or permissions of
its own.

One thing to note: the module does not declare a dependency on the Language or
Content Translation modules. On a **single‑language** site it simply has one
language to offer, so it's harmless but pointless there — it earns its keep only
once you have more than one language installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form of
its own. You set the per‑language logos on the existing theme settings form, as
described in "How to use it" below.

## Where it lives in the admin menu

Logo per language adds no admin page. You configure it at **Appearance → Settings**
(`/admin/appearance/settings`), or a specific theme's settings page, where the
module adds one logo field per installed language in the logo settings area.

## How to use it

1. Make sure you have more than one language installed (**Configuration →
   Regional and language → Languages**) — this module only does something useful
   on a multilingual site.
2. Go to **Appearance → Settings** (or the settings page for the theme you want to
   change).
3. In the logo settings, upload or select a logo for each language.
4. Save. Each language now shows its own logo, with core's default logo behaviour
   preserved as the fallback.
