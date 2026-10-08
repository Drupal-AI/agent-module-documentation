<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (new in 1.3.0)

Registered in `drush.services.yml`. Namespace `analyze:*`. Requires `drush/drush` (suggested dep).

## `analyze:batch` (alias `ab`)
Run batch analysis across content using analyzers that implement `BatchableAnalyzerInterface`.
Only enabled type:bundle combinations (from `analyze.settings:status`) are processed. Prompts for
confirmation (warns some analyzers make paid external API calls).

Options:
| Option | Meaning |
|---|---|
| `--analyzers=` | Comma-separated plugin IDs (default: all batch-capable). |
| `--types=` | Comma-separated `entity_type:bundle` pairs, e.g. `node:article,node:page` (default: all enabled bundles for the chosen analyzers). |
| `--limit=N` | Max entities to process (`0` = no limit). |
| `--force` | Re-analyze even if results already exist (`hasResults()`). |
| `--list` | List available batch-capable analyzers and exit. |
| `--status` | Print a coverage table (Bundle / Total / Pending / Coverage) and exit. |

Examples:
```bash
drush analyze:batch --list
drush analyze:batch                                   # all analyzers, all enabled types
drush analyze:batch --analyzers=my_analyzer --types=node:article
drush analyze:batch --limit=50 --force
drush analyze:batch --status
```
Behavior: switches to an admin account for processing, queries **published** entities of each
bundle, skips fully-analyzed ones unless `--force`, and retries `AiRateLimitException` with
exponential backoff (2s→4s→8s, 3 retries). Reports `@ok succeeded, @fail failed` and any errors.

## `analyze:setup-ai` (alias `analyze-sa`)
Copy the module's bundled AI "skill" files into the project root so AI coding assistants can drive
Analyze via natural language. Files: `.claude/skills/analyze/SKILL.md`,
`.agents/skills/analyze/SKILL.md`, `.agents/skills/analyze/agents/openai.yaml`. Outputs YAML.

Options:
| Option | Meaning |
|---|---|
| `--host=` | `all` (default), `claude` (only `.claude/`), or `agents` (only `.agents/`). |
| `--check` | Report `up to date` / `OUTDATED` / `NOT INSTALLED` per file; make no changes. |

```bash
drush analyze:setup-ai              # install for all tools
drush analyze:setup-ai --check      # verify freshness
drush analyze-sa --host=claude      # Claude Code only
```
`hook_requirements` raises a warning on the status report when installed skill files differ from the
module's copies (fix by re-running `analyze:setup-ai`).
