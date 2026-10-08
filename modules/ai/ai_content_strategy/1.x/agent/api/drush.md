<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (`acs:*`)

Registered in `drush.services.yml`; classes in `src/Drush/Commands/`. They call the same services
as the UI, so they read/write the `ai_content_strategy.recommendations` key-value store and the
category config entities. Run on the CLI (trusted context).

## Generation & health (`GenerationCommands`)
- `acs:health` (`acs-h`) — check that AI is configured and a chat model is usable.
- `acs:generate` (`acs-g`) `--category=<id>` — generate recommendations (all or one category).
- `acs:generate:more` (`acs-gm`) — generate more ideas for a card.
- `acs:generate:add` (`acs-ga`) — add more recommendation cards to a category.

## Reporting (`ReportCommands`)
- `acs:report` (`acs-r`) — list current recommendations.
- `acs:report:card` (`acs-rc`) — show one card.
- `acs:report:status` (`acs-rs`) — last-run/status summary.
- `acs:sitemap` (`acs-s`) — show the sitemap URLs the analyzer discovers.

## Card & idea CRUD (`CardCommands`, `IdeaCommands`)
- `acs:card:edit` (`acs-ce`), `acs:card:delete` (`acs-cd`).
- `acs:idea:edit` (`acs-ie`), `acs:idea:implement` (`acs-ii`), `acs:idea:delete` (`acs-id`).

## Categories (`CategoryCommands`)
- `acs:category:list` (`acs-catl`), `acs:category:get` (`acs-catg`),
  `acs:category:create` (`acs-catc`), `acs:category:update` (`acs-catu`),
  `acs:category:delete` (`acs-catd`). Create/update/delete accept `--dry-run`.

## Settings & export (`SettingsCommands`, `ExportCommands`)
- `acs:settings:get` (`acs-sg`), `acs:settings:set` (`acs-ss`) — read/write the global system prompt.
- `acs:export` (`acs-e`) `--format=yaml|json|csv --category=<id> --file=<path>` — export
  recommendations (stdout raw, or a YAML success envelope when `--file` is given).

## Setup (`SetupCommands`)
- `acs:setup-ai` (`acs-sa`) — installs the bundled Agent Skills files
  (`.agents/skills/acs/`, `.claude/skills/acs/`) into the project root so AI coding assistants can
  drive the module by natural language. `hook_requirements()` reports if these files are missing or
  outdated.
