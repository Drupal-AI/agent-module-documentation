# Fox drush console — manual setup guide

**Fox drush console** (`fox`) gives you an interactive **Drush console** — a REPL,
in the spirit of the `mysql` client — for exploring and manipulating Drupal entities
with a concise, declarative query language rather than one‑off Drush invocations or
throwaway PHP. You open a session with `drush fox:console` (alias `fox`) and stay in
it, running queries and commands against a chosen entity context, which makes
exploration, audits, and quick bulk edits much faster.

Fox's query language borrows from FoxPro and SQL. You pick a **context** — an entity
type and bundle, like `node.page` — with `USE`, then run `SELECT … FROM … WHERE …
INTO …` to pull data, `FOR` loops to iterate over results, and `CREATE`, `APPEND`,
`REPLACE`, and `DELETE` to mutate data safely through the standard Drupal Entity
API. It supports internal variables (`SET`, `IF … THEN … ELSE`), system iterators,
native `SQL` execution, and even calling out to other `DRUSH` commands from within a
session.

Because it operates on live entities from the command line, Fox is most at home
during audits, migrations, development, architecture reviews, and CI/CD — including
hosted CLIs like Pantheon's Terminus. It's a developer tool, so treat it with the
same care you'd give any command that can create or delete content in bulk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Fox has **no configuration form** — it's driven entirely from the command line. It
does provide a permission of its own, noted below.

## Where it lives in the admin menu

Fox adds no admin pages; you use it from your terminal via Drush. The only
admin‑side element is a **permission** it provides, which you can grant at **People →
Permissions** (`/admin/people/permissions`) to control who is allowed to use the
console. Grant it only to trusted developer/administrator roles, since the console
can read and modify entities in bulk.

## How to use it

Open a session and work within a context:

```bash
drush fox:console
```

A few illustrative commands from inside the session:

```
# Block user with uid = 1
SELECT status FROM user WHERE uid = 1 INTO data
IF @data.0.status = 1 THEN REPLACE status WITH 0
```

```
# Delete unpublished nodes older than a month
SQL UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS last_month INTO data
SELECT nid FROM node WHERE status = 0 AND changed < @data.0.last_month INTO nodes
DELETE FOR @nodes
```

Variables are referenced with `@` and object fields with `.` (for example
`@data.0.title`). Useful flags include `--input` (run `"command1;command2"` or load
a file), `--output` (echo history to screen or a file), `--mode` (`default` or
`debug`), and `--quit` for non‑interactive runs. You can also extend Fox with your
own commands via `drush gen fox:command`. The module's `README.md` has the full
command reference and many more examples.
