<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, field, automator & page head output

## Install / enable

`drush en ai_schemadotorg_jsonld` pulls in `ai` (with `ai_automators`), `json_field`, and
`field_widget_actions`. Configure a default AI provider first (`/admin/config/ai/providers`), or
generation has no model to call. Optionally enable `json_field_widget` for the rich `json_editor`
code editor (otherwise a plain `json_textarea` is used). `drupal/token` (a dev requirement) enables
the token-tree UI and the content token.

## Config object `ai_schemadotorg_jsonld.settings`

Schema: `config/schema/ai_schemadotorg_jsonld.schema.yml` (type `config_object`). Install defaults:
`config/install/ai_schemadotorg_jsonld.settings.yml`. Keys:

- `entity_types` — sequence keyed by entity type id; each has:
  - `default_prompt` (text) — token-based prompt sent to the LLM for that entity type.
  - `default_jsonld` (text) — static JSON-LD injected on every canonical page of the type (blank = off).
- `requirements` (text) — shared instruction block spliced into prompts wherever the
  `[ai_schemadotorg_jsonld:requirements]` placeholder appears.
- `development.edit_prompt` (boolean) — show the modal "Edit prompt" button on saved entity edit forms.

The install default ships a `node` entry with a rich prompt (title/summary/image/body/content tokens
plus an output-format skeleton) and a detailed `requirements` block; `development.edit_prompt: true`.
Per-entity-type default prompts for `block_content`, `comment`, `media`, `node`, `taxonomy_term`, and
`user` also live as text files under `prompts/entity_types/*.prompt.txt` and are used to seed the
config when an entity type is first enabled (`AiSchemaDotOrgJsonLdManager::buildDefaultPrompt()`).

## Routes & permissions

`ai_schemadotorg_jsonld.routing.yml`:

- `ai_schemadotorg_jsonld.settings` — `/admin/config/ai/schemadotorg-jsonld`, form
  `AiSchemaDotOrgJsonLdSettingsForm`, `_permission: administer site configuration`.
- `ai_schemadotorg_jsonld.prompt` — `/admin/config/ai/schemadotorg-jsonld/prompt/{entity_type}/{bundle}`,
  form `AiSchemaDotOrgJsonLdPromptForm`, `_permission: administer site configuration`.

The module declares **no permissions of its own**. Menu link (`links.menu.yml`) sits under
`ai.admin_settings`; a local task (`links.task.yml`) adds the Settings tab.

## Settings form (`Form/AiSchemaDotOrgJsonLdSettingsForm`)

`ConfigFormBase` using `RedundantEditableConfigNamesTrait`. Per enabled entity type it renders:
a bundle `tableselect` (checking a bundle calls `builder->addFieldToBundle()` on submit; already-fielded
bundles are `#disabled`), a *Default settings* group with `default_prompt` (textarea + token tree) and
`default_jsonld` (textarea, validated as JSON by `validateJson()` element callback), and per-bundle
operation links (*Edit prompt* modal, *Edit field*, *Delete field*). An *Enabled entity types*
`tableselect` (`getEnabledEntityTypeOptions()`) drives which types are managed; *Additional settings*
holds `requirements`; *Development settings* holds `development.edit_prompt`. Submit
(`submitForm()`) calls `manager->syncEntityTypes()` + `manager->addEntityTypes()`, then per configured
type adds the field to newly checked bundles and saves `default_prompt`/`default_jsonld`.

## Prompt form (`Form/AiSchemaDotOrgJsonLdPromptForm`)

Loads the bundle automator `<type>.<bundle>.field_schemadotorg_jsonld.default`; edits its `token`
(prompt) textarea and, on save, writes both `token` and `plugin_config.automator_token`. Works inline
or in an AJAX modal (`isModalRequest()` checks `MainContentViewSubscriber::WRAPPER_FORMAT`); the modal
path returns a `MessageCommand` + `CloseModalDialogCommand`. 404s if no automator exists.

## The JSON-LD field & automator (`AiSchemaDotOrgJsonLdBuilder`)

`addFieldToBundle($entity_type_id, $bundle)` (guarded by `manager->isSupportedEntityType()`) does, in order:

1. `ensureEntityTypeSettings()` → seeds `entity_types.<type>` config if missing.
2. `createFieldStorage()` → `field_storage_config` `field_schemadotorg_jsonld`, type `json_native`,
   cardinality 1, translatable.
3. `createField()` → `field_config` on the bundle, label "Schema.org JSON-LD", not required, translatable.
4. `createAutomator()` → an `ai_automator` config entity: rule `llm_json_native_field`, input mode
   `token`, worker `field_widget_actions`, `base_field: revision_log`, `token` = the type's
   `default_prompt`, `plugin_config.automator_ai_provider: default_json`. Then
   `ai_automator.status_field`→`modifyStatusField()`.
5. `addFormDisplayComponent()` → widget (`json_editor`/`json_textarea`) at weight 99 with a
   `field_widget_actions` `automator_json` action labelled "Generate Schema.org JSON-LD".
6. `addViewDisplayComponent()` → `json` formatter at weight 99.

`addFieldToBundles()` accepts an explicit bundle list or `['*']` (all current bundles); non-bundle
entity types (e.g. `user`) use a synthetic bundle equal to the entity type id.

## Supported entity types (`AiSchemaDotOrgJsonLdManager`)

`getSupportedEntityTypes()` returns every content entity type that has a `canonical` link template and
is fieldable, minus a hardcoded unsupported list (`ai_log`, `automator_chain`, `menu_link_content`,
`shortcut`). `addEntityTypes()`/`syncEntityTypes()` maintain the `entity_types` config to match the
enabled set (keeping types that still have field storage). `buildDefaultPrompt()` reads a
`prompts/entity_types/*.prompt.txt` file if present, else assembles a token prompt from the entity's
token type, bundle token, and label key.

## Page head output (`Hook/AiSchemaDotOrgJsonLdPageHooks`)

`page_attachments`: on a canonical route (`entity.<type>.canonical`, via
`AiSchemaDotOrgJsonLdCurrentEntityTrait`) whose entity has the JSON-LD field, it appends up to two
`#type: html_tag` `script` elements with `#attributes.type = application/ld+json` to
`#attached[html_head]` — one for the entity-type `default_jsonld` (if set) and one for the entity's
own field value. Each value is round-tripped through `json_decode`/`json_encode` (`compactJson()`) to
whitespace-strip it. The head JSON-LD is emitted regardless of the field's *view* access (SEO by
design); `entity_field_access` only hides the field's on-page rendered display from non-editors.

## Provisioning without the UI

- Drush: `drush ai_schemadotorg_jsonld:add-field node article`, or `... node '*'`, or `... user`.
- Recipe/config action: apply `addField` to `ai_schemadotorg_jsonld.settings` with
  `{entity_type: node, bundles: [article, page]}` — see [../api/services.md](../api/services.md).
