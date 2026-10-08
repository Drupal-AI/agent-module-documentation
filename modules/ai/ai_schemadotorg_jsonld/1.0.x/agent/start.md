<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Schema.org JSON-LD (ai_schemadotorg_jsonld) — agent index

Glue module that gives content entities an **AI-generated `field_schemadotorg_jsonld` JSON field** and
injects the stored JSON-LD into the entity's **canonical page head** as `<script type="application/ld+json">`.
Package `AI`. Core `^11.3`. License GPL-2.0-or-later. Version **1.0.0-alpha1** (dir `1.0.x`).

Depends on `ai:ai_automators`, `json_field:json_field`, `field_widget_actions:field_widget_actions`
(composer: `drupal/ai ^1.3`, `drupal/field_widget_actions ^1.3`, `drupal/json_field ^1.7`).
Soft/optional: `json_field:json_field_widget` (checked at runtime for the `json_editor` widget),
`drupal/token` (dev; token tree + tokens). No permissions of its own — config is gated by core
`administer site configuration`.

## Solution docs

- **Settings, config objects, routes, forms, the JSON-LD field & automator, page head output** →
  [config/settings.md](config/settings.md)
- **Services, hooks, the AI event subscriber, token resolver, Drush command, config action** →
  [api/services.md](api/services.md)
- **Submodule: `ai_schemadotorg_jsonld_breadcrumb`** (BreadcrumbList JSON-LD) →
  [submodules/ai_schemadotorg_jsonld_breadcrumb.md](submodules/ai_schemadotorg_jsonld_breadcrumb.md)
- **Submodule: `ai_schemadotorg_jsonld_log`** (prompt/response log + admin UI + CSV export) →
  [submodules/ai_schemadotorg_jsonld_log.md](submodules/ai_schemadotorg_jsonld_log.md)

## What it actually provides

- **Field**: `field_schemadotorg_jsonld` (constant `AiSchemaDotOrgJsonLdBuilderInterface::FIELD_NAME`),
  a `json_native` field, cardinality 1, translatable, added per bundle. Widget `json_editor`
  (if `json_field_widget`) else `json_textarea`; view formatter `json`. A `field_widget_actions`
  action (`automator_json`, "Generate Schema.org JSON-LD") is attached to the form widget.
- **AI automator**: one per bundle, id `<type>.<bundle>.field_schemadotorg_jsonld.default`, rule
  `llm_json_native_field`, input mode `token`, worker `field_widget_actions`. Its token prompt is
  seeded from `config('...settings').entity_types.<type>.default_prompt`.
- **Services** (all autowired): `ai_schemadotorg_jsonld.builder` (`AiSchemaDotOrgJsonLdBuilder`),
  `.manager` (`AiSchemaDotOrgJsonLdManager`), `.token_resolver` (`AiSchemaDotOrgJsonLdTokenResolver`),
  and an `EventSubscriber\AiSchemaDotOrgJsonLdEventSubscriber`.
- **Routes** (`administer site configuration`): `ai_schemadotorg_jsonld.settings`
  (`/admin/config/ai/schemadotorg-jsonld`, `AiSchemaDotOrgJsonLdSettingsForm`) and
  `ai_schemadotorg_jsonld.prompt` (`.../prompt/{entity_type}/{bundle}`, `AiSchemaDotOrgJsonLdPromptForm`).
- **Config**: object `ai_schemadotorg_jsonld.settings` (schema + install defaults). Keys:
  `entity_types.<type>.{default_prompt, default_jsonld}`, `requirements`, `development.edit_prompt`.
- **Config action**: `addField` (`Plugin/ConfigAction/AddField`) — recipe-callable field provisioning.
- **Drush**: `ai_schemadotorg_jsonld:add-field <entity_type> [<bundle>|*]`
  (`Drush/Commands/AiSchemaDotOrgJsonLdCommands`).
- **Hooks** (attribute `#[Hook]`, in `src/Hook/`): `page_attachments` (head JSON-LD),
  `entity_field_access` (JSON-LD field view requires entity `update`), `token_info`/`tokens`
  (the `ai_schemadotorg_jsonld:content` token = entity rendered as anonymous), and several
  `field_widget_complete_*_form_alter` (Copy button, Edit-prompt link).
- **Token**: `[<type>:ai_schemadotorg_jsonld:content]` renders the entity as the anonymous user in
  the site default theme, Xss-filtered, for use inside prompts.

## Data flow (source-grounded)

1. Editor clicks *Generate* → Field Widget Action runs the bundle automator (`llm_json_native_field`).
2. `EventSubscriber::onPreGenerateResponse()` expands the `[ai_schemadotorg_jsonld:requirements]`
   token and HTML-entity-decodes the user prompt before it reaches the LLM (via `drupal/ai`).
3. `EventSubscriber::onValuesChange()` extracts/validates the JSON object out of the LLM reply and
   stores it in `field_schemadotorg_jsonld`.
4. On the entity's canonical route, `AiSchemaDotOrgJsonLdPageHooks::pageAttachments()` adds the
   field value (and any `default_jsonld`) to `html_head` as an `application/ld+json` script tag.

All AI calls go through the `drupal/ai` abstraction (AI Automators + AI events); the module makes no
direct HTTP calls and holds no provider credentials (those live in the AI provider config/Key).
