<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Empathy Field Action (ai_empathy_field_action) — submodule

Adds a one-click **"Check Empathy"** button to text-field widgets and an optional
**content-moderation publish gate**. Depends on `ai_empathy` + `field_widget_actions`. Config route
`ai_empathy_field_action.settings` at `/admin/config/ai/empathy/field-action`
(permission `administer ai empathy`).

## The field action

`CheckEmpathyAction` (id **`check_empathy`**), in `src/Plugin/FieldWidgetAction/CheckEmpathyAction.php`,
extends `field_widget_actions`' `FieldWidgetActionBase`. Targets the string/text widgets and field types.
Enabled per field on *Manage form display*. Its AJAX callback `checkEmpathy()` reads the field's current
text (`extractTargetText()`), scores it with `ai_empathy.scoring::scoreResponseGeneral()`, and opens a
modal (`OpenModalDialogCommand`) rendering empathy + explanation-quality as pass/warn/fail badges
(`badgeState()`, threshold within 0.5 = warn). **Nothing is written back to the field** — it only reads
and displays. Modal content is the `ai_empathy_field_action_result` theme; all displayed values are
`number_format`ed floats and a controlled state enum (auto-escaped by Twig).

## The publish gate

Optional, off by default. Config object `ai_empathy_field_action.settings` (`gate_enabled` bool,
`gated_field_names` newline-separated field machine names).

- `AiEmpathyFieldActionHooks::formAlter()` adds a validate handler only when core `content_moderation`
  is installed, the gate is enabled, and the form is a `ContentEntityForm` exposing `moderation_state`.
- `validateModerationGate()` → `EmpathyModerationGate::check()` (`src/Service/EmpathyModerationGate.php`):
  applies only when transitioning to a **published** moderation state; concatenates the configured
  fields' text and scores it. Returns `blocked => score < empathy_alignment_threshold`, which sets a
  form error on `moderation_state`.
- **Fails open**: if the module is absent, the gate is off, the entity isn't moderated, the target state
  isn't a published state, there's no text, or scoring throws, `check()` returns NULL and publishing is
  never blocked. The gate can only *deny* publishing, never mutate or force-publish an entity, and runs
  inside the normal content-form access flow (no `accessCheck(FALSE)`).
