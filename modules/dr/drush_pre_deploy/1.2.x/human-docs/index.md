# drush-pre-deploy — manual setup guide

**drush-pre-deploy** (`drush_pre_deploy`) adds a "pre-deploy" hook step to
Drush's deployment command — a place to run code *before* database updates,
rather than after them.

Drush's `drush deploy` command runs a deliberate, standard sequence:
`updatedb` → `config:import` → `cache:rebuild` → `deploy:hook`. That last step
fires `hook_deploy_NAME()` functions, which are like `hook_post_update_NAME()` —
useful for code that must run at the very *end* of a deployment. What the
sequence has no slot for is work that must happen at the very *beginning*, and
there is a real class of work that belongs there:

- deleting a configuration object that would otherwise make `config:import` fail;
- fixing data that a pending schema update is about to choke on;
- disabling a module whose update hook is known to break;
- snapshotting or measuring the pre-update state so a migration can be verified
  afterwards.

The usual alternative is a shell script wrapped around `drush deploy`, which
lives outside the codebase and outside code review. This module keeps that logic
*in the module where the change it supports also lives*: define
`function foo_predeploy_something(&$sandbox) { … }` in a `foo.predeploy.php` file
and it runs before updates. It also adds two commands, `deploy:pre-hook` (run
pending pre-deploy hooks) and `deploy:pre-hook-status` (show which are pending),
mirroring Drush's own `deploy:hook` / `deploy:hook-status`.

This `1.2.x` release supports Drupal 8 through 11, has no module dependencies and
adds no permissions — it exists for the CLI. It does require a small one-time
Drush configuration step (see Installation) so Drush discovers the commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and register the
   commands with Drush.

There is **no configuration page** for this module — it ships no settings form.
Setup is the `drush.yml` include described in Installation, and the rest happens
in your modules' `*.predeploy.php` files and on the command line.

## How to use it

There is no admin page. Once installed and discovered by Drush, add a pre-deploy
hook to any of your modules — for a module named `foo`, create `foo.predeploy.php`
containing a function such as:

```php
/**
 * Describe what this pre-deploy step does.
 */
function foo_predeploy_remove_stale_config(&$sandbox) {
  // Runs before database updates and config import.
}
```

Then run the pre-deploy hooks (for example, as the first step of your deployment,
before `drush deploy`):

```bash
drush deploy:pre-hook          # run pending pre-deploy hooks
drush deploy:pre-hook-status   # list pending pre-deploy hooks
```

**Two cautions apply to every deployment hook.** First, a pre-deploy hook **runs
before updates**, so your code executes against the *old* database schema and
must not assume anything the pending update introduces — this is the commonest
way a pre-deploy hook breaks a deployment. Second, deployment hooks **run once
per environment and are hard to test**, so the first real execution is on
production unless you rehearse the whole sequence against a copy of production
data — which is the only rehearsal that counts.
