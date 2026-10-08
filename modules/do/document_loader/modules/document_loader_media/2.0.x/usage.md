Provides a reusable media-library opener so the core media library can be embedded in Document Loader modal forms without an entity-reference field.

---

Document Loader: Media Library ships a single service — a `MediaLibraryOpenerInterface` implementation tagged `media_library.opener` — that lets any Document Loader form open the core media library as a picker and receive the selection back. Instead of requiring an entity-reference field to host the media library, a host form (such as the MDXEditor dialog) builds a `MediaLibraryState` pointing at this opener with two parameters: `field_widget_id` (the data-attribute used on the host's hidden input and update button) and `dialog_selector` (which dialog to close). On selection the opener closes only the media-library dialog, writes the chosen media IDs into the host's hidden field via jQuery `val()`, and triggers the host's hidden update button to AJAX-refresh the widget. Access is granted to users with `access content`.

---

- Embed the core media library as a document picker inside a custom modal form.
- Let the MDXEditor "Load Document" dialog select a document from the media library.
- Add a media picker to a form without creating an entity-reference field.
- Return selected media IDs to a host form's hidden field via AJAX.
- Close only the media-library dialog while keeping a parent modal open (via `dialog_selector`).
- Reuse one opener across multiple Document Loader consumer forms (MDX, CKEditor, etc.).
- Target a specific host widget with `field_widget_id` to avoid collisions between multiple pickers.
- Provide a foundation for other Document Loader UIs that need file/document selection.
- Restrict media selection to a configured media type (e.g. `document`) via the host's state.
- Trigger a widget refresh (mousedown on the hidden update button) after a selection is made.
