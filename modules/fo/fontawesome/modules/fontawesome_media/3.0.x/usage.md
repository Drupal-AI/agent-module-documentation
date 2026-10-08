A submodule of Font Awesome that adds a Font Awesome Icon media source so icons can be stored and reused as media entities.

---

The media submodule registers a `font_awesome_icon` media source plugin (built on core Media's `MediaSourceBase`) that wraps a Font Awesome icon field, letting sites create a Media type whose items are Font Awesome icons. Editors add icons through a media-library add form (`FontawesomeMediaAddForm`) and then reuse them anywhere media is referenced, just like images or documents. It depends on the parent Font Awesome module for the icon field and on core's SVG Image module for thumbnail handling. The source exposes a Title metadata attribute and reuses the icon field value as the media's source. This is useful when the same icons must be picked from a central library rather than re-entered per field. It is a lightweight bridge between Font Awesome fields and the core Media system.

---

- Store Font Awesome icons as reusable media entities.
- Create a "Font Awesome Icon" media type from the media source plugin.
- Pick icons from the Media Library instead of per-field entry.
- Reference icons wherever media entity reference fields are used.
- Add icons through the media-library add form.
- Reuse the same icon across many pieces of content.
- Give icons a title/label as media metadata.
- Centralize an approved set of brand icons for editors.
- Combine icons and images in one media reference field.
- Manage icon media with standard media permissions and workflows.
- Leverage SVG Image for icon media thumbnails.
- Translate or moderate icon media like any media entity.
- Embed icon media via the media library in CKEditor.
- Build icon galleries or pickers from a media view.
- Keep icon selection consistent across a large editorial team.
