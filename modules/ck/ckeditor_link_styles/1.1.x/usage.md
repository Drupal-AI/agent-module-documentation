CKEditor 5 Link Styles lets site builders define named CSS-class "styles" that editors can apply to links directly from CKEditor 5's Link dialog, without touching the Styles dropdown.

---

The module ships a single CKEditor 5 plugin, `ckeditor_link_styles_linkStyles`, that is configured per text format. When you edit a CKEditor 5 text format that has the **Link** button on its toolbar, a **Link styles** vertical-tab appears where you enter one style per line using the same selector syntax as core's Styles feature: `a.classA.classB|Label` (for example `a.btn|Button`). Each configured style is turned into a CKEditor 5 Link **manual decorator** (via the plugin's `getDynamicPluginConfig()`), so the class becomes a checkbox inside the normal Add/Edit-link balloon rather than a separate two-step Styles action. The styles are stored on the `editor.editor.<format>` config entity at `settings.plugins.ckeditor_link_styles_linkStyles.styles`, each entry a `{label, element}` pair where `element` is a CKEditor 5 element string like `<a class="btn">`. Because the plugin declares `<a class>` in its element subset, the format's allowed-HTML list is updated automatically to permit the classes. It only appears when the core `ckeditor5_link` plugin (the Link button) is enabled, and it coexists with Linkit and Editor Advanced Link, which also extend the Link plugin. There is no global settings page and no permissions of its own — everything is per format. The classes you name should exist in your theme's CSS so the styled links actually render.

---

- Offer editors a "Button" style that turns a link into a `a.btn` call-to-action without leaving the link dialog.
- Provide multiple link variants (primary button, secondary button, large button) as checkboxes in the Link balloon.
- Apply a `a.external-link` class so themed links get an external-link icon.
- Add a `a.download` style for links to PDFs or other downloadable assets.
- Let content authors mark links as `a.text-danger` / `a.text-muted` for utility styling.
- Standardize call-to-action link markup across a site so it always carries the same class.
- Give a `a.btn.btn-lg|Large Button` compound-class style for a bigger CTA.
- Replace fragile manual use of the Styles dropdown on links (which has known usability issues) with a purpose-built control.
- Configure different link styles per text format (e.g. richer set on Full HTML, minimal on Basic HTML).
- Expose Bootstrap-style link/button classes to non-technical editors as friendly labels.
- Add a `a.nav-link` style for links placed inside custom navigation content.
- Provide a `a.badge` style for pill/tag-like links.
- Let editors flag sponsored links with a `a.sponsored` class for styling or scripting hooks.
- Attach a tracking/analytics class (e.g. `a.js-track`) to specific links via a labelled style.
- Give print stylesheets something to target by offering a `a.print-hidden` link style.
- Ensure accessibility-oriented classes (e.g. `a.visually-hidden-focusable`) are one click away for editors.
- Keep link classes consistent across many authors instead of relying on each remembering the exact class name.
- Work alongside Linkit so autocomplete-selected links can still receive a style class.
- Work alongside Editor Advanced Link so links can have both extra attributes and a style class.
- Migrate away from a legacy "add class in Source view" workflow to a supported UI control.
- Offer themed card or tile links a `a.card-link` style.
- Provide a `a.btn-outline` variant for secondary calls to action.
- Let editors pick a colour-coded link style tied to a design system.
- Add a `a.arrow-link` style whose CSS appends a directional arrow.
- Roll out a new design-system link component to editors by adding one line of config per format.
