# Arguments (RulesFinder) — manual setup guide

**Arguments** (`arguments`) is a building block in the **RulesFinder** toolset. It
provides a **sub‑entity list with arguments** — a way to define and manage
"argumented" sub‑entities, i.e. structured argument data — that other RulesFinder
modules build on. On its own it is a piece of plumbing rather than a
visitor‑facing feature.

You would install this as part of the wider RulesFinder stack, not by itself. It
supplies the argument‑data structures the rest of that toolset uses, so it makes
sense only alongside the RulesFinder modules that consume it. It ships in the
RulesFinder package.

From an access point of view, the argument data it manages is treated as ordinary
admin/editor content: the module provides its own permission to gate who can work
with it, but it plays **no access‑control role beyond that permission**. It has no
dependencies beyond core and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Arguments is a developer/site‑building block within RulesFinder, so you configure
the argument sub‑entities as part of setting up that toolset rather than on a
standalone settings page. After enabling the module, grant its permission to the
trusted roles that should manage argument data, then define and manage the
arguments through the RulesFinder workflow. If you are not using RulesFinder, this
module has little use on its own.
