CKEditor 5 Inline Styles adds a toolbar button that lets editors attach an inline-style string to an embedded Drupal media item, which a text-format filter then renders onto the media element's `style` attribute.

---

The module ships one CKEditor 5 plugin ("Media Inline Styles") and one text-format filter ("Inline Style", id `filter_inline_style`). In the editor, selecting an embedded `<drupal-media>` element enables the toolbar button; clicking it opens a small balloon with a single "Add Inline Style" text field. Whatever the editor types is stored on the media element as a `data-inline-style` attribute in the saved markup. At render time the filter finds every element carrying `data-inline-style`, removes that attribute, and copies its value verbatim into the element's `style` attribute. The module targets media embeds only (Media Library / `drupal-media`); the command is only enabled when a media element is selected. There is no settings form, no config schema, and no permissions defined by the module — it depends on core `ckeditor5` (and, in practice, core Media for `drupalMedia`). Setup is entirely done on the Text formats and editors screen: add the toolbar button, enable the Inline Style filter, and order the Inline Style filter before "Embed media" in the filter processing order.

---

- Apply a custom inline style to a single embedded media item without adding a global CSS class.
- Add margin/padding around an embedded image so surrounding text wraps with breathing room.
- Float an embedded media element left or right for a specific piece of content.
- Set a per-instance max-width or width on an embedded media item.
- Give one embedded media element a border or box-shadow that other embeds should not share.
- Nudge an embedded video's alignment inside an article body.
- Apply a one-off background color behind an embedded media element.
- Let content authors fine-tune spacing on media embeds without a theme deployment.
- Provide instance-level styling where creating a new Drupal media view mode would be overkill.
- Round the corners (border-radius) of a specific embedded image.
- Constrain an oversized embedded media item on a single page.
- Add vertical spacing (margin-top/margin-bottom) to separate an embed from adjacent paragraphs.
- Apply opacity or a filter to a single decorative media embed.
- Give editors an inline styling affordance similar to CKEditor's media element style, but as a free-text value.
- Store the styling with the content (reversible filter) so the raw value round-trips back into the editor field.
- Pair with Media Library embeds to let authors position individual media without leaving the editor.
- Migrate legacy inline-styled media into a structured `data-inline-style` attribute editors can re-edit.
- Prototype spacing/layout tweaks on media embeds before committing them to theme CSS.
- Apply a display:block or display:inline-block override to a specific embedded media element.
- Add a per-embed text-align or vertical-align adjustment.
