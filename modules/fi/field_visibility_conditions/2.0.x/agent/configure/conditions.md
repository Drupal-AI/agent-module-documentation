# Configuring field visibility conditions

## Step 1 — choose which conditions are available (global)

- Page: `/admin/config/content/field-visibility-conditions` (route
  `field_visibility_conditions.settings`, form
  `FieldVisibilityConditionsSettingsForm` extending
  `conditions_helper\Form\ConditionSelectorSettingsFormBase`).
- Permission: `administer field visibility conditions` (`restrict access: TRUE`).
- Stored in config object `field_visibility_conditions.settings`, key `enabled_conditions`
  (sequence of condition plugin IDs). Default install value: `{}` (empty).

## Step 2 — set conditions per field

- On any field's config edit form (`field_config_edit_form`), the module (`FormAlters::fieldConfigEditFormAlter`)
  injects a **"Field Visibility"** details element under `third_party_settings.field_visibility_conditions`.
- The condition sub-form is built by `conditions_helper.form_builder->buildConditionsForm()` from the
  enabled conditions and the site's available contexts.
- On save, `FormAlters::fieldConfigEditFormSubmit` (prepended to the form's submit handlers) calls
  `submitConditionsForm()`, persisting the conditions into the field's third-party settings.
- Schema: `field.field.*.*.*.third_party.field_visibility_conditions` — a sequence of
  `condition.plugin.[%key]` entries. This travels with the field config (portable, exportable).

## Step 3 — runtime enforcement

- `hook_form_alter` → `FormAlters::formAlter()` runs on fieldable entity forms (and, via
  `hook_inline_entity_form_entity_form_alter`, on IEF sub-forms).
- It resolves the form's entity_type/bundle (for entity_browser `entity_form` widgets it reads the
  widget's configured entity_type/bundle), loads each `FieldConfig` field on that bundle, reads its
  `field_visibility_conditions` third-party settings, and evaluates them with
  `conditions_helper.evaluator->evaluateConditions()`.
- If the result is `FALSE`, it sets `$form[$field_name]['#access'] = FALSE` (field removed from the
  form). Fields with no stored conditions are left untouched (visible).

## Scope / caveats

- Affects **form rendering** only — not the entity display/view of stored values and not read
  access to data. It is a UX/authoring convenience, not access control. If a condition can't be
  evaluated it defaults to showing the field (fails open), which is expected for a visibility helper.
