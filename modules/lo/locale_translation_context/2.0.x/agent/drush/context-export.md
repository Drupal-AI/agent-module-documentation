<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: context-aware gettext export

Source: `src/Drush/Commands/LocaleTranslationContextCommands.php`. Requires the `locale`
module enabled (`#[CLI\ValidateModulesEnabled(modules: ['locale'])]`). Output is written to
stdout — redirect to a file.

## `locale:context-export` (alias `locale-context-export`)

Export gettext translations filtered by translation context.

- Argument: `langcode` — language to export (omit when using `--template`).
- Options:
  - `--template` — output a `.pot` template of source strings instead of translations.
  - `--types` — comma-separated string types to include. Recognized: `not-customized`,
    `customized`, `not-translated`. Defaults to all types. Cannot be combined with `--template`.
  - `--context` — only export strings whose translation context matches this value.
- Validation (`contextExportValidate`): you must set either `langcode` or `--template`;
  `--template` and `--types` are mutually exclusive.

Examples (from the command's own `#[CLI\Usage]`):

```
drush locale:context-export nl --context=custom_project > nl-custom.po
drush locale:context-export --template --context=custom_project > custom_project.pot
```

## `locale:export` override

The class also hooks core's `locale:export` command:

- an `OPTION_HOOK` adds `--context` to core `locale:export`;
- a `REPLACE_COMMAND_HOOK` replaces core's implementation with one that routes through this
  module's `PoDatabaseReader`, so `drush locale:export <lang> --context=<ctx>` filters by context.

The reason for the replacement (per the code comment): core's `writePoFile()` does not use
dependency injection, so it cannot be handed the module's extended `PoDatabaseReader`.

## Mechanism

Both paths build a `PoDatabaseReader` (`src/PoDatabaseReader.php`, a `PoReaderInterface`),
set its langcode and options, and, when `context` is non-empty, add `$conditions['context']`
to the query against the locale string storage (`getTranslations()` / `getStrings()`). The
resulting items are streamed out with core's `PoStreamWriter`. A `--template` (no langcode)
export yields source strings with empty `msgstr`.
