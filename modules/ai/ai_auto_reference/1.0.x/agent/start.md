<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Auto-reference (ai_auto_reference) — agent index

Uses an LLM to **suggest or auto-fill entity-reference fields on node forms**, pointing content at
related **nodes / taxonomy terms** already in the site. Per node bundle you map a reference field to a
**view mode** (the content sent to the model) and an **ai_prompt** (the instruction). Depends on
`ai:ai` and core `node`; optionally uses `field_widget_actions` (a `suggest`, not a hard dep). Package
*AI Auto-reference*. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0-rc6.

## Two ways editors get suggestions

- **"Generate references with AI" button** (next to Save on the node edit form) → runs a Batch →
  redirects back to the edit form with an apply/review form at the top. → [api/generation.md](api/generation.md)
- **Inline "AI Suggested References" Field Widget Action button** on the reference widget → modal of
  checkboxes/radios to insert (needs `field_widget_actions`). → [plugins/field_widget_action.md](plugins/field_widget_action.md)

## What it provides

- **Service** `ai_auto_reference.ai_references_generator` → class `AiReferenceGenerator`
  (`src/AiReferenceGenerator.php`). Core logic: `getBundleAiReferencesConfiguration()`,
  `getFieldAllowedValues()` (access-aware candidate list), `getAiSuggestions()`, `aiApiCall()`.
- **Batch** `AiReferenceBatch` (`src/Batch/AiReferenceBatch.php`) — one operation per configured field,
  optional auto-apply on finish.
- **FieldWidgetAction plugin** `ai_auto_reference_form_suggestion` (`AiAutoReferenceFormSuggestion`) —
  the module *defines no plugin types of its own*; this consumes the type from `field_widget_actions`.
- **Forms**: `SettingsForm` (global), `EntityBundleSettingsForm` (per bundle field table),
  `AutoReferenceEditForm` / `AutoReferenceDeleteForm` (per field), `AutoReferenceApplyForm` (review/apply,
  injected into the node form by `hook_form_node_form_alter`).
- **Routes** (all under `administer ai autoreference` except generation, which is gated by
  `access ai auto-reference suggestion tools`): see [config/settings.md](config/settings.md).
- **Config**: object `ai_auto_reference.settings`; per-field data stored as `entity_form_display`
  **third-party settings** (`view_mode` + `prompt`); two shipped `ai.ai_prompt.*` entities and one
  `ai.ai_prompt_type.auto_reference`. → [config/settings.md](config/settings.md)

## Permissions

- `administer ai autoreference` — settings + per-bundle config + edit/delete forms.
- `access ai auto-reference suggestion tools` — generate/apply suggestions on node forms.

## Docs

- Install, routes, permissions, config objects, schema, prompts, per-bundle field settings →
  [config/settings.md](config/settings.md)
- The generator service, token handling, the Batch + apply/review flow →
  [api/generation.md](api/generation.md)
- The Field Widget Action modal button (widgets, modal, insert commands) →
  [plugins/field_widget_action.md](plugins/field_widget_action.md)
