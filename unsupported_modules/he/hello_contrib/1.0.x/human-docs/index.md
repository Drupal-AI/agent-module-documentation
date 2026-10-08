# Hello Contrib — manual setup guide

**Hello Contrib** (`hello_contrib`) is a deliberately tiny example module. When
enabled it adds a single admin page at `/admin/hello-contrib` whose only job is to
print a friendly greeting ("Hello Drupal Contrib 👋"). There is nothing to
configure, no services, no custom permissions, and no data handling — it exists
purely as a reference skeleton and as a smoke test for the Drupal.org contrib
packaging workflow.

Think of it as a copy‑paste starting point for a brand‑new module: it shows the
minimal combination of an `.info.yml` file, a `.routing.yml` file, and a
`ControllerBase` subclass that returns a translated render array. It is also handy
for confirming that a freshly downloaded contrib project installs and enables
cleanly on Drupal 10 or 11.

Because this is **example / reference code, not a production feature**, there is no
reason to leave it enabled on a live site once you have used it for learning or
testing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## Where it lives in the admin menu

Once enabled, visit **`/admin/hello-contrib`** while logged in as a user with the
core **Use the administration pages and help** (`access administration pages`)
permission. You will see the greeting rendered on a standard admin page. That is
the whole feature.
