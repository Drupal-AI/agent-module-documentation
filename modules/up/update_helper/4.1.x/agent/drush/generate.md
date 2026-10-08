# Drush — generating a CUD + update hook

Update Helper adds a **drupal-code-generator** generator (not a classic Drush command), wired
via `composer.json` `extra.drush.services` → `drush.services.yml`. Run it through
`drush generate`:

```bash
drush generate update_helper:configuration-update
# aliases also accepted:
drush generate config-update
drush generate configuration-update
```

`Drupal\update_helper\Drush\Generators\ConfigurationUpdateGenerator`
(`#[Generator(name: 'update_helper:configuration-update', aliases: ['config-update'])]`).

## What it asks / does

Interactive prompts collect:

- the **module** the update belongs to (where the CUD file and the update hook are written),
- the **update hook description**,
- which modules' config to include in the diff,
- **"generate update from active configuration?"** — the `from-active` flag (see modes below).

It then, via `update_helper.config_handler->generatePatchFile()`:

1. Diffs the relevant **active** configuration against the module's **exported** config
   (`config/install` + `config/optional`) using the reversible differ.
2. Writes the **CUD** to `<module>/config/update/<update_hook_name>.yml`.
3. Writes/updates the **`hook_update_N()`** in `<module>.install` (from the twig template) that
   calls `update_helper.updater->executeUpdate()`.
4. **Exports** the changed configuration into the module's YAML files so code and DB agree.

## The two modes (from README)

- **Forward / normal mode** — answer **no** to "generate from active configuration". You install
  the *old* version, make your code+config changes in the working tree (without exporting), then
  generate: the command captures the delta and exports the new YAML for you.
- **Reverse mode** (more robust) — you already committed the *new* exported config YAML. Install
  the *old* version, then bring in the new code, then answer **yes**: the delta is taken from the
  now-current active configuration.

Both produce the same artifacts: a CUD in `config/update/`, an update hook, and exported config.
Always review the generated code afterward.

Requirements: use the project-local Drush (`vendor/bin/drush`), Drush ≥ 12
(composer `conflict: drush/drush <12.0`). The `update_helper_checklist` submodule, if enabled,
hooks the generator over `COMMAND_GCU_*` events to additionally emit `updates_checklist.yml`
entries.
