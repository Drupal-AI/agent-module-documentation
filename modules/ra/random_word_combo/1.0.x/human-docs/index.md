# Random word combo — manual setup guide

**Random word combo** (`random_word_combo`) generates memorable random names by
combining a word from one list with a word from another — think `brave-otter` or
`sunny-harbor`. You supply the two word sets (each just a space-separated list of
words), and the module pairs them into human-friendly identifiers on demand.

You can create as many **sets** as you like. For each set you decide whether the
generated combination must be **unique**: if you enable uniqueness, the module
keeps database records of every combination it has handed out and stops once the
pool is exhausted, guaranteeing no repeats (at the cost of a little overhead). If
you don't need uniqueness, it simply generates freely. Admins can flush the
stored combinations for a set at any time to reset it.

Each set can also expose a **token**, so the random combination can be dropped
into other modules that accept tokens. Beyond tokens, the module offers a service
(`random_word_combo.combiner`) for developers, and a UI for generating a
combination by hand.

Typical uses: a memorable random name for a group or content entity, a friendly
confirmation code, or anywhere you'd rather have `clever-badger` than a long
opaque string.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

You manage word-combo sets under **Structure → Random Word Combos**. A default
set is provided out of the box; you can edit it or add your own.

## How to use it

1. Go to **Structure → Random Word Combos** and either edit the default set or
   add a new one.
2. For each set, provide the **two word lists** — the words for each side of the
   combination, separated by spaces.
3. Decide whether the set should **ensure unique** combinations. If enabled, the
   module tracks generated combinations in the database and won't hand out
   duplicates; when the pool runs out, it stops generating. (Admins can flush the
   stored combinations to start over.)
4. Optionally enable a **token** for the set so the random combination is
   available to token-aware modules.
5. Generate combinations in one of three ways:
   - **Through the UI**, by generating one manually from the set's screen.
   - **Through tokens**, wherever another module accepts tokens.
   - **Through the service**, in custom code:
     ```php
     \Drupal::service('random_word_combo.combiner')
       ->getRandomCombo('machine_name_of_set', $dryRun = FALSE);
     ```
     Passing `$dryRun = TRUE` returns a combination *without* saving it, even when
     "ensure unique" is on.
