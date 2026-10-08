# Configuration

Before you can run anything, tell the module where your scripts live and which
user should be credited for the changes.

## Open the settings form

Go to `/admin/config/development/batch_operations/settings`.

## Set the two settings

- **Machine name of the local module** — the custom module that will contain your
  batch-operation scripts. The module looks for scripts in that module's
  `src/cbo_scripts/` directory.
- **User id** — the user whose name is recorded on entity saves performed by the
  operations (for example user `1`, or a dedicated system account).

Save the form.

## Add your scripts directory

In the custom module you named above, create the directory `src/cbo_scripts/`.
This is where your batch-operation script classes go. To create one, copy the
`StarterScript.php.txt` that ships with this module into that directory, rename it
to a meaningful `.php` filename, update the class name to match the filename and
the namespace to your module, and implement the interface methods. The project's
README and the bundled example script walk through this in full.

## Assign permissions

The module provides permissions you assign at **People → Permissions**:

- **Manage the configuration** — who can change the settings above.
- **View batch operation logs** — who can see the record of what ran.
- **Execute batch operation scripts via the UI** — who can run operations from
  the admin UI.

> **Treat "execute" as an administrative permission.** A batch operation is
> arbitrary code that modifies content at scale and cannot be undone by clicking
> undo. Grant the execute permission narrowly — closer to *administer site
> configuration* than to a content role — regardless of the default.

## Running operations

Once configured, you can run a script:

- **From the UI** (with the UI submodule enabled) at
  `/admin/config/development/batch_operations`.
- **From Drush:** `drush codit-batch-operations:run {ScriptClassName}`.
- **From code:** in `hook_update_N()`, `post_update` functions, or Drush deploy /
  post-deploy hooks.
- **On cron.**

You can choose to **stop on the first error** or to **skip erroring items and
keep going**. Every run — including one that is interrupted — is recorded in a
BatchOpLog entity, and an interrupted operation resumes from where it stopped on
the next run.

> **Be careful with scale.** Run a new operation against a copy of the site
> first, make it idempotent so a re-run is safe, and have it log what it changed,
> not just that it ran.
