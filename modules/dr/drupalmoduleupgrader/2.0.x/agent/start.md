<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Module Upgrader (drupalmoduleupgrader) — agent index

A developer **Drush CLI tool** that reads a **Drupal 7 module's source** and helps port it to
modern Drupal. It runs on a modern site (core `^10 || ^11`) but its subject is D7 code. Package
`Development`. Version **2.0.0-alpha2** — **alpha**, minimally maintained, kept on life support to
aid teams leaving Drupal 7 (EOL January 2025). No web routes, no permissions, no admin UI — it is
entirely a set of Drush commands.

## What it actually does

1. **`drush dmu-analyze MODULE_NAME`** — read-only. Indexes the target module, runs every Analyzer,
   and writes an **HTML report** (`upgrade-info.html` in the module dir, or `--output PATH`) of
   flagged Issues grouped by category, with source file/line locations and links to the matching
   drupal.org change records. Modifies nothing.
2. **`drush dmu-upgrade MODULE_NAME`** — **destructive/in-place**. Runs the Converter plugins that
   apply and mutates the module's files: `.info` → `.info.yml`, `hook_permission` → `permissions.yml`,
   `hook_menu` → routing YAML + controllers, blocks/forms/tests → classes, and a large table of D7
   procedural calls → service equivalents. Leaves `FIXME` notices where it cannot convert. `--backup`
   mirrors the module to `<dir>.bak` first.
3. **`drush dmu-list TYPE`** — enumerates plugin IDs of a type (`indexer`, `analyzer`, `converter`,
   `fixer`, `rewriter`). All three commands accept `--only` / `--skip` to filter which plugins run.

## Architecture (Pharborist + plugin managers)

The tool parses PHP with the **Pharborist** library and is built from Drupal plugin types (each with
its own annotation and plugin manager service):

- **Indexer** (`Plugin/DMU/Indexer`) — read-only; build an in-memory (SQLite) map of the module:
  Functions, Classes, Constants, FunctionCalls.
- **Analyzer** (`Plugin/DMU/Analyzer`) — read-only; flag `Issue`s (message, source targets, tags,
  change-record docs). ~13 analyzers (Grep, FunctionCall, InfoFile, HookPermission, PSR4, DB, Tests…).
- **Converter** (`Plugin/DMU/Converter`) — **deprecated** in favor of Fixers; rewrite constructs in
  place. ~28 top-level + ~59 per-function converters + 2 route converters.
- **Fixer** (`Plugin/DMU/Fixer`) — small isolated Pharborist edits (CreateClass, ImplementHook,
  Delete, Define, Notify, HookToYAML, PSR4…).
- **Rewriter** (`Plugin/DMU/Rewriter`) — type-aware parametric search-and-replace over a function
  body based on a known parameter type's getters/setters.

`config/install/drupalmoduleupgrader.*.yml` drive the data-only conversions: `grep.yml` (globals +
function-call replacements), `functions.yml`, `hooks.yml`, `tags.yml` (issue categories/levels),
`rewriters.yml`, `entity_operations.yml`.

## Read next

- `drush/` — the three commands, their options, and how the analyze/upgrade flow works.
- `architecture/` — plugin types, the Target/Indexer/Issue/Report model, and Pharborist.
- `plugins/` — what the shipped analyzers and converters cover, and how to filter them.

## Honest guidance for agents

- **The output is a starting point, not a port.** A module that runs is not a module that is right;
  the parts DMU cannot convert (marked `FIXME`) are the parts carrying the original's intent.
- **`dmu-upgrade` mutates files in place** — always work on a copy / use `--backup` / commit first.
- **It expects Drupal 7 source** (it locates the target by a `*.info` — not `.info.yml` — file). It is
  not a general deprecation scanner for already-modern modules; for that, use `drupal-check` / Rector.
- **The first real question is whether to port at all.** Much D7 custom code exists because contrib
  did not cover the case in 2014 — check whether it does now before spending effort porting.
