<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost scaffold, structure authoring & the verify loop

The generate → author → verify half of Droost. All three tools are STDIO/Drush-only.

## `droost_scaffold` (`Scaffold.php`)

Composes convention-correct, green-by-default code + a matching test from a **blueprint**. Extends
`DestructiveToolBase`. Flow in `execute()`:

- No `blueprint` arg → lists available blueprints (ungated).
- `requireCliTransport()` first (the DCG blueprints build Drupal Code Generator in-process through the
  Drush runtime, CLI-only). A `dry_run` preview writes nothing and is **ungated**; a real write is
  gated by `gate('allow_scaffold')`.
- Target `module` defaults to `droost`; resolved via `ModuleExtensionList::getPath()`. **Refuses**
  paths matching `(^|/)(core|modules/contrib|themes/contrib|profiles/contrib|vendor)(/|$)` — never
  scaffolds into core or a Composer-managed dependency (would be clobbered on `composer install`).
  Scaffold into a custom/site module only.
- Generation goes through a `BlueprintRegistry` of `Scaffold\Blueprint\*` classes; a partial failure
  reports the files already `created`.

Blueprint ids (registered in `droost.services.yml` → `droost.scaffold.blueprints`): `mcp-tool`,
`service`, `content-entity`, `config-entity`, `event-subscriber`, `block`, `form`, `hook`,
`drush-command`, `plugin`, `sdc`, `views-handler`, `config-schema`, `access-handler`,
`route-subscriber`, `kernel-test`. The DCG-backed ones use `Scaffold\Dcg\DcgRunner` +
`QualityNormalizer` (in-process code generation; no shell-out). Also available as `drush droost:scaffold`.

## `droost_structure_create` (`StructureCreate.php`)

Authors structural config over MCP (gated by `allow_scaffold`, CLI-only). Three `kind`s, **create-only**
(an existing target is a refusal pointing at the read tool, never an upsert):

- **`field`** — field storage (**reused** when a compatible same-type storage exists; a different-type
  storage is refused, never a silent cross-type bind) + the bundle instance + the field type's default
  widget/formatter placed on the default form/view displays (so the field is immediately visible).
  Validates machine name (`/^[a-z][a-z0-9_]*$/`, ≤32 chars), fieldable bundle, and field type. Rolls
  back a storage it created if a later step fails.
- **`bundle`** — the bundle config entity for any entity type that declares one (node types,
  vocabularies, media types…), with a `values` passthrough.
- **`view_mode`** — an `EntityViewMode` (`{entity_type}.{id}`), optionally enabled for a bundle
  (`enable_for_bundle`) so `droost_display_compose` accepts it immediately.

Every success returns the read-back of what the site now reports, never a bare "saved".

## `droost_verify` (`Verify.php` + `Verify/VerifyRunner.php`)

Runs the QA loop over MCP and returns structured per-finding results — `readOnly: TRUE` but
`requireCliTransport()` (spawns project binaries). No target → the check **inventory** (which binaries/
configs are available, no spawn). Args: `module` XOR `path`, `checks` (default `["phpcs","phpstan"]`;
add `phpunit`/`deprecations`), `standard`. `phpunit` additionally requires `confirm:true` because the
suite creates/drops test databases and is not read-only.

- A `path` argument is resolved with **`PathGuard::contain($projectRoot->path(), $projectRoot->resolve($path))`**
  — `realpath`s both sides so `../` and symlinks cannot escape the project root. A `module` argument
  resolves via the extension list.
- `VerifyRunner` spawns phpcs/phpstan/phpunit via **Symfony `Process` with an argv array** (no shell
  string → no shell injection), with per-check timeouts and a 200-finding cap. A failing check is a
  `LegResult`, never an exception — the loop always returns a verdict; `success` means "the tool ran",
  not "the checks passed" (read `data.legs`).

## Path & root helpers

`ProjectRoot` (`src/ProjectRoot.php`, service `droost.project_root`) resolves the composer root above
the docroot (recognises `composer.json`/`.git`/`.ddev`/`vendor`), so generated/harness/wiki artifacts
land at the project root, not inside the web-accessible docroot; `isInsideAppRoot()` warns when they
would. `PathGuard` (`src/PathGuard.php`): `isWithin()` (string containment of resolved paths),
`contain()` (realpaths + containment for unresolved untrusted input), `resolve()` (child-of-dir with
optional extra bases for symlinked composer/CI layouts).
