<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture, permissions, output & configuration

## Install & enable

```bash
composer require drupal/drush_webmaster
drush en drush_webmaster -y
drush list wm            # see all wm:* commands
drush wm:schema:dump     # onboarding: dump the whole site as YAML
```

Deps: core **node, field, user**. PHP **8.1**. Core `^10.3 || ^11`. No `composer.json` ships, so
there are no third-party Composer requirements. Optional submodules add redirect/webform commands.
This is release **1.0.0-beta1** (beta).

## `WebmasterCommandsBase` (`src/Drush/Commands/WebmasterCommandsBase.php`)

Abstract base for the **main** module's command classes (it is *not* used by the two submodules,
whose commands extend `DrushCommands` directly).

- **Runs commands as the site admin.** A `#[CLI\Hook(type: 'pre-command', target: '*')]` method
  `preCommandSwitchToAdmin()` loads user **1** and calls `account_switcher->switchTo($admin)` once
  per request (guarded by a static flag) so every `wm:*` command executes with full permissions.
  Failures are swallowed.
- **YAML output helpers.** `yaml()` (Symfony `Yaml::dump`, inline level 4), `success($msg, $data)`,
  `error($msg, $errors)`, `successList($items, $extra)`, `notFound($type, $id, $listCmd)`,
  `noChanges()`, `validationError($errors)`, `sanitizeResult()`. All `wm:*` output is YAML because
  it is token-efficient and is Drupal's native config format.
- **Validation shortcuts.** `validateEntityTypeOrFail()` / `validateBundleOrFail()` throw
  `\RuntimeException` on validator errors.

## Permission model (IMPORTANT for accuracy)

`drush_webmaster.permissions.yml` declares two permissions, both `restrict access: true`:

- `administer drush webmaster` — "Configure which capabilities are enabled".
- `use drush webmaster content types` — "Execute content type management commands via Drush".

**These permissions are not checked by the command code.** No command class or manager calls
`hasPermission()`/`->access()` to gate a `wm:*` operation against these permissions. Because the
base class switches to **user 1** before every command, and because Drush/CLI is already a
privileged context, the effective guard on these commands is *who can run Drush on the server*, not
these permissions. (The `administer drush webmaster` permission's description references configurable
"capabilities" that were removed — see below.) `@current_user` is injected into some managers only to
stamp the revision author (`EntityManager`, `ModerationManager`, `TranslationManager`) or to compute
valid moderation transitions, not to authorize the operation.

## Configuration (there is none, effectively)

- `config/install/drush_webmaster.settings.yml` is **`{}`** (empty).
- `config/schema/drush_webmaster.schema.yml` defines `drush_webmaster.settings` as a
  `config_object` with an **empty `mapping: {}`** (so `provides_config_schema` is true but nothing
  is stored).
- `drush_webmaster.install` → `drush_webmaster_update_9001()` **removes** a legacy `capabilities`
  key from active config if present. Earlier versions toggled per-command "capabilities" via config;
  that mechanism was dropped, so no command is gated by a config toggle any more.
- No settings route (`configure` is null); no admin form.

## `.module`

`drush_webmaster.module` is 18 lines: only `drush_webmaster_help()`, which returns a one-line help
string pointing at `drush list --filter=wm:`.

## `FileVersionManager` (`src/Service/FileVersionManager.php`) — the versioned file workflow

Backs the edit/apply/new/history/revert commands for entities, fields and views (see
[entities.md](entities.md) and [views-menus-blocks.md](views-menus-blocks.md)).

- **Base directory** (`getBaseDirectory()`): `$HOME/.drush-wm` if `HOME`/`USERPROFILE` is set and
  writable, otherwise **`/tmp/drush-wm`**. Subdirs `entities/`, `fields/`, `views/` are created with
  `mkdir(..., 0755)`. (Note: the `wm:schema:dump` AI-onboarding text mentions a
  `.drush_webmaster/` project-root directory — the actual runtime path is `~/.drush-wm`.)
- **Filenames** encode the identity, not caller-controlled paths:
  `{entity_type}_{id}_v{version}_{timestamp}.yml` (entities/views),
  `{entity_type}_{id}_{field}_v{version}_{timestamp}.{ext}` (fields), plus
  `{entity_type}_new_{bundle}_{timestamp}.yml` templates. Version numbers auto-increment by scanning
  existing files with `glob()` + a regex.
- **Field extensions** (`FIELD_EXTENSIONS`): text/html fields → `.html` (with an HTML metadata
  comment), scalar fields → `.txt` (with a `#` metadata line), reference/list/link → `.yml`.
- Reads/writes use `file_put_contents`/`file_get_contents` + `Yaml::dump`/`Yaml::parse`. All writes
  land inside the base dir; the entity type/id/field values used in filenames come from validated,
  existing entities, so there is no request-derived path here.

## `SetupCommands` — `wm:setup-ai` (`--host=claude|agents|all`)

Copies the module's bundled `SKILL.md` files to the project root so AI coding assistants can
discover the `wm:*` commands (Agent Skills standard, https://agentskills.io):

- `--host=claude` → `.claude/skills/drush-webmaster/SKILL.md` (+ appends/creates a `## Skill
  routing` section in the project's `CLAUDE.md`).
- `--host=agents` → `.agents/skills/drush-webmaster/SKILL.md` (+ `agents/openai.yaml` for Codex).
- `--host=all` (default) → both.

Project root is found by walking up ≤5 levels from `DRUPAL_ROOT` looking for `composer.json`. Module
path comes from `@extension.list.module`. `isSkillInstalled()` reports whether either SKILL file is
already present. All writes are local project files — a deliberate CLI dev-tooling action.
