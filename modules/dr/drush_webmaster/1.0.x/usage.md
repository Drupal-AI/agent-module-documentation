<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Webmaster is a large suite of structured, validated `wm:*` Drush commands (with YAML output, dry-run and a versioned export/edit/apply workflow) that let an AI agent or a webmaster build and manage almost every part of a Drupal site from the command line — with no HTTP routes or admin UI of its own.

---

Drush Webmaster ships ~100 `wm:*` Drush commands (~15 command classes, each backed by a Service
manager and, for the riskier ones, input validators) covering entities, content types, fields,
views, menus, blocks, vocabularies, media types, translations, moderation and core search, plus a
full site-schema dump (`wm:schema:dump`) for onboarding an agent onto an unfamiliar site. Every
command prints structured YAML; mutating commands accept `--dry-run` and are guarded by validators
(machine-name format, entity/bundle existence, field types, allowed values, entity-reference
targets) rather than by executing arbitrary code. A file-based edit/apply workflow (`wm:entity:edit`
→ edit file → `wm:entity:apply`, and the same for views) writes versioned YAML/HTML/TXT snapshots
under `~/.drush-wm` (or `/tmp/drush-wm`) so every change is backed up and revertible. It is
CLI-only: it defines no routes, no controllers and no settings form, and it runs its commands as
the site admin (user 1). The base module depends on core node/field/user; two optional submodules
add redirect and webform commands. This is a 1.0.0-beta1 pre-release.

Because Drush/CLI is already a privileged context and these commands make real structural and
content changes (and can delete content in bulk), run them in appropriate environments and prefer
`--dry-run` first. The module is meant to give AI coding assistants (Claude Code, Cursor, Copilot,
Codex, Gemini) a safe, well-defined command surface for routine site building, and `wm:setup-ai`
installs the matching agent skill files into the project root.

---

- Give an AI coding assistant a safe, structured command surface to manage a Drupal site.
- Dump the entire site schema (content types, fields, views, menus, blocks, media, entity types) as YAML for agent onboarding (`wm:schema:dump`).
- Query entities with field conditions and operators (`=`, `!=`, `>`, `<`, `IN`, `NULL`) without a search index (`wm:entity:query`).
- List, get, create, edit and delete content-type nodes and any content entity from the CLI.
- Get or set a single field value on an entity (`wm:entity:field:get` / `wm:entity:field:set`).
- Export an entity or view to a versioned YAML file, edit it, then apply with validation and `--dry-run` (`wm:entity:edit`/`apply`, `wm:view:edit`/`apply`).
- Keep automatic version history of every edited entity/view and revert to a prior version (`wm:entity:history`/`revert`).
- Clone an entity, deep-clone it with referenced entities, or diff two entities (`wm:entity:clone`, `wm:entity:deep-clone`, `wm:entity:diff`).
- Bulk create, update or delete entities from a YAML file or selector filters (`wm:entity:bulk-*`).
- Create, update and delete content types, and add/update/remove fields on any bundle (`wm:content-type:*`, `wm:field:*`).
- Discover available field types before adding a field (`wm:field:types`).
- Create, update and delete taxonomy vocabularies (`wm:vocabulary:*`).
- List and inspect media types (`wm:media-type:*`).
- Build and manage views: create, clone, edit, preview, enable/disable, and discover available fields/filters/sorts/arguments/relationships/areas for any base table (`wm:view:*`).
- Create menus and add/update/delete menu links with full hierarchy (`wm:menu:*`).
- Place, update and remove blocks in theme regions (`wm:block:*`).
- Manage multilingual content: list languages, view/add/update/delete entity translations from JSON (`wm:translation:*`, `wm:entity:translation:*`).
- Move content through moderation states and inspect available transitions (`wm:entity:transitions`, `wm:entity:moderate`).
- Run core full-text search from the CLI and get title/URL/snippet results (`wm:search`).
- View and update basic site settings (name, slogan, mail, front/403/404 pages) (`wm:site:*`).
- Install AI assistant skill files into the project root for Claude, Codex, Gemini, Copilot and Cursor (`wm:setup-ai`).
- Preview and validate changes safely with `--dry-run` on every mutating command.
- Add redirect management commands with the `drush_webmaster_redirect` submodule (needs the Redirect module).
- Add webform and submission management commands with the `drush_webmaster_webform` submodule (needs the Webform module).
