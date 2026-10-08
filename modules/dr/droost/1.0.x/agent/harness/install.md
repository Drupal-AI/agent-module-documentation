<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost harness installers & Drush commands

Droost wires the MCP server into an AI coding agent's config files, reversibly, and writes Droost
guidance into managed regions only — never touching surrounding user content.

## Drush commands (`src/Drush/Commands/`, discovered via PSR-4 `Drush\Commands\`)

- **`drush droost:install`** (alias `droost`; `DroostCommands::install`). Options: `--launcher`
  (`auto|ddev|drush|vendor` — how the harness launches the STDIO server), `--harness`
  (`auto` detect, `all`, or a comma list of `claude,codex,opencode,qwen,gemini`), `--guidelines`
  (default on; `--no-guidelines` writes MCP entries only). Detects harnesses, registers the MCP server
  entry, and writes an `AGENTS.md` block + per-harness pointers. Idempotent; prints fallback
  `claude mcp add` / `gemini mcp add` / `codex mcp add` one-liners.
- **`drush droost:uninstall`** (alias `droost:remove`). Removes Droost regions/entries for the given
  `--harness`, deleting a file only when Droost's region was its sole content. Idempotent.
- **`drush droost:doctor`** (alias `ddr`, `DoctorCommands`) — knowledge-store freshness report.
- **`drush droost:scaffold`** (alias `dsc`, `ScaffoldCommands`) — the CLI face of `droost_scaffold`.
- **`drush droost:skills:emit`** (alias `dske`, `SkillsCommands`) — writes skill markdown.

## The harness registry & installers (`src/Harness/`)

`HarnessRegistry` (service `droost.harness_registry`) fans out to one installer per harness, each
implementing `HarnessInstallerInterface` (`getId`, `label`, `isDetected`, `install`, `uninstall`):
`AgentsHarnessInstaller` (the shared `AGENTS.md`), `ClaudeHarnessInstaller` (also writes skill files
via `droost.skill_provider` + `droost.skill_md_writer`), `CodexHarnessInstaller`,
`OpencodeHarnessInstaller`, `QwenHarnessInstaller`, `GeminiHarnessInstaller`.

`AbstractHarnessInstaller` provides the file I/O, all against **project-relative constant paths** (not
caller input): `read`/`write` (creates parent dirs), `delete`, `removeDirIfEmpty`, `deleteDir` (never
recurses into a symlinked dir — removes the link only). Two merge strategies preserve user content:

- **JSON MCP entries** — `upsertJsonServer`/`removeJsonServer` via `Harness\JsonMerge`, setting/unsetting
  a `{command, args}` entry under a parent key (e.g. `mcpServers.droost`). A malformed JSON file is
  left untouched with a warning, never destroyed.
- **Markdown managed regions** — `upsertMarkdown`/`removeMarkdown` via `Harness\ManagedRegion` +
  `Harness\Markers` (BEGIN/END sentinels). Only the region between markers is rewritten; mismatched
  markers → left unchanged with a warning; the file is deleted only if the region was all it held.

The install `$root` is always `ProjectRoot::path()` (the composer root above the docroot), so configs
land at the project root, not inside the web-accessible docroot.

## Skills (`src/Skill/`)

`SkillProvider` collects Droost's guideline topics into `Skill` objects; `SkillMdWriter` renders them
to markdown for harnesses (Claude Code) that consume a skills directory. `GuidelineProvider` and
`ModuleDocReader` back the `droost_guidelines` / `droost_module_docs` read tools and the AGENTS.md body.
