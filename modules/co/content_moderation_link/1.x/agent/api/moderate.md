<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moderate route, controller, settings, token & hooks

Everything the module does, grounded in source. Files under
`web/modules/contrib/content_moderation_link/`.

## Install / enable

- `drush en content_moderation_link` (core `content_moderation` is a hard dependency and must be
  enabled, along with at least one Workflow of type *content_moderation* with states/transitions).
- Configure at `/admin/config/content/content-moderation-link` (menu: *Configuration → Workflow*).

## The moderate route

`content_moderation_link.routing.yml`:

- `content_moderation_link.moderate` — path
  `/content-moderation-link/process/{state}/{type}/{id}`, controller
  `ContentModerationLinkController::moderate`, requirement `_permission: 'access content'`.
  (A commented-out `_role: 'authenticated'` line is present but inactive; the authenticated check is
  done in code instead.)
- `{state}` = target workflow state machine name, optionally prefixed `{workflow}-{state}`
  (e.g. `editorial-published`); `{type}` = entity type id (e.g. `node`); `{id}` = one entity id, or
  several comma-separated when `allow_multiple` is on.

## Controller logic — `ContentModerationLinkController::moderate($state, $type, $id)`

`src/Controller/ContentModerationLinkController.php`. Services injected via `create()`:
`content_moderation.state_transition_validation` (as `$this->validator`) and `entity_type.manager`.

Flow:
1. **Auth gate.** `if ($account->isAnonymous())` → redirect to `user.login` with a destination.
2. **Config allowlists.** Reads `content_moderation_link.settings`. If `entity_types` is non-empty
   and `$type` is not in it → error message + redirect to `destination` (config, default `<front>`).
   If `moderation_states` is non-empty and `$state` matches neither an exact entry nor (via
   `findAmongWorkflows()`) an entry ending in `-{state}` → error + redirect. Empty lists permit any
   value.
3. If `$state` contains `-`, splits off the workflow prefix (note: the first element is assigned to
   an unused misspelled `$worflow`, so `$workflow` stays null and the per-entity workflow lookup in
   step 6 still runs).
4. Loads storage for `$type`; parses `$id` on `,`. If `allow_multiple` is false, keeps only the
   first ID.
5. Per ID: `$storage->load($parsed_id)`. On miss → warning and `continue` if `skip_errors`, else
   post partial messages, add error, redirect.
6. **Transition access check (the real gate).**
   `$this->validator->getValidTransitions($entity, $account)` and only proceeds if some transition's
   `to()->id()` equals `$state`. If not → warning "…without valid transition" and `continue`. This
   is core Content Moderation's own per-user, per-transition permission logic — the module never
   sets state on a transition the acting user is not authorized for. When `moderation_states` is set
   but no workflow prefix was supplied, it additionally looks up the entity's workflow via an entity
   query (`type_settings.entity_types.{type}.*` = bundle) and requires `{workflow}-{state}` to be in
   the allowlist.
7. `$entity->set('moderation_state', $state)`; invokes
   `hook_content_moderation_link_alter_entity(&$entity)` and
   `hook_content_moderation_link_alter_account(&$account)`; if the entity is a `RevisionLogInterface`,
   sets a revision log message and revision user; `$entity->save()`.
8. Posts status messages. If exactly one entity processed and `$entity->toUrl()->access()`,
   redirects (302) to the entity; otherwise redirects to the configured `destination`.

## Settings form — `Form\SettingsForm`

`src/Form/SettingsForm.php`, a `ConfigFormBase` (id `content_moderation_link_settings`), editing
`content_moderation_link.settings`. Fields:

- `allow_multiple` (checkbox) — permit comma-separated IDs; else only the first is used.
- `skip_errors` (checkbox) — skip un-loadable IDs vs. halt processing.
- `destination` (textfield) — a **route name** (not a path) to redirect to; blank → `<front>`.
- `entity_types` (multi-select) — from `getEntityTypes()`: content entity types that have a bundle
  key and a `list_builder` handler. The form warns that leaving it empty permits any value.
- `moderation_states` (multi-select) — from `getWorkflowStates()`: for every
  `type => content_moderation` workflow, options keyed `{workflow_id}-{state_id}`. Same
  empty-permits-any warning.

`submitForm()` copies each submitted value (except form plumbing keys) into config and saves.

## Config object & schema

- Install defaults `config/install/content_moderation_link.settings.yml`: `allow_multiple: 0`,
  `skip_errors: 1`, `destination: ''`, `entity_types: { node: node }`,
  `moderation_states: { editorial-published: editorial-published }`.
- Schema `config/schema/content_moderation_link.schema.yml`: `content_moderation_link.settings`
  (`config_object`) with `allow_multiple`/`skip_errors` integer, `destination` string,
  `entity_types` and `moderation_states` sequences of string.

## Token

`content_moderation_link.tokens.inc` — `hook_token_info()` adds a dynamic node token
`moderation-link`; `hook_tokens()` handles `moderation-link:<state>` on node data. The `<state>`
segment is sanitized with `preg_replace('/[^-a-z0-9_]/', '', $state)` before building the URL, then
`Url::fromRoute('content_moderation_link.moderate', ['state' => …, 'type' => 'node', 'id' => nid],
['absolute' => TRUE])`. Adds cache context `url.site`. Example: `[node:moderation-link:published]`.

## Hooks (for integrators)

`content_moderation_link.api.php`:
- `hook_content_moderation_link_alter_entity(EntityInterface &$entity)` — mutate the entity after
  the state is set, before save.
- `hook_content_moderation_link_alter_account(AccountInterface &$account)` — mutate the acting
  account before save.

## Permission caveat

The settings route requires `administer content_moderation_link configuration`, but the module ships
no `*.permissions.yml` that defines this permission. In Drupal an undefined permission cannot be
granted to any role, so only user 1 (who bypasses permission checks) can reach the settings form.
This fails closed (no over-permissioning), but means you cannot delegate configuration to another
role without patching in a `content_moderation_link.permissions.yml`.
