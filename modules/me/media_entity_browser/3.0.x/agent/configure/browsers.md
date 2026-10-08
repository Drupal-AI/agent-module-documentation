# Configure the media browsers

No settings form of its own. On install it imports config (from `config/install`):

- `entity_browser.browser.media_entity_browser` — **iFrame** display, for WYSIWYG embedding.
- `entity_browser.browser.media_entity_browser_modal` — **modal** display, for reference-field
  widgets.
- `views.view.media_entity_browser` — the View that lists Media as a thumbnail grid (the
  browser's "view" widget renders this).
- `image.style.media_entity_browser_thumbnail` — preview thumbnail style.
- `config/optional/embed.button.media_entity_embed` — an Entity Embed button (installed only
  if `entity_embed` is present).

The browser is invisible until wired in:

- **WYSIWYG embedding:** edit/add an Entity Embed button (Embed module) and point it at the
  iFrame browser; enable that button in a text format's CKEditor toolbar.
- **Media reference fields:** on the entity's *Manage form display*, use Inline Entity Form's
  complex widget (or Entity Browser's field widget) and select the modal browser.

Manage/customize both browsers through Entity Browser's own UI at
`/admin/config/content/entity_browser` (route `entity.entity_browser.collection`). Change which
media bundles appear, sorting, pagination, and exposed filters by editing the underlying
`media_entity_browser` View. All changes live as exportable configuration, not in this module.
