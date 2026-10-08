<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Form — configuration & rule syntax

## Install / enable
`composer require drupal/advancedform` then enable `advancedform`. No dependencies. On enable the
install config `config/install/advancedform.settings.yml` seeds `rules_global: ""`. Grant the
`administer advanced form settings` permission to roles that should edit the rules.

## Settings form
- Route: `advancedform.settings_form` → `/admin/config/advancedform/settings`
  (permission `administer advanced form settings`, `_admin_route: TRUE`; menu link under
  Configuration → System).
- Class: `Drupal\advancedform\Form\AdvancedFormSettingsForm` (extends `ConfigFormBase`,
  `getFormId()` = `advancedform_settings_form`, editable config `advancedform.settings`).
- Single field `rules_global`: a textarea, one rule per line.
- `submitForm()` trims the input and saves to `advancedform.settings:rules_global` **only when the
  trimmed value is non-empty** — submitting an empty textarea does not clear a previously saved value
  (parent `ConfigFormBase::submitForm` runs first, but the `->set()->save()` is guarded by `!empty`).

## Config object & schema
- Object: `advancedform.settings`, key `rules_global` (schema `advancedform.schema.yml`,
  `type: text`; the schema `label` is a leftover "Message to display when in maintenance mode" and is
  cosmetic only).

## Rule syntax → generated CSS
`Drupal\advancedform\Service\CssGenerator::cssFromRules(string $rules): string` (service
`advancedform.cssgenerator`) parses each line as `<selector>:[<inner selector>]`:
- The part **before the first `:`** (`strstr($rule, ':', TRUE)`) is the base selector.
- The part **from `[` onward** with `[` and `]` stripped is appended as an inner selector.
- Each line becomes: `form.advanced-form-filtered<selector><inner> { display: none; }`.

Examples (from README / form description):
- `.node-form: [#edit-revision-information]` → hides the revision-info fieldset on node forms.
- `.node-form:[.selected-landing-page #edit-revision-information]` → hides it only when the
  "Landing page" option is selected (see context classes below).

The generated CSS is injected by `advancedform_form_node_form_alter()` as a render element
`#type => html_tag`, `#tag => style`, `#value => $cssGenerator->cssFromRules($rules)`. Core's
`HtmlTag::preRenderHtmlTag()` passes a plain-string `#value` through `Xss::filterAdmin()` before
output. Inspect the rendered element `edit-advancedform-css` to debug.

## Body / context classes (how conditional rules work)
`advancedform_form_node_form_alter()` adds to the node form:
- `advanced-form-filtered` — the class the generated `display:none` rules key off of; the JS toggle
  adds/removes it to hide/reveal fields.
- `role-<machine_name>` for each role of the current user — lets rules target roles.

`js/advanced-form.js` (`Drupal.behaviors.advancedform`, deps `core/drupal`, `core/once`):
- Prepends a toggle button ("Show additional fields" / "Hide additional fields") to each `.node-form`.
- For every `.field--widget-options-select select`, on load and on `change` it adds a
  `selected-<label>` class (lowercased, spaces → `-`) per selected option to the form, so rules like
  `.selected-landing-page …` apply conditionally. `_none`/empty values are ignored.

## Operating notes
- Applies to **node forms only** (`hook_form_node_form_alter`), not arbitrary forms.
- Hiding is client-side CSS/JS: fields remain in the DOM, are still validated and submitted. This is a
  declutter aid, not a way to restrict access — enforce real restrictions with field access /
  permissions.
