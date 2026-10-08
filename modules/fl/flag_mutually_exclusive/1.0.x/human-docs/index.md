# Flag mutually exclusive — manual setup guide

**Flag mutually exclusive** (`flag_mutually_exclusive`) enforces mutual exclusion
between configured flags from the [Flag](https://www.drupal.org/project/flag)
module on the same entity. When a user sets one flag in a mutually exclusive
group, the module automatically unsets the others — so a user can only hold one of
them at a time.

The Flag module doesn't do this on its own. This module adds it by listening to
Flag's "entity flagged" event: the moment one flag in a configured group is set on
an entity, the counterpart flags on that entity are removed. The classic use is a
**like / dislike** reaction where a user can pick only one, but the same idea
covers any either/or choice built from flags.

You configure which flags belong together through the module's admin UI. This
release (1.0.x) works on flag **pairs** — two flags that exclude each other.
(Newer releases expand this to larger groups, but on this version you set up
mutually exclusive pairs.)

It has no access‑control role of its own — flagging access still follows the Flag
module's own configuration. It only enforces the "one at a time" rule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with the Flag module).

You configure the mutually exclusive flag pairs in the module's admin UI rather
than through a general settings page, so this guide folds that into "How to use
it" below rather than a separate configuration chapter.

## Where it lives in the admin menu

You first create the flags themselves in the Flag module at **Structure → Flags**
(`/admin/structure/flags`), then pair them up in the Flag mutually exclusive admin
UI.

## How to use it

1. In the Flag module (**Structure → Flags**), create the two flags that should
   exclude each other — for example a "Like" flag and a "Dislike" flag — making
   sure both apply to the same entity type.
2. In the Flag mutually exclusive admin UI, add a rule pairing those two flags.
3. Test it: set one flag on an entity, then set the other. The first should be
   unset automatically, so only one is ever active at a time.
