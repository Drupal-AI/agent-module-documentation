<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Inspector — manual setup guide

**Configuration Inspector** (`config_inspector`) is a developer tool that checks
every configuration object on your site against Drupal's configuration
schema/typed-data system. For each config object it tells you whether it has a
schema at all, whether its stored data matches that schema, how "validatable" the
config is (what share of its properties carry real validation constraints), and
how many constraint violations the data has. It is a read-only inspection layer —
it never changes your config, it just reports on it.

This is the tool you reach for before a Drupal core or contrib upgrade, when
writing `config/schema/*.yml` for a custom module, or when a config import fails
and you need to see exactly which property violates which constraint. It surfaces
its findings two ways: an admin report under **Reports**, and a `config:inspect`
Drush command that returns a non-zero exit code on schema errors — handy as a CI
gate.

The module has no settings of its own: enabling it is the entire setup. It adds
one permission, **Inspect configuration**, which you grant to your developer
role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no configuration page — the module has no settings form. How to use the
report and the Drush command is covered below.

## Where it lives in the admin menu

The report sits at **Reports → Configuration inspector**
(`/admin/reports/config-inspector`). Access requires the **Inspect
configuration** permission (`inspect configuration`), which is marked as
restricted — grant it only to trusted developer roles, never anonymous users.

## How to use it

### The admin report

The overview page lists every active config object. For each one you see:

- **Status** — `No schema`, `Correct`, or a count of schema errors.
- **Validatable** — the percentage of property paths that carry real validation
  constraints (a bare primitive type does not count).
- **Data** — whether the data is valid and how fully it can be validated.

Click any object to inspect it through five tabs:

- **List** — a flat table of property → schema type → value.
- **Tree** — the same data as a nested schema tree.
- **Form** — the data rendered as a form using the schema's widgets.
- **Raw data** — the raw stored YAML/array.
- **Download** — download the object for offline review.

### The Drush command

`drush config:inspect` (alias `inspect_config`) gives you the same analysis on the
command line. With no argument it inspects all active config; pass a config name to
inspect just one.

```bash
drush config:inspect                        # inspect everything
drush config:inspect --only-error           # only schema problems (CI-friendly)
drush config:inspect --only-error --detail  # problems, broken down per property
drush config:inspect system.site --detail   # one object, in detail
```

Useful options include `--only-error` (hide fully-correct config),
`--detail` (expand each object into per-property rows), `--list-constraints`
(print the constraints per property, requires `--detail`), `--filter-keys` /
`--skip-keys` (glob-based include/exclude), `--strict-validation` (treat less than
100% validatability as an error), `--todo` (list the config closest to full
validatability as low-hanging fruit), and `--generate-baseline` / `--baseline`
(snapshot current failures and ignore them in later runs). The command exits
non-zero when any object has schema errors, so `drush config:inspect
--only-error` works as a build gate in CI.
