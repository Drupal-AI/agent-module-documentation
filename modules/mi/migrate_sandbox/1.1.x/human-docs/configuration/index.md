# Configuration

Migrate Sandbox doesn't have a traditional "settings" page — the sandbox form
*is* the tool. This page walks through that form and how to run a pipeline. There
is nothing you need to configure before using it beyond installing it and (for a
better experience) the recommended companion modules.

## Open the sandbox

1. Log in as a trusted developer with the **`access migrate_sandbox`** permission
   (this permission is *restricted* — treat it as developer access).
2. Go to **Configuration → Development → Migrate Sandbox**, or navigate directly
   to `/admin/config/development/migrate-sandbox`.

## Pick a starter configuration

The sandbox ships example source data and process pipelines for nearly every
plugin in core Migrate and Migrate Plus. Choose a starter from the provided list
as a jumping‑off point — this is the easiest way to learn a specific plugin, and
especially helpful for the tricky ones like `sub_process`, `migration_lookup`,
`entity_generate`, `transpose`, and the DOM plugins.

You can also select **`migrate_sandbox.latest`** as your starter: the sandbox
always saves your most recent configuration there (this is the one thing it does
persist), so you can pick up where you left off.

## Edit the source data and the pipeline

The form has two main areas you edit:

- **Source data** — the source row(s) the pipeline will run against, entered as
  YAML.
- **Process configuration** — the process pipeline (the same YAML you'd put under
  a migration's `process` key).

If you enabled the **Yaml Editor** module, these fields get syntax highlighting
and a much nicer editing experience. YAML is validated on screen, so mistakes are
flagged immediately rather than after a failed run.

## Watch for the escape warning

If your pipeline includes a plugin that can have effects *outside* the sandbox —
`callback`, `download`, `file_copy`, `migration_lookup`, or Migrate Plus's
`dom_migration_lookup`, `entity_generate`, `file_blob`, or `service` — a warning
appears above the **Save & Run** button. You can still run it, but be aware those
plugins may cause persistent side‑effects that the sandbox cannot roll back.

## Save & Run

Click **Save & Run**. The sandbox builds a throwaway migration from what you
typed, runs the row(s) through it, and shows you:

- the **output** of the pipeline (rendered from an entity that is never saved),
- any **migrate messages** on screen instead of in a log,
- any **exceptions** raised by the plugins.

Nothing is written to the database's migrate map tables, so you can iterate as
fast as you like — edit, run, inspect, repeat — without any cleanup between runs.
