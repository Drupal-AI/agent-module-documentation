<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embedded Content: Single Directory Components (embedded_content_sdc) — agent index

Bridge module that exposes every **Single Directory Component (SDC)** on the site as an
**Embedded Content** plugin, so editors can insert a component into a CKEditor 5 text field and
map its props/slots. Package `Embedded Content`. Version **1.0.1** (version-dir 1.0.x).
Core `^10.4 || ^11.1`. License GPL-2.0-or-later.

- **How SDC components become embeddable, the deriver, the build/render path, and how an editor
  inserts one** → [plugins/sdc-bridge.md](plugins/sdc-bridge.md)

## What it actually is

- A **submodule of `embedded_content`**. It provides no routes, permissions, services, config,
  or hooks of its own. It ships exactly two PHP classes plus a test component.
- Composer requires `drupal/embedded_content:^2`, `drupal/cl_editorial:^2 || ^3`,
  `e0ipso/schema-forms:^2`. Module deps (info.yml): `embedded_content`, `cl_editorial`.

## What it provides

- One EmbeddedContent plugin: `Component` (id **`sdc`**), in
  `src/Plugin/EmbeddedContent/Component.php`, extending `EmbeddedContentPluginBase`. Its deriver
  turns every SDC component into a derivative (`sdc:<component_id>`).
- The deriver `ComponentDeriver` (`src/Plugin/Derivative/ComponentDeriver.php`) reads
  `plugin.manager.sdc`'s `getAllComponents()` and creates one derivative per component.

## Mechanism (from source)

- `ComponentDeriver::getDerivativeDefinitions()` clones the base definition for each SDC component,
  setting `admin_label`/`label` from the component's `name`.
- `Component::build()` returns `['#type' => 'component', '#component' => <derivative id>,
  '#props' => config['props'], '#slots' => config['slots']]`; slots stored as
  `{value, format}` are converted to `['#type' => 'processed_text', ...]` so rich-text slots
  render through the chosen text format.
- `Component::buildConfigurationForm()` delegates to `cl_editorial_component_mappings_form()`,
  which builds a schema-driven props/slots form from the component's `*.component.yml`.
- `Component::isInline()` returns FALSE (block-level embed).
- Rendering happens in the parent's filter `Drupal\embedded_content\Plugin\Filter\EmbeddedContent`,
  which reads `data-plugin-id`/`data-plugin-config` from `<embedded-content>` tags and renders
  `build()`. Editor gating = the Embedded Content button config + `use text format <id>`.

See [plugins/sdc-bridge.md](plugins/sdc-bridge.md) for the full path and how to operate it.
