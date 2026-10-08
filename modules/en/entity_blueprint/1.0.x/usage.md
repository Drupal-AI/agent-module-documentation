<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Blueprint converts any fieldable Drupal entity to and from a simplified JSON format so AI agents and external systems can read, edit, and rebuild entities with full validation.

---

Entity Blueprint is a standalone entity abstraction layer that serializes fieldable entities — including Layout Builder pages with nested paragraphs, inline blocks, and opaque third-party settings — into clean JSON, and deserializes JSON back into valid, unsaved Drupal entities. It runs two-phase validation (structural, then semantic with access and constraint checks) and returns structured errors with JSON paths, error codes, and correction hints. Beyond full round-trips it offers targeted CRUD operations on individual components addressed by UUID, batch operations with atomic rollback, per-bundle JSON schema generation, and an opaque-data protection model that preserves Layout Builder internals it does not understand. The base module needs only Drupal core (10.3–11); optional experimental submodules expose the operations as Drupal AI function-call tools, add config-entity support, provide Anthropic-specific skill formatting, and add prompt-capture developer diagnostics. Access is enforced against the acting user throughout, and nothing is saved implicitly — the caller decides whether to save, write to tempstore, or discard.

---

- Serialize a node, block_content, paragraph, or any fieldable entity to JSON with `drush entity-blueprint:serialize node 1`.
- Produce a structure-only summary (tree of UUIDs, no field values) with `--summary` to give an AI a cheap map of a page.
- Serialize a single component by UUID with `--component=UUID` to focus an AI on one block or paragraph.
- Deserialize hand-crafted or AI-generated JSON back into an entity with `drush entity-blueprint:deserialize blueprint.json`.
- Validate a blueprint without hydrating (Phase A only) using `--dry-run` to catch schema errors cheaply.
- Pipe a blueprint from stdin (`cat blueprint.json | drush entity-blueprint:deserialize -`) in a scripted pipeline.
- Generate a descriptive JSON schema for an entity type + bundle with `drush entity-blueprint:schema node page` so an agent can learn the structure before acting.
- Let an AI agent create a full node — including a Layout Builder layout with sections and inline blocks — from a single JSON blueprint via the `eb_create_entity` tool.
- Give an AI agent surgical edit tools (`eb_update_element`, `eb_add_element`, `eb_remove_element`) to change one block or paragraph without re-sending the whole page.
- Reorder paragraph items or restructure a page layout via `eb_reorder_field` and `eb_restructure_layout`.
- Batch several edits into one atomic operation with rollback on failure via `eb_batch_operations`.
- Discover which entity types and bundles an agent may create with `eb_list_bundles`, filtered by the site's AI-visibility settings.
- Restrict which entity types and bundles AI agents can see and create on the `/admin/config/ai/entity-blueprint` settings form.
- Manage config entities as JSON (views, image styles, entity displays, field config) through the `entity_blueprint_config` submodule.
- Allow-list which permission-less config entity types AI agents may create on `/admin/config/development/entity-blueprint-config`, gated by a dedicated permission.
- Add, update, remove, or reorder plugins inside a config entity's plugin collections (e.g. view displays, image effects) via `eb_config_manage_plugins`.
- Build an AI-powered page builder on top of Layout Builder, using Entity Blueprint as the safe bridge between the agent and entity internals.
- Support translation workflows by serializing and deserializing with a `langcode`, writing only translatable fields on non-default translations.
- Preserve editor-set Layout Builder settings the AI never sees, exposing only keys a module explicitly declares as managed via YAML or hook.
- Attach AI-facing guidance and default values to schema output at entity, field-type, block-type, and layout levels through YAML files or `hook_entity_blueprint_context_alter()`.
- Register a handler for a custom field type by tagging a service `entity_blueprint.field_handler` and extending `FieldHandlerBase`.
- Route edits through tempstore for review-before-publish when tempstore_plus or Layout Builder is available, instead of saving directly.
- Require an active workspace before any content change when the Workspaces module is enabled, turning AI editing into a sandbox.
- Emit deferred field operations (e.g. asynchronous image generation) that a consuming module processes after the entity is built.
- Capture the fully assembled AI prompt surface (system prompt, messages, tools) without calling an LLM, for prompt debugging, via the dev-tools submodule.
