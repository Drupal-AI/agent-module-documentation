<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CKEditor 5 plugin (ckeditor_wiris internals)

This module is a **CKEditor 5 build plugin**, not a Drupal plugin type. It defines no PHP plugin
manager. Source lives in `js/ckeditor5_plugins/MathType/src/`; the shipped bundle is
`js/build/MathType.js` (built via `webpack.config.js` + `babel.config.js`). Read this to extend/theme the
front end or to understand how equations are stored and round-tripped.

## Registration

`ckeditor_wiris.ckeditor5.yml` → `ckeditor_wiris_extension`:
- CKEditor 5 plugin class: `MathType.MathType` (exported from `src/index.js` → `src/plugin.js`).
- Toolbar items: `MathType`, `ChemType`.
- `elements: false` — the plugin advertises **no** allowed data-model elements to Drupal's filter
  (so allowed-HTML for `<math>` must be configured on the text format; see configure doc).

## Main plugin (`plugin.js`, class `MathType extends Plugin`)

`init()` wires up, in order:
- **`_addIntegration()`** — builds a `CKEditor5Integration` (see below) with
  `serviceProviderProperties.URI = 'https://www.wiris.net/demo/plugins/app'`, registers a double-click
  handler that reopens the Wiris modal on an existing formula image.
- **`_addCommands()`** — `editor.commands.add('MathType', new MathTypeCommand(editor))` and
  `'ChemType'` → `ChemTypeCommand`.
- **`_addViews(integration)`** — adds the toolbar `ButtonView`s, gated by `Configuration.get('editorEnabled')`
  / `Configuration.get('chemEnabled')`; icons `theme/icons/ckeditor5-formula.svg` / `ckeditor5-chem.svg`.
- **`_addSchema()`** — registers a model element **`mathml`** (`inheritAllFrom: '$inlineObject'`,
  `allowAttributes: ['formula']`). This is how a formula is represented in the CKEditor model.
- **`_addConverters(integration)`** — the up/downcast pipeline (below).
- **`_exposeWiris()`** — sets **`window.WirisPlugin`** = `{ Core, Parser, Image, MathML, Util,
  Configuration, Listeners, IntegrationModel, Latex, currentInstance }` for external/theming code.

## Commands (`commands.js`)

- `MathTypeCommand.execute({ integration })` — requires a valid `CKEditor5Integration`; opens the Wiris
  editor, either editing the selected formula image (`openExistingFormulaEditor`) or a new one
  (`openNewFormulaEditor`).
- `ChemTypeCommand extends MathTypeCommand` — same, but `setEditor()` enables the `chemistry` custom editor.

## Conversion / storage model (`plugin.js` `_addConverters`)

- **Data → model (upcast)**: an incoming `<math>` element is serialized (via the local `XmlDataProcessor`,
  `engine/xmldataprocessor.js`), run through `Util.htmlSanitize`, and stored as a `mathml` model element
  with a `formula` attribute; a `<math>` carrying a `LaTeX` annotation is instead turned into a `$$…$$`
  text node (`Parser.initParse`).
- **Model → editing view (downcast)**: `mathml` → a `<span class="ck-math-widget">` widget wrapping an
  `<img>` produced by `Parser.initParse` (the Wiris-rendered formula image). The img is created with
  `renderUnsafeAttributes: ['src']` so the Wiris service URL survives CKEditor's URL sanitization —
  the `src` points at the configured Wiris service.
- **Model → data (downcast)**: `mathml` → the raw `<math>` MathML via `Parser.endParseSaveMode`, so the
  content **saved to the field is MathML**.
- `editor.data.get`/`set` are monkey-patched to convert `$$latex$$` ⇄ `<math>` (LaTeX annotation) and to
  keep `&lt;`/`&gt;` entities intact for the Wiris renderer.

## Integration (`integration.js`, `CKEditor5Integration extends IntegrationModel`)

Bridges CKEditor 5 to the Wiris `@wiris/mathtype-html-integration-devkit`. Notable pieces:
`insertMathml()` (inserts/replaces the `mathml` element, preserving selection formatting),
`insertFormula()` (handles MathML and LaTeX edit modes), `doubleClickHandler()` (reopen editor),
`getLanguage()`, and a `Telemeter.track("INSERTED_FORMULA", …)` telemetry call on insert.
Reads `editor.config.get('mathTypeParameters')` → Wiris `integrationParameters`, and honors
`editor.config.wirislistenersdisabled`.

## Extending / rebuilding

To change behavior or the service endpoint you edit the `src/` files and rebuild — Drupal.org ships no
build step for `/build`, so the bundle must be committed:

```bash
cd web/modules/contrib/ckeditor_wiris
npm install && npm run build   # regenerates js/build/MathType.js
```

The README documents the CKEditor 5 import rewrites needed when updating the upstream Wiris plugin
(`ckeditor5/src/core`, `ckeditor5/src/ui`, `ckeditor5/src/engine`).
