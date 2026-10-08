<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configure & per-bundle field settings

## Install & enable

```bash
composer require drupal/ai_auto_reference
drush en ai_auto_reference -y
# optional, for the inline widget button:
composer require drupal/field_widget_actions
drush en field_widget_actions -y
```

Hard deps: `ai` (drupal/ai `^1.0.4`) and core `node`. `field_widget_actions` is only a Composer
`suggest`; without it the "Generate references with AI" button flow still works. A chat provider must
be configured in **AI core** (`/admin/config/ai/providers`) before anything appears for editors.

## Routes (`ai_auto_reference.routing.yml`)

| Route id | Path | Form | Permission |
|---|---|---|---|
| `ai_auto_reference.ai_auto_reference_settings_form` | `/admin/config/ai/auto-reference` | `SettingsForm` | `administer ai autoreference` |
| `ai_auto_reference.node_bundle.settings` | `/admin/structure/types/manage/{node_type}/ai-autoreference` | `EntityBundleSettingsForm` | `administer ai autoreference` |
| `ai_auto_reference.edit_form` | `.../{node_type}/ai-autoreference/{field_name}/edit` | `AutoReferenceEditForm` | `administer ai autoreference` |
| `ai_auto_reference.delete_form` | `.../{node_type}/ai-autoreference/{field_name}/delete` | `AutoReferenceDeleteForm` | `administer ai autoreference` |

The per-bundle form is also reachable as a `node_type` entity operation and a local task ("AI
auto-reference"), both added by `ai_auto_reference.module` / `ai_auto_reference.links.task.yml`. There
is **no route for generation itself** — that runs inside the node edit form (batch submit handler) or
the Field Widget Actions AJAX endpoint, both gated by `access ai auto-reference suggestion tools`.

## Permissions (`ai_auto_reference.permissions.yml`)

- `administer ai autoreference` — all config/admin routes above; also controls the node_type operation.
- `access ai auto-reference suggestion tools` — lets a user generate/apply suggestions on node forms.
  Checked in `hook_form_node_form_alter`, `AutoReferenceApplyForm::submitForm`,
  `AiAutoReferenceFormSuggestion::isAvailable()` / `buildModalForm()`. Update hook `_update_10005`
  back-grants it to roles that could already edit configured bundles.

## Global settings — `SettingsForm` → config object `ai_auto_reference.settings`

Editable at the settings route. Keys (schema in `config/schema/ai_auto_reference.schema.yml`,
install defaults in `config/install/ai_auto_reference.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `provider` | string | `''` | AI provider+model in `provider__model` form (from `AiProviderPluginManager::getSimpleProviderModelOptions('chat')`). Empty → nothing shows for editors. |
| `token_limit` | integer | `16000` | Max tokens per API call; drives the summarise/crop logic in the generator. |
| `auto_apply_suggestions` | boolean | `false` | If TRUE, skip the review screen and save suggestions directly (Generate-button route only, **not** the widget-action route). |
| `auto_apply_relevance_levels` | sequence(string) | `['high','medium']` | Which relevance levels auto-apply when the above is on. `validateForm()` requires at least one when auto-apply is enabled. |
| `bundles.{entity_type}.{bundle}.hide_generate_button` | boolean | — | Per-bundle: hide the "Generate references with AI" button (set from `EntityBundleSettingsForm`). |

Note: in the UI the "medium"/low checkbox is labelled "Low Relevance" but the stored value is
`medium`. Update hooks: `_update_10001` seeds relevance defaults; `_update_10006` clears legacy
`service` / `service_model` / `service_api_key` keys and ensures `provider` exists.

## Per-bundle field settings — `EntityBundleSettingsForm`

At `/admin/structure/types/manage/{node_type}/ai-autoreference` you build a table of reference fields
to auto-populate. For each row you pick:

- **Target field** — only `entity_reference` `FieldConfig` fields whose `target_type` is `node` or
  `taxonomy_term` are listed (`buildTable()`); one config per field.
- **View mode** — the node is rendered in this view mode and converted to Markdown as the content sent
  to the model.
- **Prompt** — an `ai_prompt` config entity of type `auto_reference` (see below).

These are **not** stored in `ai_auto_reference.settings`; they are saved as **third-party settings on
the default `entity_form_display`** (`node.{bundle}.default`) under key `ai_auto_reference`, shape
`{field_name: {view_mode, prompt}}` (schema:
`config/schema/ai_auto_reference.entity_display.schema.yml`). `AutoReferenceEditForm` edits one row
(and shows a `#states` warning if a single/multiple prompt mismatches the field cardinality);
`AutoReferenceDeleteForm` unsets it. The service reads them back via
`AiReferenceGenerator::getBundleAiReferencesConfiguration()`, which only returns rows that have both a
`view_mode` and a `prompt`.

## Prompts (shipped config entities)

Provided by AI core's `ai_prompt` / `ai_prompt_type` config entity system (installed via
`config/install/`):

- `ai.ai_prompt_type.auto_reference` — the prompt **type**, declaring variables `contents` and
  `possible_results` (both required).
- `ai.ai_prompt.auto_reference__default_multiple` — "Default prompt for multiple target references";
  asks for two-to-four highly/moderately relevant options as JSON with keys `highly` + `moderately`.
- `ai.ai_prompt.auto_reference__default_single` — "Default prompt for a single target reference"; asks
  for one option, JSON with key `highly` only. Use for cardinality-1 fields.

Prompt bodies use `{contents}` and `{possible_results}` placeholders that the generator replaces.
Site builders can edit these or add new `auto_reference`-type prompts in AI core's prompt library
(`entity.ai_prompt.collection`); the bundle/edit forms list all prompts where `type = auto_reference`.
`ai_auto_reference.install::_update_10004` migrated the module's old bespoke prompt config into these
AI-core prompt entities.

## Fallback / notices

- `SettingsForm` and `EntityBundleSettingsForm` show a "Tip" status message nudging you to install and
  configure Field Widget Actions when it is missing or not yet wired to a form display.
- `EntityBundleSettingsForm` shows a warning when no `provider` is configured.
- `config/schema/ai_auto_reference.prompt.schema.yml` still declares the deprecated
  `ai_auto_reference.ai_auto_reference_prompt.*` config-entity schema (kept for the pre-10004 migration);
  live prompts are the AI-core `ai_prompt` entities.
