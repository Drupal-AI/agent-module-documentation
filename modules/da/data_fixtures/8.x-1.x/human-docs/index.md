# Data Fixtures — manual setup guide

**Data Fixtures** (`data_fixtures`) is a developer tool for filling a Drupal site
with reproducible dummy content on demand. The idea is that any module which
defines something that needs content to be testable — a content type, a custom
entity, menu items, user profiles — can also ship a *Generator* that knows how to
create (and remove) sample data for it. Data Fixtures collects all those
generators and runs them from a single Drush command, so you can build a working,
populated environment from scratch in one step.

This is especially useful in CI/CD pipelines that spin up fresh environments with
no existing content, and for teams where front‑end developers need realistic
content to work against without hand‑creating it every time. The data it produces
is random, throwaway fixture data.

**This module is for local development and testing only — never production.** It
is built around the assumption that you can truncate the database whenever you
like, and it deliberately generates random data rather than real content. It has
no admin UI (a user interface is on the roadmap but not here yet), no other module
dependencies, and plays no part in access control. Everything happens through
Drush, which is therefore a requirement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Drush required).

There is **no configuration page** for this module — it has no settings form and
is driven entirely by Drush commands, described under "How to use it" below.

## How to use it

Data Fixtures does its work through three Drush commands:

```bash
drush fixtures-load      # run the load() method on every registered generator
drush fixtures-unload    # run the unload() method on every generator
drush fixtures-reload    # unload then load, in that order
```

To make content appear, a module in your codebase must provide a **Generator** —
a class implementing `Drupal\data_fixtures\Interfaces\Generator` (which has
`load()` and `unload()` methods). Register it in that module's `*.services.yml`
and tag it so Data Fixtures picks it up:

```yaml
tags:
  - { name: data_fixtures }
```

Once one or more tagged generators exist, `drush fixtures-load` runs them all and
your test content appears; `drush fixtures-unload` removes it again.
