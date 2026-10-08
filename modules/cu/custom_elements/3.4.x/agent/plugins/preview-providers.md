<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CustomElementsPreviewProvider plugin type

Plugin type `custom_elements_preview_provider`. Manager
`plugin.manager.custom_elements_preview_provider`
(`CustomElementsPreviewProviderManager`, discovery dir `Plugin/CustomElementsPreviewProvider`,
annotation `@CustomElementsPreviewProvider` with `id`, `label`, `description`).
Base `CustomElementsPreviewProviderBase` implements `CustomElementsPreviewProviderInterface`.

Preview providers render a `CustomElement` **inside a Drupal UI context** (e.g. the admin preview
of a decoupled component), as opposed to the raw markup/JSON API output. `CustomElement::preview()`
and the `preview` / `preview:<id>` render variants go through them.

## Resolution

`custom_elements.preview_resolver` (`CustomElementsPreviewResolver`) collects all services tagged
`custom_elements.preview_provider`, ordered by priority, and returns the first whose
`isApplicable(Request)` is TRUE (cached on the request). The markup provider is the always-applicable
fallback, so a provider is always found.

Providers registered as services in `custom_elements.services.yml`:
- **`markup`** (`MarkupPreviewProvider`, priority -100) — renders the element as custom-elements
  markup; the guaranteed fallback.
- **`json`** (`JsonPreviewProvider`, priority -110) — JSON representation.
- **`nuxt`** (`NuxtPreviewProvider`) — client-side preview via a Nuxt front end (the
  drunomics component-preview module). Emits a `<div data-component-name data-component-props>`
  container with visually-hidden slot `<div data-slot>` blocks and attaches the
  `custom_elements/nuxt_preview` library + `drupalSettings.customElementsNuxtPreview.baseUrl`.
  Implements `ComponentIndexProviderInterface` (`getComponentIndexUrl()`).

`markup` and `json` are instantiated from the plugin manager via factory service definitions.

## Adding one

Create `Plugin/CustomElementsPreviewProvider/MyProvider.php` with the annotation, extend the base,
implement `preview(CustomElement $element): array` and `isApplicable(Request $request): bool`, and
register it as a service tagged `custom_elements.preview_provider` with a priority (higher wins).
