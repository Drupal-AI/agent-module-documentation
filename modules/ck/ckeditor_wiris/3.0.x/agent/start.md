<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Wiris (ckeditor_wiris) — agent index

Adds Wiris **MathType** (math) and **ChemType** (chemistry) equation-editor buttons to **CKEditor 5**.
Authors compose formulas in a Wiris modal; the formula is inserted as an image widget and **stored as
`<math>` MathML** in the content. Depends only on core `ckeditor5`.

**This module is entirely client-side.** `.module` is empty; there are **no** routes, controllers,
services, filter plugins, permissions, or config schema. Everything ships as a compiled CKEditor 5
build (`js/build/MathType.js`, source under `js/ckeditor5_plugins/MathType/`) plus two CSS files. So
there is no Drupal PHP attack surface and nothing to configure in a settings form — integration is
done purely through **text-format / CKEditor 5 toolbar** configuration.

Establish before recommending:
- **Release is `3.0.0-alpha4` (alpha).** Core requirement `^10 || ^11` (composer says `^9.3 || ^10 || ^11`).
- **MathType/ChemType are commercial Wiris products.** This module is only the integration. The bundled
  plugin is hardwired to the Wiris **demo** service `https://www.wiris.net/demo/plugins/app` (see
  `integration.js`) — rate-limited, **not licensed for production**. Production needs a Wiris licence and
  (typically) a self-hosted/hosted Wiris service. Formula rendering and the modal editor call that
  service, so equation authoring is a **data-flow/privacy** question (formula content is sent to Wiris).
- **The module does not render formulas on the public page.** It emits MathML; per the README you must
  add a renderer such as [MathJax](https://www.drupal.org/project/mathjax) (or rely on native browser
  MathML) to display equations to visitors.
- **The text format must allow `<math>`** and its child elements, or the format's HTML filter strips
  saved formulas. The CKEditor 5 plugin declares `elements: false`, so it contributes **no** allowed-tags
  of its own.

## What you'd do → where

- **Turn it on for authors: add MathType/ChemType to a text format, allow `<math>`, wire up a renderer,
  point at a licensed Wiris service, per-editor JS config keys** → [configure/ckeditor_wiris.md](configure/ckeditor_wiris.md)
- **Understand the CKEditor 5 plugin internals: the `mathml` model element, up/down-cast converters,
  commands, the `window.WirisPlugin` global, LaTeX handling** → [plugins/ckeditor_wiris.md](plugins/ckeditor_wiris.md)

## Key facts (real names)

- CKEditor 5 plugin definition: `ckeditor_wiris.ckeditor5.yml` → id `ckeditor_wiris_extension`, CKEditor
  plugin `MathType.MathType`, toolbar items **`MathType`** and **`ChemType`**, `elements: false`,
  library `ckeditor_wiris/ckeditor_wiris`, admin library `ckeditor_wiris/ckeditor_wiris.admin`.
- Libraries (`ckeditor_wiris.libraries.yml`): `ckeditor_wiris` = `js/build/MathType.js` (minified,
  `preprocess: false`) + `css/wiris.ckeditor.css`, depends on `core/ckeditor5`;
  `ckeditor_wiris.admin` = `css/wiris.admin.css`.
- Dependency: `drupal:ckeditor5` (info.yml). Composer requires only `drupal/core`. Package `CKEditor5`.
  No submodules.
- JS plugin source (`js/ckeditor5_plugins/MathType/src/`): `plugin.js` (main `MathType` plugin,
  class name `MathType`), `commands.js` (`MathTypeCommand`, `ChemTypeCommand`), `integration.js`
  (`CKEditor5Integration extends IntegrationModel`), `engine/xmldataprocessor.js`,
  `engine/basichtmlwriter.js`, `index.js`. Built with webpack (`webpack.config.js`); bundles the
  Wiris `@wiris/mathtype-html-integration-devkit` devkit (upstream pkg `@wiris/mathtype-ckeditor5` 8.8.3).
- Service endpoint (hardcoded in `integration.js`): `serviceProviderProperties.URI =
  'https://www.wiris.net/demo/plugins/app'`, `server = 'java'`.
- Per-editor CKEditor JS config read by the plugin: `mathTypeParameters` (Wiris integration params) and
  `wirislistenersdisabled` (skip listener attach). These are CKEditor config, not exposed by a Drupal form.
- Global exposed on `window.WirisPlugin` (Core, Parser, Image, MathML, Util, Configuration, Listeners,
  IntegrationModel, Latex, currentInstance).
- No `configure` route (`configure: null`), no permissions, no Drush, no config schema, no plugin types.
