<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Lock adds two Drush commands, `lock:wait` and `lock:release`, that let a shell/deployment script acquire and release a named cross-process lock so that concurrent invocations serialize instead of trampling each other.

---

Drush is frequently embedded in shell scripts that boot or update a Drupal site, and sometimes the same script starts more than once at roughly the same moment — the motivating example is several replicas of a Drupal container starting on Kubernetes, each trying to run database updates and import configuration. Ordinary Drupal locks (the core Locking API) cannot help here because they are per-PHP-process: they are meant to be acquired and released inside one request, not across separate `drush` invocations. Drush Lock instead maintains **pseudo locks** — a named boolean stored in the `drush_lock` key-value collection — and uses the real core lock service only briefly, as a mutex, to serialize read-modify-write access to that store. `lock:wait <name> --delay=<seconds>` spins until it can claim the named lock (or its time budget runs out), and `lock:release <name>` clears it. A script brackets its critical section between the two commands so only one process at a time proceeds. The module has no UI, no permissions, no config and no dependencies beyond Drush and Drupal core; it is a developer/DevOps tool driven entirely from the command line. This is a pre-release **beta** (2.0.0-beta2) and is not covered by Drupal's security advisory policy.

---

- Serialize deployment scripts so only one container replica applies database updates at a time.
- Wrap a `drush updatedb` + `drush config:import` sequence so replicas run it one after another, not in parallel.
- Prevent two cron-triggered maintenance scripts from overlapping on the same site.
- Guard a long-running batch/migration script invoked from CI so a re-trigger waits instead of double-running.
- Coordinate a Kubernetes init sequence where the first replica does the work and the rest wait for the lock to clear.
- Ensure only one instance of a nightly export/import job runs even if the scheduler fires twice.
- Protect a `drush sql:sync` / database refresh from being started concurrently by two operators.
- Make a script fail fast (non-zero exit) when it cannot get the lock within a bounded time, so the caller can bail out cleanly.
- Bound how long a script is willing to queue for a shared resource with `--delay`.
- Force an immediate, non-blocking "try once" acquire attempt by passing `--delay=0`.
- Give each independent critical section its own named lock (e.g. `deploy`, `reindex`, `backup`) so unrelated jobs don't block each other.
- Manually clear a stuck lock left behind by a crashed script with `drush lock:release <name>` (works even if no script currently holds it).
- Use `drush lock:release <name>` for troubleshooting to confirm whether a named lock currently exists (it warns when there was none).
- Add lightweight mutual exclusion to a shell wrapper without introducing an external tool like `flock` or Redis.
- Coordinate blue/green or rolling-restart hooks that must not run their Drupal-side steps simultaneously.
- Prevent concurrent `drush deploy` runs during an automated release pipeline.
- Serialize a warm-up/cache-rebuild step across autoscaled application instances.
- Gate a one-time data-fix script so repeated pod restarts don't re-apply it at the same time.
- Use the `lwait` / `lrelease` (`lrel`) aliases for terser scripting.
