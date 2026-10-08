# Rules CLI condition — manual setup guide

**Rules CLI condition** (`rules_cli_condition`) adds one small building block to the
**Rules** module: a condition that is TRUE when Drupal is running from the
command line (PHP CLI) — for example under Drush or a cron run — and FALSE when it's
handling a normal web request.

Why is that useful? Some rules should behave differently depending on how they're
triggered. The classic case, described by the project itself, is *disabling* a rule
during command‑line runs: you add the **Command‑line environment** condition (found
in the System group) so the rule only runs — or only stops running — when it's a CLI
context. It's a single, focused condition with no options to fill in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Rules dependency.

There is **no configuration page** for this module. You add the condition inside a
Rule, described in "How to use it" below.

## How to use it

1. Go to **Configuration → Workflow → Rules** and edit the reaction rule you want to
   change.
2. Add a **condition** and pick **Command‑line environment** from the **System**
   group.
3. There are no settings to configure for it — the condition simply evaluates to TRUE
   under PHP CLI and FALSE for web requests.
4. To make a rule *skip* command‑line runs, negate the condition (Rules lets you mark
   a condition as NOT); to make a rule run *only* on the command line, leave it
   positive. Save the rule.
