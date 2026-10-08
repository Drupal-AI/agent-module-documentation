<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The SDC → Embedded Content bridge

How `embedded_content_sdc` exposes Single Directory Components as insertable Embedded Content and
renders them. All behavior lives in two classes; there is no config, routing, permission, or
service file in this module.

## Install / enable

`composer require drupal/embedded_content_sdc` (pulls `drupal/embedded_content`,
`drupal/cl_editorial`, `e0ipso/schema-forms`), then `drush en embedded_content_sdc`. Core
`^10.4 || ^11.1`. SDC is core; no extra library. To make components insertable you still configure
Embedded Content in the parent module (below).

## The deriver — one derivative per SDC component

`src/Plugin/Derivative/ComponentDeriver.php` implements `ContainerDeriverInterface`.

- `create()` injects `plugin.manager.sdc` (`ComponentPluginManager`).
- `getDerivativeDefinitions($base)` loops `$componentPluginManager->getAllComponents()`; for each
  `$component` it sets `$this->derivatives[$component->getPluginId()] = $base` and copies the
  component's `name` into both `admin_label` and `label`.
- Result: the single `sdc` plugin fans out into `sdc:<theme_or_module>:<component>` derivatives —
  every SDC on the site (theme- or module-provided) becomes a selectable embed option. There is no
  filtering here; which components an editor may actually insert is decided by the Embedded Content
  button config, not by this deriver.

## The plugin — form, build, render element

`src/Plugin/EmbeddedContent/Component.php` — `@EmbeddedContent(id = "sdc", deriver =
ComponentDeriver::class)`, extends `EmbeddedContentPluginBase`, implements
`EmbeddedContentInterface` + `ContainerFactoryPluginInterface`. Injects `plugin.manager.sdc`.

- `buildConfigurationForm($form, $form_state)` calls
  `cl_editorial_component_mappings_form($this->getDerivativeId(), $this->configuration, $form,
  $form_state)`. That cl_editorial helper (in `cl_editorial.module`) uses `ComponentInputToForm`
  + `cl_editorial.form_generator` (schema-forms `FormGeneratorDrupal`) to generate form fields
  from the component's `*.component.yml` `props`/`slots` schema. This is the editor's mapping UI.
- `build()` returns:
  - `#type => 'component'`, `#component => <derivative id>`,
  - `#props => $this->configuration['props'] ?? []`,
  - `#slots => $this->configuration['slots'] ?? []`.
  It then rewrites any slot shaped `{value, format}` (exactly two keys) into
  `['#type' => 'processed_text', '#text' => value, '#format' => format]`, so a rich-text slot is
  rendered through the selected text format's filter pipeline. Core's `#type: component` element
  (ComponentElement / `ComponentPluginManager`) validates props against the component schema and
  renders the component's Twig template with the props/slots.
- `isInline()` returns FALSE (rendered as a block, wrapped in `<embedded-content>` rather than the
  inline variant).

## End-to-end render path (parent module)

1. Editor clicks the Embedded Content CKEditor 5 button, picks an SDC component, and fills the
   mapping form; the CKEditor plugin stores an `<embedded-content data-plugin-id="sdc:…"
   data-plugin-config="{props,slots}">` tag in the field markup.
2. On output, `Drupal\embedded_content\Plugin\Filter\EmbeddedContent::process()` walks
   `<embedded-content>` / `<embedded-content-inline>` nodes, JSON-decodes `data-plugin-config`,
   `createInstance($plugin_id, $config)`, calls `$instance->build()`, renders it in a
   `RenderContext`, and swaps the placeholder node for the rendered component (bubbling cache
   metadata/attachments).
3. The live CKEditor preview uses `EmbeddedContentPreviewController::preview()` (route
   `embedded_content.preview`, `_csrf_token: TRUE`, access = `use text format <id>`), which
   `Xss::filter`s the incoming plugin id/config before instantiating and rendering.

## How an editor inserts one (operate it)

- Enable a text format's **Embedded content** filter and add the Embedded Content button to that
  format's CKEditor 5 toolbar (parent module).
- At `/admin/config/content/embedded-content/button`, configure the button and choose which
  embedded-content plugins are allowed — include the `sdc` component(s) you want editors to use.
- Editors with `use text format <id>` then get the button; selecting a component shows the
  schema-generated props/slots form. Access to the button/preview is gated by the text-format
  permission; administering buttons requires `administer embedded content`.

## Files

- `src/Plugin/EmbeddedContent/Component.php` — the `sdc` plugin (form, build, slot handling).
- `src/Plugin/Derivative/ComponentDeriver.php` — enumerates SDC components into derivatives.
- `tests/modules/embedded_content_sdc_test/components/foo/*` — a sample SDC (`foo.component.yml`
  with `text` + `attributes` props, `foo.twig` `<div {{ attributes }}>{{ text }}</div>`).
- No `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.module`, or `config/` in this
  module — all inherited from `embedded_content` / `cl_editorial`.
