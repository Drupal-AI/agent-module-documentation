Flipbook turns an uploaded PDF into an interactive page-flipping "book/magazine" viewer, using a bundled 3D flipbook JavaScript stack (pdf.js, three.js, html2canvas) rendered client-side, optionally inside a popup frame.

---

The module defines its own content entity type, `flipbook`, with base fields for a name, a required cover **image** (`flipbook_cover`, png/jpg), and a required **PDF file** (`flipbook`, restricted to `.pdf` with the PHP upload-max size limit), plus author/created/changed fields. Flipbook entities are managed at *Structure → Flipbook Listing* (`/admin/structure/flipbook/list`), created via *Add flipbook*, and viewed at `/flipbook/{id}`. A single settings form — the module's `configure` route `flipbook.chooseform` at `/admin/config/choosepdfstyle` — stores one boolean, `pdf.choice` (config `config.flipbook_chooseconfig`), that toggles between the popup viewer library (`flipbook/flipbook`) and the inline one (`flipbook/flipbook_nopopup`). Rendering is driven by `flipbook_preprocess_flipbook()`, which loads the PDF and cover files, builds absolute URLs via the file URL generator, attaches the chosen asset library, and passes `modulepath`, `pdfpath`, `pdfchoice`, and `host` to the browser through `drupalSettings`; the Twig template (`flipbook.html.twig`) plus `js/custom.js` + `js/3dflipbook.min.js` render the flip effect. The entity is fieldable and Views-enabled (`EntityViewsData`), and the README describes adding a "Flipbook PDF" field in a View with "Use field template" so `views-view-field--flipbook.html.twig` renders the book. Five permissions gate view/add/edit/delete/administer, and `hook_entity_predelete` deletes the referenced cover and PDF files when a flipbook is deleted. All viewer JS/CSS (Bootstrap, FontAwesome, pdf.js, three.js) ships inside the module — no external CDN or Composer library.

---

- Display a marketing brochure or catalog PDF as a flippable on-screen book.
- Present a magazine or newsletter with realistic page-turn animation.
- Show an annual report PDF in an interactive reader instead of a plain download link.
- Embed a product lookbook that visitors page through like a physical booklet.
- Offer a restaurant menu PDF as a browsable flipbook.
- Let users open a PDF book inside a popup/colorbox frame over the current page.
- Render the flipbook inline within the page instead of a popup (via the settings toggle).
- Create a library of flipbooks, each a `flipbook` entity with its own cover and PDF.
- Manage flipbooks from a dedicated admin listing at Structure → Flipbook Listing.
- Add a cover image that displays before the book opens.
- Restrict who can view flipbooks using the "view flipbook entity" permission.
- Restrict who can create/edit/delete flipbooks with the corresponding permissions.
- Show flipbooks in a View using the "Flipbook PDF" field with the field template option.
- Build a themed grid or list of flipbooks via Views and the provided field template.
- Provide an e-catalog experience without any third-party SaaS or external library.
- Automatically clean up the stored PDF and cover files when a flipbook entity is deleted.
- Serve the flipbook viewer entirely from bundled assets (no CDN dependency).
- Give each flipbook a canonical URL (`/flipbook/{id}`) to link or share.
- Add extra fields to the flipbook entity (it is fieldable) for metadata like description or category.
- Localize a flipbook per language using the entity's language field.
- Present training material or documentation PDFs as an engaging book UI.
- Switch the whole site between popup and inline flipbook display with a single config setting.
