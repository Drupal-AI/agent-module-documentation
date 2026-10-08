<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Embedded Content lets developers define reusable, configurable components (as plugins) that editors can insert into CKEditor 5 content through a button and dialog — without granting the editors permission to write raw HTML or set CSS classes.

---

The module defines an **`embedded_content` plugin type**: each plugin (annotation `@EmbeddedContent`,
extending `EmbeddedContentPluginBase`, placed in `Plugin/EmbeddedContent/`) implements `build()` to
return a render array, an optional configuration form, and `isInline()`. Site builders then create one
or more **Embedded content button** config entities (`embedded_content.button.*`) — each button has an
SVG icon, a singular label, modal/submit text, dialog size, and optional `conditions` that whitelist
which plugins it may insert. Each button becomes a **CKEditor 5 toolbar item** (derived per button)
and, combined with the **`embedded_content` text filter**, a full round trip: the editor clicks the
button, picks a plugin, fills its config form in a modal, and the module inserts an
`<embedded-content data-plugin-id=… data-plugin-config=…>` tag that is upcast to a live preview in the
editor. On output, the filter replaces those tags with the plugin's rendered `build()` markup (adding
its attachments). Access is controlled by `administer embedded content` plus a dynamically generated
`use <button_id> embedded content button` permission per button. Out of the box the module ships **no
concrete plugins** (only a CKEditor plugin, filter, button entity and a `default` button) — you add
plugins in code (the `embedded_content_test` module shows examples). Requires `ckeditor5` and the
`symfony/dom-crawler` / `symfony/css-selector` libraries.

---

- Let editors drop a styled "call to action" component into body text without HTML access.
- Provide an editor button that inserts a configurable chart or data widget.
- Embed a reusable pricing table component into CKEditor content.
- Offer a "shape"/SVG component editors can configure (color, size) from a dialog.
- Insert a maps or location embed as a governed component instead of raw iframe HTML.
- Build an inline component (badge, icon) with `isInline()` returning TRUE.
- Create several editor buttons, each restricted (via `conditions`) to a subset of plugins.
- Give a button a custom icon, singular label, modal title and submit button text.
- Control the insertion dialog's width/height per button.
- Grant only certain roles the `use <button> embedded content button` permission.
- Keep component markup and styling in code while editors only pick and configure.
- Show a live preview of the component inside CKEditor 5 thanks to upcasting.
- Attach component-specific CSS/JS libraries via the plugin's `getAttachments()`.
- Replace bespoke CKEditor plugins with a single configurable embedded-content framework.
- Render different components from the same `<embedded-content>` tag by plugin id.
- Provide a "video embed" component that outputs safe, themed markup.
- Let marketing embed promo blocks without touching the text format's allowed HTML.
- Validate component configuration with the plugin's `validateConfigurationForm()`.
- Massage submitted values before storage with `massageFormValues()`.
- Insert an accordion/tabs component built entirely from a plugin's render array.
- Standardise embeddable widgets across many content types and formats.
- Gate which plugins appear in a button using glob/regex `conditions`.
- Ship a component library as a module full of `Plugin/EmbeddedContent/*` classes.
