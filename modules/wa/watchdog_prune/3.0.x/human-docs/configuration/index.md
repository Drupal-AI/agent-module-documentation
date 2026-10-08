# Configuration

Configuring Watchdog Prune is two quick steps: adjust one core dblog setting so
this module can do its job, then set your retention policy.

## Step 1 — set core's dblog limit to "All"

For age‑based pruning to take effect, Drupal core must not be trimming the log by
row count first.

1. Go to **Configuration → Development → Logging and errors**
   (`/admin/config/development/logging`).
2. Set **Database log messages to keep** to **All**.
3. Save.

If you leave this at a numeric limit, core removes the oldest rows once the count
is exceeded, which undercuts the age rules below.

## Step 2 — open the Watchdog Prune settings

1. Log in as a user with the **Administer watchdog prune** permission (an
   administrator by default).
2. Go to **Configuration → Development → Watchdog Prune settings**
   (`/admin/config/development/watchdog-prune`).

## The settings

### Prune entries older than (global age)

A dropdown that sets the global "delete entries older than…" threshold. It is
applied to **every** log type that is not already covered by a per‑type rule
(below). The choices are:

- **None** — do not prune by global age.
- **-1 WEEK**, **-2 WEEKS**, **-3 WEEKS**
- **-1 MONTH**, **-2 MONTHS**, **-3 MONTHS**, **-6 MONTHS**, **-9 MONTHS**
- **-12 MONTHS**, **-18 MONTHS** *(default)*, **-24 MONTHS**, **-30 MONTHS**,
  **-36 MONTHS**

### Per‑type age rules

A text area for optional per‑log‑type rules — one rule per line in the form
`type|age`, where `type` is a watchdog channel (like `php`, `system`, `cron`,
`page not found`) and `age` is a relative‑date expression PHP understands. For
example:

```
php|-1 MONTH
system|-1 MONTH
cron|-1 WEEK
```

These rules take **precedence** over the global age: any type listed here is
pruned on its own schedule, and the global rule then handles everything else.
Leave the box empty if you only want the single global threshold. (The form
rejects a per‑type age that is not actually in the past.)

## Save

Click **Save configuration**. Because this module has no default configuration,
saving the form is also what creates its config for the first time.

## How and when pruning happens

Pruning runs during **cron**. On each cron run the module first deletes entries
matching each per‑type rule, then applies the global age to all remaining types.
You can trigger it manually to test with:

```bash
drush cron
```

There is no separate "prune now" command — cron is the mechanism.
