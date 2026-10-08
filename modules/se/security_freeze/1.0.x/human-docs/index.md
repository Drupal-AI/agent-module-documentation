# Security Freeze — manual setup guide

**Security Freeze** (`security_freeze`) puts a Drupal site into a **read-only "security
maintenance mode."** When a critical vulnerability is disclosed or a site is under
active attack, you often need to lock things down fast — but taking the site fully
offline should be the last resort, not the only option. Security Freeze lets you keep
the public site live and browsable while freezing every write, login, and file change,
so you can assess the threat or deploy a patch without going dark.

When frozen, visitors can still view pages, run searches, and use menus, but **nobody
can log in — not even user 1** — no content can be written, and no files can be
changed. The module is built to sit alongside a read-only database, turning what would
otherwise be ugly 500 errors into clean **403 (Access Denied)** responses, so uptime
monitors still see the site as "up." It uses defense-in-depth: logins, database writes,
file operations, JSON:API/REST writes, and cron are each blocked by multiple
independent layers, and a strict self-host-only Content-Security-Policy header is set on
every response while frozen (that policy is customisable, or can be skipped).

There is deliberately **no web UI**. Everything is operated over SSH with Drush —
`drush freeze:on`, `drush freeze:off`, `drush freeze:status` — or from `settings.php`.
That is intentional: during an incident, SSH may be the only channel you can trust. The
module stays completely dormant until you arm it, so installing it changes nothing about
day-to-day operation. It provides its own permission and requires **Drupal 11.3**.

**Important — this module is only half of the job.** It blocks writes at the Drupal
*application* layer, but the database server itself is the real backstop. Before or
during a freeze you must (1) move **cache, lock, and flood** off the database onto an
external backend such as Redis or Memcached — otherwise the first cache miss on a
read-only database crashes the site (the `freeze:on` command runs a preflight check and
warns you if any are still database-backed), and (2) set the database server itself to
**read-only** (`read_only = ON`, plus `super_read_only = ON` on MySQL/Aurora) after
running `freeze:on`. Optionally, mount the codebase read-only as well. (The maintainers
also disclose that this module was written by AI agents, with the maintainer reviewing
and taking responsibility for the work.)

This guide is written for a **human** operator. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and the Drush commands that arm and disarm the freeze.

## How to use it

Everything happens from the command line over SSH:

- **`drush freeze:on`** — arm the freeze. Run its preflight warnings first, then set
  your database server to read-only as described above.
- **`drush freeze:status`** — check whether the site is currently frozen.
- **`drush freeze:off`** — lift the freeze and return the site to normal (remember to
  return the database server to read-write too).

Until you run `freeze:on`, the module does nothing — the site behaves exactly as before.
