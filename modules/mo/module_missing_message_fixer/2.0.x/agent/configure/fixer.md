<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The fixer UI, detection, and what "fix" deletes

## Route / access

- **Path:** `/admin/config/system/module-missing-message-fixer`
- **Route:** `module_missing_message_fixer.form` (this is the module's `configure` route,
  also linked under *Configuration → System*).
- **Form:** `ModuleMissingMessageFixerForm`.
- **Permission:** `administer module missing message fixer` (the only permission the module
  defines). Grant it on *People → Permissions*.

## How ghosts are detected

Service `module_missing_message_fixer.fixer` (`ModuleMissingMessageFixer::getTableRows()`):

1. Selects every `name` from the `key_value` table where `collection = 'system.schema'`
   (skipping the `default` row).
2. For each name, calls `extension.list.module`→`getPathname($name)`.
   - If it throws `UnknownExtensionException` (or the file/`.info.yml` is missing/unreadable)
     the module has no code on disk → it is reported as a **ghost** row
     (`name`, `type = module`).
3. The form renders these rows in a `tableselect` (`#empty`:
   *"No Missing Modules Found!!!"*).

There is **no config** behind this — the source of truth is live key-value state, so nothing
is stored by the module itself (no config schema, no settings).

## What "Remove These Errors!" deletes

`ModuleMissingMessageFixerForm::submitForm()` for each **selected** module:

1. Finds config objects named `<module>.` + anything (`config` table `name LIKE '<module>.%'`)
   and **deletes** each via `config.factory` (with a *"Don't forget to export your config"*
   warning).
2. Deletes the module's rows from `key_value` where `collection = 'system.schema'` and
   `name IN (selected)`.

The result: the stale schema version and any leftover `<module>.*` config are gone, so the
"missing module" warning stops. (The Drush single-name `mmmff <name>` removes only the
key-value row; `--all` and this form also remove the `<module>.*` config — see
[../drush/commands.md](../drush/commands.md).)

Always run on dev/staging and re-export configuration afterwards.
