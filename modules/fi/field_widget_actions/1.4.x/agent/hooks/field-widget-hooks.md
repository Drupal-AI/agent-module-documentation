# Hooks implemented (how the buttons get injected)

All hooks are implemented on the `Drupal\field_widget_actions\Hook\FieldWidgetAction`
service (OOP `#[Hook]` attributes) with thin `#[LegacyHook]` shims in
`field_widget_actions.module`. Integrators rarely call these directly, but they define the
injection points.

| Hook | What it does |
|------|--------------|
| `hook_field_widget_third_party_settings_form` | Builds the **Field Widget Actions** details element on *Manage form display* — the *Add New Action* select (options grouped by plugin `category`, filtered by `getAllowedFieldWidgetActions()` + `isAvailable()`), the AJAX *Add action* / *Remove Action* buttons, drag-sort, and each configured action's own `buildConfigurationForm()`. Shows warnings when configured actions are unavailable. |
| `hook_field_widget_complete_form_alter` | For each enabled, allowed, available action, calls the action's `completeFormAlter()` — this is where **non-multiple** (whole-field) buttons are added. Also wraps "childless" widgets (`select`, `select2`, `tagify_select_widget`) in a `field-widget-actions-container` so the buttons render. |
| `hook_field_widget_single_element_form_alter` | Same iteration, calling `singleElementFormAlter()` — where **multiple** (per-item/delta) buttons are added. Also wraps childless single-element widgets (`options_select`, `select2`, `tagify_select_widget`, `select`). |
| `hook_theme` | Registers the `field_widget_actions_suggestions` theme hook. |
| `hook_config_action_alter` | Registers the `setComponentThirdPartySetting` config action (class `SetupFieldWidgetAction`) for `entity_form_display` entities if not already defined. See [configure/actions.md](../configure/actions.md). |
| `hook_entity_form_display_presave` | Re-keys any `third_party_settings.field_widget_actions` entries that are not valid UUIDs (generating a UUID key) so every action has a stable UUID key. |

Whether a button appears on a delta vs. the whole field is decided by
`FieldWidgetActionBase::completeFormAlter()` / `singleElementFormAlter()` via `isMultiple()`
(the per-action `multiple` config). Buttons with an AJAX callback get a `#validate` handler
(`['::validateForm', clearErrorsForAction]`) that runs full form validation but **suppresses
only "required field is empty" errors** for fields the user has not filled in yet — so
clicking an action button does not force-validate the whole entity, while genuine value
errors (bad format, out of range, custom constraints) are preserved.

## Alter hook this module invokes for others

`hook_field_widget_action_info_alter(array &$definitions)` — alter the discovered
`FieldWidgetAction` plugin definitions (invoked by the manager).

## Update hooks

`field_widget_actions_post_update_ensure_valid_uuids` resaves any entity form display whose
`field_widget_actions` third-party settings use non-UUID keys (legacy list data).
