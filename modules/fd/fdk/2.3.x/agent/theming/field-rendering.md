<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How FDK renders fields (preprocess + template override)

FDK applies its saved settings by (a) providing its own `field.html.twig`, (b) swapping that template in
for core's copy, and (c) preprocessing the field render array to feed the template.

## Template override

- `fdk_theme_registry_alter()` (`fdk.module`) sets `field` template path to FDK's `templates/` directory
  **only when the current field template still comes from `core`** (`strpos($path, 'core') !== 0`
  returns early otherwise). This means a real theme override of `field.html.twig` keeps precedence — and
  is exactly why such themes must adopt FDK's template variables (see report doc).
- `templates/field.html.twig` is a copy of core's `@stable` field template with three added tag
  variables and delimiter handling. It renders each value as `{{ item.content }}` — the standard
  auto-escaped render-pipeline output; labels via `{{ label }}`. Wrapper elements are emitted as
  `<{{ field_wrapper_tag }}>`, `<{{ label_tag|default('div') }}>`, `<{{ field_item_wrapper_tag }}>`.

## Preprocess (`fdk_preprocess_field`)

Runs for every field. It initialises `label_tag`, `field_wrapper_tag`, `field_item_wrapper_tag` all to
`div`, `fdk_acted = FALSE`, and ensures `title_attributes` / `field_wrapper_attributes` exist. When the
render element has `#third_party_settings['fdk']` it:

- Normalises settings via `FDKHelper::prepareConfigurationSettings()`.
- **Label:** if not a Layout Builder element and `label.value` set, overrides `variables['label']`.
  If `label.html_element != '_default'`, merges attributes (from `FDKHelper::getAttributesFromConfig()`),
  adds cleaned classes (`Html::cleanCssIdentifier`), and sets `label_tag` (or the `_other` custom tag).
- **Field wrapper:** if `field_wrapper.html_element != '_default'`, merges
  `field_wrapper_attributes`, adds classes, sets `field_wrapper_tag`, and sets
  `variables['multiple']` from `force_multiple`.
- **Item wrapper:** if `field_item_wrapper.html_element != '_default'`, builds an `Attribute` object,
  adds classes, and — when the element is `a` — sets `href` from
  `\Drupal::token()->replace($settings['field_item_wrapper']['html_element_link_href'], $token_data, ['clear' => TRUE])`;
  then merges that Attribute into every `items[delta]['attributes']`.
- **Delimiter:** copies `field_delimiter` into variables; if `include_and`, sets `and_value = t('and')`.

## Attribute building & tokens

`FDKHelper::getAttributesFromConfig($attributes_string, $token_data)` splits the textarea into lines,
parses each `attribute|value` with `/^([\w]+(\-[\w]+)*)\|(.*)$/`, and (when `$token_data` present) runs
`\Drupal::token()->replace()` on the value. Results are placed into Drupal `Attribute` objects, which
handle escaping when rendered. Token data is the field's entity, keyed by entity type, added only when
`$entity->id()` is available (skipped during Layout Builder preview).

## Notes for agents

- FDK affects **markup only** — field content and field access are unchanged (values still come through
  the normal render pipeline as `item.content`).
- If FDK settings appear to have no effect, a theme's own `field.html.twig` override is likely winning;
  it must be rebuilt on FDK's template variables. Use the report at `/admin/reports/fdk`.
