# Developer console — manual setup guide

**Developer console** (`developer_console`) is a lightweight, on-site console for
developers. It lets you execute PHP code and database queries directly against the
running site, provides a dumper function with **Kint** library integration and
output-type options, and shows execution-time information — handy for development,
testing and optimisation. The maintainer describes it as a leaner alternative to
Devel's larger, heavier feature set, and it also keeps a history of what you've run.

Because it can **execute arbitrary code**, this is a tool only for trusted
developers: restrict access to developer roles and **never enable it in
production**. Anyone who can reach the console effectively has full control of the
site.

The module has no third-party dependencies, ships its own permission, supports
Drupal 9, 10 and 11, and is **not** covered by Drupal's security advisory policy.
It's minimally documented and minimally maintained (maintenance fixes only), so
expect to explore a little.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant its permission.

There is no settings form (`configure` is null) — the only setup is granting the
permission below and then using the console itself.

## How to use it

1. **Enable it in a development environment only.**
2. Under **People → Permissions**, grant the module's permission to trusted
   developer roles only — this gates who can run code through the console.
3. Open the console, enter PHP or a database query, and run it. Output is rendered
   through Kint, and you'll see execution-time details and a history of previous
   commands.

> **Warning:** The console runs arbitrary code and queries with the site's full
> privileges. Treat access as equivalent to shell/database access, and remove or
> disable the module before deploying anywhere public.
