<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How COI detects & handles overrides

## Ordering

`coi_module_implements_alter()` reorders `hook_form_alter` so COI runs **after**
`config_override_core_fields` (which sets the `#config['key']` hints). Without that dependency
present COI has nothing to act on.

## The alter (`CoiFormAlterations::alterTree`)

Service `coi.form_alterations` (args `@config.factory`, `@token`) recurses the form. For each
element:

1. Skip if `#access` is false or `#disabled` is already set.
2. Require `#config['key']` **or** `#config_data_store['key']` (core WIP
   [#2408549](https://www.drupal.org/project/drupal/issues/2408549)); else skip.
3. `[$configBin, $configKey] = explode(':', $key)` and
   `$config = \Drupal::config($configBin)`.
4. `$hasOverrides = $config->hasOverrides($configKey)`.
5. **Styling** (if `styling.selectors`): always add class `config`; if overridden add
   `config--overridden`; always add `config--<bin>` and `config--<bin>--<key>` (dots → dashes,
   via `Html::getClass`).
6. If **not** overridden, stop here (classes only).
7. Compute the shown value: the real `$config->get($configKey)` when
   `overridden_value.enabled` and the element isn't secret (or `overridden_value.secrets` is
   on); otherwise the literal `- Overridden value -`.
8. Apply `override_behavior`:
   - `disable` → `#disabled = TRUE`; if `overridden_value.element`, set `#default_value` to
     the shown value.
   - `noaccess` → `#access = FALSE`.
9. If `message.enabled`, set `#coi_override_message` to the tokenized `message.template` with
   `coi:active-value` = `$config->getOriginal($configKey, FALSE)` (value before overrides) and
   `coi:overridden-value` = the shown value.

## Rendering the message

`coi_element_info_alter()` adds `coi_element_preprocessor` as a `#process` on all element
types; when `#coi_override_message` is set it appends the `coi_container` theme wrapper. The
`coi_container` theme (`coi-container.html.twig`, `template_preprocess_coi_container`) renders
the children then `<div class="description"><strong>{{ override_message }}</strong></div>`.

## Tokens

`hook_token_info` / `hook_tokens` define the `coi` token type with:
- `coi:active-value` — the active value **before** overrides are applied.
- `coi:overridden-value` — the override value (not set when no override applies).

These are only populated inside the override message replacement (the data is passed in as
`$data['coi']`).

## Notes for an agent

- COI stores **no per-field state**; its only config is `coi.settings`
  (see [configure/settings.md](../configure/settings.md)). Whether a field reacts depends
  entirely on `Config::hasOverrides()` at request time.
- To make a field react in a test, create a real override (e.g. `$config['system.site']['name']`
  in `settings.php`) for a key that `config_override_core_fields` hints
  (`system.site:name`, `system.performance:cache.page.max_age`, …).
- The `#config` hint convention comes from `config_override_core_fields`
  (`../../../config_override_core_fields/4.0.x/agent/api/form-config-hints.md`); COI is the
  consumer.
