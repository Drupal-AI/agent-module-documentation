# Factory Lollipop — manual setup guide

**Factory Lollipop** (`factory_lollipop`) is a developer and testing tool that uses
the **factory pattern** to generate short‑lived Drupal test data. Rather than loading
fixed, global fixture records into the database, you write reusable *blueprints*
(factories) that instantiate valid, customisable Drupal objects on demand — the kind
of setup you need in automated tests and local development.

It fills a gap in Drupal's unit‑testing world: the test system never loads your
install profile or config sync, so for each test you would otherwise have to
re‑create content types, nodes, fields, and so on by hand. Factory Lollipop lets you
define a blueprint once and load it in your test scenarios and in before/after setup,
ensuring consistent, valid data across your test suites.

Out of the box it supports factories for content types, nodes, fields (including
entity‑reference fields), vocabularies, taxonomy terms, users, roles, menus and menu
links, files, media types, and media. You can create, override, or decorate any
factory type through its Chain Resolver, and the whole thing is extensible in your own
code.

Because it is a testing utility with no production role, install it as a **dev
dependency**. It depends only on core's User module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install as a dev dependency with Composer
   and enable it.

There is **no configuration page** — Factory Lollipop is used entirely from your test
and development code, not from the admin UI.

## Where it lives in the admin menu

Factory Lollipop adds no admin page. It is a code‑level tool: you use its factories
from PHP in your tests and setup routines. It defines no permissions, no settings form
and no configuration — everything is driven from your test and development code.

## How to use it

Factory Lollipop ships one optional submodule:

- **factory_lollipop_paragraphs** — adds `paragraph` and `paragraph type` factory
  types so you can build Paragraphs entities and bundles in tests (requires the
  contrib Paragraphs module).

Enable it if you need paragraph factories, then write your own factory blueprints for
the entities your tests need. The module's own test suite (under `tests/`) and the
project's official documentation (linked from the
[project page](https://www.drupal.org/project/factory_lollipop)) are the best
references for the API and the Chain Resolver.
