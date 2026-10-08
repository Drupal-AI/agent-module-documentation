<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring ckeditor_wiris

There is **no module settings form** (`configure: null`, no routes, no config schema). All setup is
done through core's **Text formats and editors** and, for advanced cases, CKEditor 5 JS config.

## 1. Add the buttons to a text format

1. `admin/config/content/formats` → edit (or add) a text format whose editor is **CKEditor 5**.
2. In the CKEditor 5 toolbar builder, drag the **MathType** and/or **ChemType** buttons from
   *Available buttons* into the *Active toolbar*. (The two buttons come from the CKEditor 5 plugin
   `ckeditor_wiris_extension` / `MathType.MathType`, defined in `ckeditor_wiris.ckeditor5.yml`.)
3. Save the format. Any field using that format now shows the equation buttons.

Which authors can insert equations is therefore just "which roles may use this text format" — assign
the format accordingly.

## 2. Allow the `<math>` markup (critical)

The plugin declares `elements: false` in `ckeditor_wiris.ckeditor5.yml`, so it contributes **no**
allowed HTML tags. If the format uses **Limit allowed HTML tags** (`filter_html`), stored `<math>…</math>`
MathML is stripped on save/output unless you explicitly allow it.

- Simplest: use a **Full HTML**-style format (no `filter_html`) for equation authoring.
- Otherwise add the MathML elements/attributes to the *Allowed HTML tags* list (at minimum `<math>` and
  the child elements Wiris emits: `mrow mi mo mn msup msub mfrac msqrt semantics annotation` etc., plus
  their attributes). Over-restricting breaks formulas; be aware this is a trust decision (see §5).

## 3. Render formulas to visitors

This module **does not render equations on the published page** — it only emits MathML. Per the README,
add a renderer:
- Install [MathJax](https://www.drupal.org/project/mathjax) (or another MathML renderer), or
- Rely on browsers with native MathML support.

Without a renderer, authors see the Wiris-generated image in the editor, but visitors may see raw/unstyled
MathML.

## 4. Point at a licensed Wiris service (production)

The bundled build is hardwired to the Wiris **demo** endpoint in
`js/ckeditor5_plugins/MathType/src/integration.js`:

```js
integrationProperties.serviceProviderProperties.URI = 'https://www.wiris.net/demo/plugins/app';
integrationProperties.serviceProviderProperties.server = 'java';
```

The demo service is rate-limited and **not licensed for production**. A real deployment requires a Wiris
licence (see https://www.wiris.com/en/mathtype/) and, in most setups, a self-hosted or Wiris-hosted
service. Changing the endpoint means editing the plugin source and rebuilding the bundle:

```bash
cd web/modules/contrib/ckeditor_wiris
npm install
npm run build   # regenerates js/build/MathType.js — Drupal.org has no build pipeline for /build
```

## 5. Advanced: per-editor CKEditor 5 JS config

`integration.js` reads two CKEditor config keys off the editor instance (not exposed by any Drupal form —
you'd set them by altering the CKEditor 5 settings, e.g. via a custom module/JS):

- **`mathTypeParameters`** — object passed straight into the Wiris integration as
  `integrationParameters` (service/editor parameters, language, custom service config).
- **`wirislistenersdisabled`** — if truthy, the integration skips attaching its element listeners.

## Data-flow / privacy note

Authoring a formula sends the formula content to the configured Wiris service (the demo endpoint by
default) over HTTPS to render the editing image and drive the modal editor. Treat equation authoring as a
third-party data flow in any privacy review, and configure a licensed/appropriate service before going live.
