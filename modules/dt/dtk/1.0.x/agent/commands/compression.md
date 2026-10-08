<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush DTK — output compression

How Drush DTK shrinks command output. Two code paths, one shared opt-in model. `drush en dtk -y`
enables it; nothing changes until you opt in.

## Opt-in and precedence

Resolved by `DrushDtkCommands::enabled(InputInterface)` (and the mirror
`DtkCompressListener::enabled()`), highest precedence first:

1. `--no-ai-compress` → always OFF (registered globally; beats everything, kept for old scripts).
2. `--ai-compress` → ON for this invocation.
3. `DTK_COMPRESS` env var → OFF when in `ENV_FALSY = ['', '0', 'false', 'no', 'off']` (case-insensitive),
   otherwise ON. Recommended for agents.
4. `dtk.settings:compress` boolean config → ON when true. Set with
   `drush config:set dtk.settings compress 1`.

If none is set, compression is off. There is deliberately no TTY / "am I an agent?" heuristic.

`skip()` also leaves output untouched whenever the user passed their own `--field`/`--fields` —
detected via `$input->hasParameterOption(['--field','--fields'])` (raw command line, so a command's
own non-empty `#[CLI\DefaultFields]` default is not mistaken for a user choice).

## Path 1 — annotated commands (`DrushDtkCommands`)

Auto-discovered under `src/Drush/Commands/`. Mechanics:

- `#[CLI\Hook(OPTION_HOOK, target: '*')] optionsetAiCompress()` registers `--ai-compress` /
  `--no-ai-compress` on every command.
- Per-command `#[CLI\Hook(INITIALIZE, target: '<cmd>')]` methods call
  `compress($input, $fields, $nativeFormat = 'table')`, which (unless `skip()`) sets
  `--fields=<fields>` (when non-null) and switches `--format` to `csv` **only while it still equals
  the command's native default** (so a user-chosen format survives). Pass `$nativeFormat = null` to
  leave format alone for commands whose result is not a `RowsOfFields` and cannot render as CSV.
- `config:status` also has a `#[CLI\Hook(ALTER_RESULT)] alterConfigStatus()` that rewrites verbose
  state strings to tokens via `CONFIG_STATE_TOKENS`: `Only in DB`→`only_db`, `Different`→`different`,
  `Only in sync dir`→`only_sync`. Runs after the command so the `--state` filter (which matches the
  original strings) is unaffected.
- `core:requirements` additionally defaults `--severity` to `1` (warnings+errors) when the user set
  no threshold, dropping the many "OK" rows.

Compressed annotated commands and the fields applied (CSV forced unless noted):

| Command | Fields set |
|---|---|
| `pm:list` (pml) | `name` when `--status=enabled\|disabled`, else `name,status` |
| `core:requirements` (rq) | `title,severity` + `--severity=1` |
| `config:status` (cst) | keep defaults; state tokens via ALTER_RESULT |
| `views:list` | `machine-name,status` |
| `watchdog:show` (ws) | `type,severity,message` |
| `role:list` (rls) | `rid,label` (native format yaml) |
| `queue:list` | keep defaults, chrome dropped |
| `migrate:status` (ms) | keep defaults |
| `field:info` (fi) | keep defaults |
| `field:base-info` (fbi) | `field_name,field_type,required,cardinality` |
| `field:types` | `id,label` (format left as YAML — not RowsOfFields) |
| `field:formatters` | `id,label,field_types` (YAML kept) |
| `field:widgets` | `id,label,field_types` (YAML kept) |
| `updatedb:status` (updbst) | `module,update_id,description` |
| `user:information` (uinf) | `uid,name,mail,user_status` |
| `migrate:messages` (mmsg) | `level,source_ids,message` |
| `deploy:hook-status` | keep defaults |
| `language:info` | `language,default` |
| `migrate:fields-source` | keep defaults |
| `twig:unused` | keep defaults |
| `search-api:list` | `id,serverName,status` |
| `search-api:status` | `id,complete,indexed,total` |
| `search-api:server-list` | `id,status` |
| `search-api:search` | keep defaults |
| `views:bulk-operations:list` | `id,entity_type_id` |

Contrib-command hooks fire only when the owning module is installed (the target command must exist).

## Path 2 — Symfony-native commands (`DtkCompressListener`)

`src/Drush/Listeners/DtkCompressListener.php`, a `#[AsEventListener]` on `ConsoleEvents::COMMAND`.
Needed because Devel 5.x ships `#[AsCommand]` classes, not `AnnotatedCommand`s, so the HookManager
(and every hook above) never sees them. It skips any `AnnotatedCommand` (those use Path 1, so each
command has exactly one compression path).

- On every Symfony-native command it `addOption('ai-compress'/'no-ai-compress')` so the flags are
  accepted anywhere.
- For the two commands in its `COMMANDS` map — `devel:services` => `null` (keep single `id` column),
  `devel:token` => `group,token` — when enabled and no user `--field(s)`, it mutates the **definition
  defaults** (`getOption('fields')->setDefault()`, and `format` default `table`→`csv`). It uses
  definition defaults, not `$input->setOption()`, because Symfony re-binds input in `Command::run()`
  after this event, which would wipe direct input changes; user-supplied values still win.

Devel rows require Drush 13.7+.

## Config object

`dtk.settings` — single boolean `compress` (default `false`, `config/install/dtk.settings.yml`;
schema `config/schema/dtk.schema.yml`). Lowest-precedence opt-in. On config-managed sites, enabling
it writes active config, so run `drush cex` to persist (otherwise `config:status` reports drift).
