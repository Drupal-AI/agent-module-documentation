<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering to markup

## From CustomElement to a render array

`CustomElement::toRenderArray(?string $render_variant = NULL)`:
- `NULL` → resolve the default variant via `custom_elements.render_helper`
  (`CustomElementRenderHelper::getDefaultRenderVariant()`). For API responses (request attribute
  `lupus_ce_renderer` set, or request format `custom_elements`) this is forced to `markup`;
  otherwise it is the `default_render_variant` setting (fallback `markup`). When the default is
  used, `config:custom_elements.settings` is added as a cache tag.
- `'markup'` → `['#theme' => 'custom_element', '#custom_element' => $this]`.
- `'preview'` / `'preview:<id>'` → a preview provider (see `plugins/preview-providers.md`).

Every returned render array carries `#custom_element` (a reference to the object) so downstream
code can detect and re-handle it. `toMarkup(): MarkupInterface` is a shortcut that always renders
the `markup` variant in isolation.

## The theme layer

`hook_theme()` registers `custom_element` (`templates/custom-element.html.twig`) and the
`custom_element__renderless_container` suggestion. `hook_theme_suggestions_custom_element()` adds a
`custom_element__<tag>` suggestion (dashes → underscores).

`template_preprocess_custom_element()`:
- Attaches the `custom_elements/main` library (put your web-component JS there for progressive
  decoupling — it is attached to every rendered element).
- Adds `custom_elements.settings` as a cacheable dependency.
- Builds a Drupal `Attribute` object from `getAttributes()`. **Array** attribute values are
  `json_encode`d; under the `vue-3` style the key is prefixed with `:` so Vue evaluates the JSON to
  an object/array as a bound prop. `MarkupInterface` values are cast to string. Because values are
  set on an `Attribute` object, `{{ attributes }}` **HTML-escapes** them.
- `tag_prefix` = `getTagPrefix()` + `-` (or empty); `tag` = `getTag()`.
- Slots are prepared by markup style.

The template emits `<{{ tag_prefix }}{{ tag }}{{ attributes }}>{slots}</…>`. The
`renderless-container` template renders slots only (no wrapper).

## Markup styles (`markup_style` setting)

- **`web_component`** (default) — `custom_elements_prepare_slots_as_web_component()`. A nested
  `CustomElement` slot gets `slot="<key>"` set on it. A lone `default` slot is emitted bare; other
  string slots are wrapped in `<div slot="<key>">…</div>`. Slot content is rendered as
  `#markup`. Also compatible with Vue 2 legacy slot syntax.
- **`vue-3`** — `custom_elements_prepare_slots_as_vue_3()`. Each non-default slot is wrapped in
  `<template #<key>>…</template>`; a lone `default` slot skips the wrapper.

## Slots — the CustomElement API

Slots are weighted, named, multi-valued entries whose `content` is markup or a nested
`CustomElement`. Key methods: `setSlot()`, `addSlot()`, `setSlotFromRenderArray()` (renders the
array in isolation to markup — avoid where possible), `setSlotFromCustomElement()`,
`addSlotFromCustomElement()`, `setSlotFromNestedElements()`, `removeSlot()`,
`getSortedSlots()` / `getSortedSlotsByName()`. Attribute API: `setAttribute()`, `getAttribute()`,
`removeAttribute()`, `setAttributes()`.

Note: `setSlot()` wraps a plain (non-`MarkupInterface`) string value in `Markup::create()`, so slot
content is treated as HTML markup in the markup path. Slots are intended to carry pre-filtered field
output (e.g. text-format-processed values or nested elements), whereas simple scalar values are
usually mapped to attributes.

No-end tags (`img`, `br`, `input`, …) may not carry slot content (`LogicException`).
