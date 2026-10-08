# Drush Lock — manual setup guide

**Drush Lock** (`drush_lock`) adds a pair of Drush commands for acquiring and
releasing named locks, so that concurrent command-line operations don't overlap
and step on each other. If two copies of the same deployment script can start at
roughly the same moment — the classic example is several replicas of a Drupal
container booting on Kubernetes, each trying to run database updates and import
configuration — Drush Lock lets you wrap the risky part so that only one runs at
a time and the others wait their turn.

The locks it manages are *operational* locks for scripts, not Drupal's internal
Locking API (real Drupal locks must be acquired and released inside a single PHP
process, which is not how a shell script works). Instead, Drush Lock gives you a
`lock:wait` command that blocks until it can grab a named lock, and a
`lock:release` command that frees it again. It is a developer / DevOps tool with
no content, no permissions and nothing to configure — enable it, then call the
commands from your scripts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it ships no settings form.
Everything happens through the two Drush commands described below.

## How to use it

Drush Lock adds no admin page; you use it entirely from the command line. It
provides two commands (run `drush help lock:wait` or `drush help lock:release`
for the built-in help):

- **`lock:wait`** — wait for and acquire a named lock. For example,
  `drush lock:wait my_lock --delay=60` waits up to 60 seconds for the lock named
  `my_lock`.
- **`lock:release`** — release a named lock, for example
  `drush lock:release my_lock`.

A typical deployment script brackets its critical section with the two commands:

```bash
drush lock:wait my_deployment_lock --delay 1800
# ... run updates, import config, etc. ...
drush lock:release my_deployment_lock
```

Here `1800` is half an hour — a generous ceiling for a Drupal update process to
finish. With this in place, if several replicas start together, only one enters
the critical section at a time and the rest wait for the lock to free up.
