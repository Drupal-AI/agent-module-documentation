# Drush DTK — manual setup guide

**Drush DTK** (`dtk`) — the "Drush Token Killer" — provides **opt‑in,
token‑saving output compression** for common Drush commands. Inspired by RTK (the
"Rust Token Killer"), it shrinks the output of frequently run, read‑only Drush
commands so that AI coding agents (and humans) spend far fewer tokens reading
them.

The key word is **opt‑in**. Simply enabling the module changes nothing for a
human at a terminal — output only changes when something explicitly asks for it.
When compression is on, lightweight Drush hooks select a compact set of fields and
switch output to CSV (dropping the wide ASCII‑table chrome), *only* when you have
not asked for specific output yourself. No new commands are added for everyday
use; the module just alters the output of existing core and contrib commands (for
example `pm:list`, `core:requirements`, `config:status`, `watchdog:show`,
`role:list`, `user:information`, several `field:*` commands, and Devel's
`devel:token`, among others). Contrib‑command hooks fire only when the owning
module is installed.

Because it is CLI tooling, DTK has **no admin UI and no content or access role**.
You control it entirely from the command line, through three opt‑in surfaces
(highest precedence first): the `--ai-compress` flag on a single command, the
`DTK_COMPRESS=1` environment variable for a whole session (recommended for
agents), or an always‑on config value. It also ships a small helper command,
`drush dtk:install`, that wires the environment variable into an AI agent's
project config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin configuration page** for this module. Compression is turned
on per command, per session, or permanently from the command line, as described
below.

## Where it lives in the admin menu

Drush DTK adds no admin page — it is a command‑line tool. You interact with it
entirely through Drush.

## How to use it — enabling compression

Three opt‑in surfaces, highest precedence first:

1. **Per command** — add the `--ai-compress` flag:

   ```bash
   drush pml --ai-compress
   ```

2. **Per session** — set the environment variable (recommended for agents, which
   invoke Drush through wrappers where injecting flags is awkward):

   ```bash
   export DTK_COMPRESS=1
   ```

3. **Always on** — store it in config:

   ```bash
   drush config:set dtk.settings compress 1
   ```

To turn compression **off**: `DTK_COMPRESS=0` (also `false`, `no`, `off`)
disables it and overrides the config, and `--no-ai-compress` on any command beats
everything and restores native output. There is deliberately no TTY or "am I an
agent?" detection — output only changes when something asked for it.

## Wiring it into an AI agent

One command adds `DTK_COMPRESS=1` to an agent's project‑level config:

```bash
drush dtk:install claude     # merges into .claude/settings.json
drush dtk:install codex      # adds to .codex/config.toml
drush dtk:install opencode   # prints the manual step
drush dtk:install copilot    # prints the manual step
```
