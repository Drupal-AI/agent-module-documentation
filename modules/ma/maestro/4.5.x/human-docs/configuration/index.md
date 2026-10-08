# Configuration

This page covers the engine settings form, how to run the orchestrator, and how
to start a process. Building templates and completing tasks happen in the
submodule UIs (Template Builder and Task Console).

## Engine settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Workflow → Maestro**
   (`/admin/config/workflow/maestro`).

The settings (stored in `maestro.settings`) are:

- **Redirect location** — the URI that notification links send recipients to.
- **Send notifications** — the master on/off switch for assignment, reminder, and
  escalation emails.
- **Run the orchestrator on Task Console refresh** — when on, every time a user's
  Task Console refreshes, the orchestrator runs a cycle. A simple way to keep
  processes moving on active sites.
- **Orchestrator token** — a secret string appended to the orchestrator URL (see
  below). It is **randomly generated at install**; you can regenerate/edit it here.
- **Orchestrator lock execution time** — how long (in seconds) a single
  orchestrator run holds its lock, so two runs don't overlap (defaults to 30
  seconds if set to zero or less).
- **Development mode** — resets entity caches during orchestration; for debugging
  only, leave off in production.
- **Sitewide token key name** — the query-string key name used when task URLs
  carry a token (default `maestro-token`). This is a key *name* for obfuscation,
  not an access secret.
- **Zero-user token** — enables the "no assignee" notification mechanism (only
  available once the sitewide token is set).

## The orchestrator (advancing running processes)

The orchestrator is what moves processes forward: it runs the ready
non-interactive tasks and creates assignments for interactive ones. **Maestro does
not schedule itself** — you must trigger the orchestrator. There are three ways:

- **Cron / curl** — hit the orchestrator URL on a schedule:

  ```bash
  curl https://your-site/orchestrator/<token>
  ```

  The `<token>` must match the **Orchestrator token** from the settings form; a
  wrong or missing token returns an error, so keep the token secret. On success
  the request returns HTTP 204.

- **Drush** *(recommended for cron)*:

  ```bash
  ddev drush maestro:orchestrate
  ```

- **Task Console refresh** — when the "Run the orchestrator on Task Console
  refresh" setting is on.

Starting a process also runs the orchestrator once.

## Starting a process

Launch a running process from a **validated** template in any of these ways:

- **From a URL** — visit
  `/maestro/start/process/<template_machine_name>`. This requires the **Start
  Maestro process** permission (or the per-template start permission).
- **From Drush**:

  ```bash
  ddev drush maestro:start-process <template_machine_name>
  ```

  This starts the process and then runs the orchestrator once.
- **From code** — `(new \Drupal\maestro\Engine\MaestroEngine())->newProcess('<template>')`
  returns the new process id (or `FALSE` if the template isn't validated). See the
  sibling [`agent/`](../../agent/start.md) docs for the full API.

Only templates that pass validation can be started.

## Completing interactive tasks

Assigned users execute interactive tasks from the **Task Console** (the
`maestro_taskconsole` submodule). Access to run a task is enforced by
**assignment** — the task must be assigned to the current user — not merely by
holding a permission or knowing a token. Completing a task advances the process to
the next step.

## Tuning who can do what

Maestro's permissions (see [Installation](../installation/index.md#grant-permissions))
separate template administration, starting processes, and queue/assignment
management. Note that executing a task always additionally requires that the task
be assigned to the acting user, regardless of the CRUD permissions on Maestro's
bookkeeping entities.
