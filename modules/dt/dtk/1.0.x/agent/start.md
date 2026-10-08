<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush DTK (dtk) — agent index

Opt-in, **token-saving output compression for common Drush commands** ("Drush Token Killer"), built
for AI agents. Package `Drush DTK`. Composer `drupal/dtk`, requires `drush/drush: ^13`. No module
dependencies. Core `^11 | ^12`. License GPL-2.0-or-later. Version dir 1.0.x.

CLI-only: **no routes, no permissions, no admin UI, no plugins, no entities, no `.module`/`.install`,
no services file** (Drush auto-discovers classes under `src/Drush/`). It adds no everyday commands —
it only alters the output of existing core/contrib commands — plus one setup command `dtk:install`.

- **How compression works, the opt-in precedence, config, and every compressed command** →
  [commands/compression.md](commands/compression.md)
- **The `dtk:install` setup command (writes agent env files / enables site-wide config)** →
  [commands/dtk-install.md](commands/dtk-install.md)

## What it actually is (from source)

- `src/Drush/Commands/DrushDtkCommands.php` — an `OPTION_HOOK` on `*` registers the global
  `--ai-compress` / `--no-ai-compress` flags, plus ~30 `INITIALIZE` hooks (one per supported
  annotated command) and one `ALTER_RESULT` hook on `config:status`. Each sets compact `--fields`
  and forces `--format=csv` when compression is enabled and the user did not pass their own
  `--field`/`--fields`.
- `src/Drush/Listeners/DtkCompressListener.php` — a `#[AsEventListener]` on `ConsoleEvents::COMMAND`
  that compresses Symfony-native (non-annotated) commands the HookManager never sees: Devel 5.x
  `devel:services` and `devel:token`. Mutates definition defaults, not bound input.
- `src/Drush/Commands/DtkInstallCommands.php` — the `dtk:install` (alias `dtki`) setup command.
- Config object **`dtk.settings`** with one boolean key `compress` (default `false`); schema in
  `config/schema/dtk.schema.yml`, install default in `config/install/dtk.settings.yml`.

## Opt-in precedence (both compression paths)

`--no-ai-compress` (always off) > `--ai-compress` > `DTK_COMPRESS` env var
(`''`/`0`/`false`/`no`/`off` = off, anything else = on) > `dtk.settings:compress` config. None set =
off. No TTY/agent auto-detection. Enabled via `DrushDtkCommands::enabled()` /
`DtkCompressListener::enabled()`; both share `DrushDtkCommands::ENV_FALSY`.
