# Session Expire — manual setup guide

**Session Expire** (`sessions_expire`) turns off Drupal's automatic session garbage
collection and lets you run it deliberately via cron or a Drush command instead. By
default, PHP and Drupal clean up expired session records *probabilistically* — the
cleanup fires on random incoming requests. That means an unlucky visitor can be the
one who pays the cost, occasionally causing a latency spike on an ordinary page load.

This module makes that housekeeping predictable: garbage collection no longer runs
during random user requests, and instead happens on a schedule you control (cron or
on demand). The result is smoother, more deterministic performance and one fewer
source of surprise slow requests. It's a small performance/operations tweak with no
effect on how sessions themselves behave for users.

The module works as soon as you enable it — automatic GC is disabled and you run the
cleanup yourself. As the maintainers note, there are **no configuration options at
this stage**. It needs no other modules and supports Drupal 9, 10 and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, Drupal stops running session garbage collection on random requests.
You then trigger the cleanup yourself — run it via cron (schedule your normal
Drupal/system cron), or on demand through the module's Drush command. There is no
settings form to visit. Make sure whatever cron mechanism you use actually runs
regularly, so expired sessions are still cleaned up on your schedule rather than
never.
