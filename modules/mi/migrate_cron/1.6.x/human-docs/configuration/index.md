# Configuration

## Open the settings form

Go to **Configuration → System → Migrate Cron**
(`/admin/config/system/migrate-cron`). You need the **Administer site
configuration** permission.

The form lists **every migration** discovered on your site. For each one you can set
three options:

| Option | What it does |
|---|---|
| **Run at cron** | Enables scheduled runs for this migration. Leave it unchecked to keep the migration off the schedule (this is how you temporarily pause a migration without deleting anything). |
| **Run at interval** | The number of **seconds** to wait between runs. An empty value, or one shorter than your cron interval, means the migration runs on **every** cron tick. |
| **Don't update previously migrated entities** | When checked, already-imported rows are not re-imported — an insert-only sync. When unchecked, the migration refreshes existing rows so source changes are pulled in. |

Migrations that have "Run at cron" enabled are shown expanded and sorted to the top
of the form. Click **Save configuration** when done.

## How the cron run works

On each cron run, Migrate Cron looks at every migration you enabled and, for each
one:

1. Checks how long it has been since the migration last ran (tracked internally per
   migration). If that is at least the configured interval, the migration is
   **due**.
2. For a due migration, it first resets the migration's status to **idle** — this
   clears any stuck lock left by an interrupted run — and records the new run time.
3. Unless you ticked "Don't update…", it marks existing rows for re-import so source
   changes propagate.
4. It then runs the migration's import.

## Good to know

- **Cron bounds everything.** The interval only decides whether a *due* migration
  runs on a given cron tick — nothing runs more often than your cron fires. If you
  need imports every 5 minutes, make sure cron itself runs at least that often.
- **Stuck migrations self-heal.** Because Migrate Cron resets a due migration to
  idle before running it, a migration left mid-run will be restarted on its next due
  tick rather than staying stuck.
- **Define the migrations elsewhere.** This module only schedules migrations; create
  them with core Migrate / Migrate Plus (for example a Migrate Plus config entity)
  and they will then appear in the list above.
