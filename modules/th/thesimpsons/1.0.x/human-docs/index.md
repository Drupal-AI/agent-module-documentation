# The Simpsons — manual setup guide

**The Simpsons** (`thesimpsons`) is a fun, novelty module that shows a random quote
from the animated TV series *The Simpsons* in a block. Drop the block into a region
and each visitor gets a light-hearted quote — nice for a bit of personality on a
site footer, sidebar, or landing page.

The quotes come from Wikiquote: the module scrapes them from there, so it reaches
out to an external site to gather quotes. That is worth knowing if your environment
restricts outbound network access. There are no other dependencies beyond Drupal
core, and the module has just one job — displaying a random quote in a block.

There is one small option: if you want the quotes translated into your site's
language, you can turn that on from the module's settings page. Otherwise the module
is essentially place-the-block-and-go. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the block and (optionally) turn
   on translation of the quotes.

## Where it lives in the admin menu

The block is placed from **Structure → Block layout** (`/admin/structure/block`).
The one setting — translating quotes into your site language — lives at
`/admin/config/system/simpsons`.
