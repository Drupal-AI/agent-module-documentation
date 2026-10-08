<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush DTK — `dtk:install` setup command

`src/Drush/Commands/DtkInstallCommands.php`. The one command Drush DTK adds. Wires the compression
opt-in into an AI agent's project configuration. Auto-discovered under `src/Drush/Commands/`.

## Signature

`drush dtk:install <agent>` (alias `dtki`).

- Argument `agent`: one of `claude`, `codex`, `opencode`, `copilot`. Any other value throws
  `InvalidArgumentException`.
- Option `--dir=<path>`: treat this as the project root instead of the Composer root; **also forces
  the file write, skipping container detection**.
- Option `--site-wide`: enable the `dtk.settings` config opt-in instead of writing an agent env file.
  Implied automatically inside a container.

`WRITABLE = ['claude', 'codex']` (a project file is written); `MANUAL = ['opencode', 'copilot']`
(only printed instructions).

## What it does (`install()` flow)

1. Reject unknown agents.
2. `--site-wide` → `enableSiteWide()` and return.
3. Else, unless `--dir` was given, probe for a container via `containerSignal()`. If detected →
   `enableSiteWide()` and return (host env vars never reach a wrapped `ddev drush` / `lando drush`,
   so an agent env file would silently do nothing).
4. Manual agents (`opencode`/`copilot`) → print `manualInstructions()` and return.
5. Writable agents → `installClaude($root)` or `installCodex($root)`, where
   `$root = --dir ?? Drush::bootstrapManager()->getComposerRoot()`.

## File writers (only inside the project root)

- `installClaude($root)` → `<root>/.claude/settings.json`. Reads any existing file, requires valid
  JSON (throws otherwise), merges only `env.DTK_COMPRESS = "1"` (preserving other settings), writes
  pretty-printed JSON. No-ops if already set.
- `installCodex($root)` → `<root>/.codex/config.toml`. Creates it with a `[shell_environment_policy]`
  table `set = { DTK_COMPRESS = "1" }`, or appends the table to an existing file. No TOML parser, so
  it refuses (throws) rather than corrupt a file that already has a `[shell_environment_policy]`
  table; no-ops if `DTK_COMPRESS` already present.
- `write()` creates the parent dir (`mkdir 0755` recursive) and `file_put_contents`; throws on
  failure. Writes are confined to the resolved project root — no downloads, no shell, no git/composer.

## Container detection (`containerSignal()` / `detectContainer()`)

`containerSignal()` probes: `IS_DDEV_PROJECT`, `LANDO`, `/.dockerenv` or `/run/.containerenv`,
`KUBERNETES_SERVICE_HOST`, and (fallback) reads `/proc/1/cgroup` for `docker|containerd|kubepods|lxc`.
`detectContainer()` is a pure mapper returning `DDEV` / `Lando` / `a container` / `Kubernetes` / null.
Silent on cgroup v2 (`0::/`) — use `--site-wide` there.

## `enableSiteWide($reason)`

Sets `dtk.settings:compress = TRUE` (via `configFactory->getEditable()->save()`) and returns a
message noting: it applies to every drush invocation immediately, humans can opt out with
`--no-ai-compress` or disable with `drush config:set dtk.settings compress 0`, and on config-managed
sites you should `drush cex` to persist.

## Manual instructions (printed, no file written)

- `opencode`: launch with `DTK_COMPRESS=1 opencode` (or a shell alias / direnv `.envrc`).
- `copilot`: config is global (`~/.copilot`), so launch with `DTK_COMPRESS=1 copilot`, or for the
  GitHub-hosted agent set `DTK_COMPRESS: "1"` in `.github/workflows/copilot-setup-steps.yml`.
