Auto Link Field Formatter adds a field formatter that turns plain-text URLs inside string and text fields into clickable links on the entity display.

---

The module ships one core Field Formatter plugin, `auto_link_formatter` ("Auto Link (Convert URLs to Links)"), usable on `string`, `string_long`, `text` and `text_long` fields. When a field is set to this formatter on *Manage display* (or inside Layout Builder), each value is scanned for substrings that start with `http://`, `https://` or `www.`; those are wrapped in `<a>` anchor tags (bare `www.` links get an `http://` prefix), while line breaks are preserved with `nl2br()`. A single formatter setting, *Open links in new tab* (on by default), controls whether the generated links carry `target="_blank"`; `rel="noopener noreferrer"` is always added. There is no admin settings page, no permission, and no route — everything is configured per view-display. The module has no runtime dependencies beyond core (it declares core Filter in its info file but does not use a filter plugin).

---

- Display a plain-text "Website" or "Homepage" field so its URL becomes a clickable link.
- Auto-link URLs a content editor pasted into a plain-text `string_long` notes field.
- Make URLs in a user profile "bio" or "about" text field clickable without an HTML editor.
- Turn a comment-like plain-text field's URLs into links on display.
- Present a multi-line address or contact block where each `www.` URL is linked.
- Convert URLs in an event description text field into links inside Layout Builder.
- Link the URL in a "Source" or "Reference" string field on an article teaser.
- Show a taxonomy term description's URLs as links when the description is plain text.
- Render a media entity's caption/attribution field with clickable source URLs.
- Auto-link URLs in a product's plain-text spec or manual field on Commerce displays.
- Provide clickable links in a paragraph type's plain-text body without a rich-text format.
- Keep links opening in the same tab by turning off *Open links in new tab* for in-site URLs.
- Force links to open in a new tab (default) for outbound references in a citations field.
- Display a job-listing "Apply at" URL field as a ready-to-click link.
- Link URLs in an imported/migrated plain-text field that has no link field of its own.
- Show clickable documentation URLs in an admin-facing text field on a config entity display.
- Render multi-line release notes where each version's URL is auto-linked.
- Add clickable links to a "Social profiles" plain-text field listing several `www.` handles.
- Present a directory listing entity's website field as a link on its full display.
- Auto-link URLs inside a Views field that outputs a rendered entity field using this formatter.
