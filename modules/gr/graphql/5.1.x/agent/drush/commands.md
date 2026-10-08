<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Two Symfony/Drush console commands under `src/Drush/Commands/` (autowired). Both operate on a
`graphql_server` entity by its machine id.

## `graphql:dump <server> [file] [--json|-j]`
Class `DumpSchemaCommand` (`const NAME = 'graphql:dump'`). Prints the server's built schema. It calls
`$server->configuration()->getSchema()` and renders it with `SchemaPrinter::doPrint()` (SDL, the
default) or, with `--json`, `Introspection::fromSchema()` as pretty JSON. Writes to `file` if given,
otherwise stdout. Errors on an unknown server or a server with no schema.

```bash
drush graphql:dump main               # print SDL to stdout
drush graphql:dump main schema.graphql # write SDL to a file
drush graphql:dump main --json         # print introspection JSON
```

## `graphql:detect-breaking-changes <server> <file> [--json|-j]` (alias `graphql:breaking`)
Class `DetectBreakingChangesCommand`. Compares the server's **current** schema against a previously
dumped one (`file`) using webonyx `BreakingChangesFinder`. `file` is parsed as SDL by default, or as
introspection JSON with `--json` (`BuildClientSchema` / `BuildSchema` from a `Source`). Outputs a
table of breaking changes (columns `Type`, `Description`) via the Drush formatter. Pair it with
`graphql:dump` to catch API-contract regressions in CI.

```bash
drush graphql:dump main previous.graphql          # baseline (e.g. committed)
drush graphql:detect-breaking-changes main previous.graphql
```

There is also a Drush **generator** (`SchemaExtensionGenerator`, `schema-extension.twig`) that
scaffolds a `@SchemaExtension` plugin + SDL files for a module.
