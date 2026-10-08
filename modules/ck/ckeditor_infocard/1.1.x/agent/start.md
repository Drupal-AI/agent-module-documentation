<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor InfoCard — agent reference

**Version:** 1.1.0 (`1.1.x`) · **Core:** `^10 || ^11` · **Package:** CKEditor · **Depends on:** `drupal:ckeditor5`

Adds an **InfoCard** button/plugin to CKEditor 5. An InfoCard is an inline,
accordion-like control: a short piece of "hint" text that a visitor can click to
expand a hidden block of explanatory content. It is implemented purely with a
`<span>` — no custom entity, block, or config entity. The module is a fork of
*CKEditor Abbreviation*.

There is **no admin settings form and no configuration page** (`data.json`
`configure` is null). The feature is turned on per text format from the standard
CKEditor 5 toolbar configuration.

## What it produces in content

Selecting text and filling in the dialog wraps it in:

```html
<span data-content="…explanation HTML…" class="js-infoCard">hint text</span>
```

- `class="js-infoCard"` — marks the element for the frontend behavior.
- `data-content` — holds the explanation shown when the card is expanded.
- The element text node is the always-visible "hint".

## How the pieces fit together

### Server side (PHP)

- `src/Plugin/CKEditorPlugin/CKEditorInfoCardButton.php` — a **legacy CKEditor 4**
  `@CKEditorPlugin` (id `span`) pointing at `js/plugins/span/plugin.js` and
  `js/plugins/infocard/icons/infoCard.png`. This is leftover from the CKEditor 4
  era and is not used by CKEditor 5; the active integration is the YAML-declared
  CKEditor 5 plugin below. (Note: the referenced icon path does not exist in the
  package.)
- `ckeditor_infocard.ckeditor5.yml` — the real CKEditor 5 plugin definition.
  Declares JS plugin `infocard.InfoCard`, toolbar item `infocard` (label
  "InfoCard"), editing library `ckeditor_infocard/infocard`, admin library
  `ckeditor_infocard/infocard.admin`, and GHS `elements`: `<span>`,
  `<span data-content>`, `<span class="js-infoCard">`.
- `ckeditor_infocard.routing.yml` → route `ckeditor_infocard.infocard_dialog`
  at `/ckeditor_infocard/dialog/infocard/{editor}`, form
  `src/Form/CKEditorInfoCardDialog.php`, requirement `_entity_access: 'editor.use'`.
  This is a **legacy AJAX dialog** (CKEditor 4 style) that returns an
  `EditorDialogSave` command. The CKEditor 5 UI does **not** use this route — it
  uses an in-editor balloon form (see JS). The route/form is effectively dead
  code for CKEditor 5 usage but remains reachable to users with `editor.use`
  access.
- `ckeditor_infocard.module`:
  - `hook_help()` — help text on `help.page.ckeditor_infocard`.
  - `hook_page_attachments_alter()` — **unconditionally attaches**
    `ckeditor_infocard/infocard.frontend` to **every page** on the site.

### CKEditor 5 plugin (`js/ckeditor5_plugins/infocard/src/`, built into `js/build/infocard.js`)

- `index.js` — exports `InfoCard`.
- `infocard.js` — `InfoCard` plugin requires `InfoCardEditing` + `InfoCardUI`.
- `infocardediting.js` — schema + converters. Stores the explanation as the model
  attribute `infoCard` on `$text`. **Downcast:** emits
  `<span class="js-infoCard" data-content="{value}">`. **Upcast:** reads
  `data-content` from `span.js-infoCard` back into the `infoCard` attribute.
- `infocardui.js` — toolbar `ButtonView` + a `ContextualBalloon` form. On submit,
  runs the `addInfoCard` command with `{ infoCard: hint, dataContent: explanation }`;
  a Remove button runs `removeInfoCard`.
- `infocardcommand.js` / `removeinfocardcommand.js` — add / remove the attribute
  over the selected range.
- `infocardview.js` — the balloon `FormView`: a hint text field, a textarea for the
  explanation (created via `createLabeledTextarea`), Save/Cancel/Remove buttons.
- `TextareaView.js`, `utils.js` — a textarea view + `getRangeText` helper
  back-ported from newer CKEditor versions.

### Frontend runtime (`js/infocard.frontend.js` → `.min.js`, library `infocard.frontend`)

`Drupal.behaviors.text` finds every `.js-infoCard`, and for each one:

1. Reads the visible text as the "hint", clears it, and re-adds it inside
   `span.infocard__hint` (via `innerText`, safe).
2. Creates `span.infocard__content`, hidden by default, and sets its body from the
   element's `data-content` attribute **using `innerHTML`** (see
   `js/infocard.frontend.js:79`).
3. Wires click / Enter to toggle open/closed (`is-open` class, `aria-expanded`,
   `display` on the content span).

CSS: `css/infocard.frontend.css` (expand/collapse chevron, content box),
`css/infocard.admin.css` (editor styling).

## Enabling / usage (operator steps)

1. Install and enable the module (`drush en ckeditor_infocard`).
2. **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) → configure a CKEditor 5 format.
3. Drag the **InfoCard** button into the active toolbar.
4. Enable *Limit allowed HTML tags* and allow the InfoCard span markup
   (`<span class="js-infoCard" data-content>`) so it survives filtering.
5. Edit content: select text, click InfoCard, enter the hint + explanation, Save.
   Re-open by placing the cursor in an InfoCard and clicking the button; remove via
   the balloon's Remove button.

## Facts an agent may need

- No `*.permissions.yml` — the module defines **no permissions** of its own
  (access to authoring is governed by core text-format/editor permissions).
- No `config/` directory, no `*.schema.yml` — **no config schema / config entities**.
- No services, no Drush commands, no submodules, no `*.install`, no update hooks.
- No hard external dependency beyond core `ckeditor5`.
- `test_dependencies: ckeditor:ckeditor` (CKEditor 4 contrib) is used only by the
  functional-JS test.
- Frontend assets are attached globally (all pages), not just where an InfoCard is
  present.
