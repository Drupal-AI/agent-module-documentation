Simple IFrame provides a `simple_iframe` field type (URL + width + height), a matching widget, and a Twig-rendered formatter that outputs an `<iframe>` for the stored URL. It is the most basic way to let editors embed an iframe via a field.

---

The module defines one field type `simple_iframe_field_type` with three string properties — `url` (up to 2048 chars), `width`, `height` — plus field-level default settings for width (`100%` for responsiveness) and height, editable on the field settings form. Its widget `simple_iframe_widget_type` renders three text inputs (URL, width, height) on the entity edit form; the URL input has placeholder `//` and a 2000-char max, and width/height pre-fill from the item or the field defaults. The formatter `simple_iframe_formatter_type` renders each item through the `simple_iframe` theme hook, whose template (`templates/simple-iframe.html.twig`) outputs `<div class="simple-iframe"><iframe src="{{ url }}" width="{{ width }}" height="{{ height }}">…</iframe></div>`. There is no global config, no permissions, and no schema config entity — everything is field configuration. Rendering is deliberately template-based so themes can override the markup. The stored `url` is placed directly into the iframe `src`.

---

- Add an iframe embed field to a content type (e.g. embed an external tool or map).
- Let editors paste a URL and set width/height per item.
- Provide a responsive default width (`100%`) with a configurable default height.
- Embed a third-party booking/scheduling widget on a page via a field.
- Embed a dashboard or report iframe on a node.
- Add multiple iframe embeds to one entity (multi-value field).
- Override the iframe markup by providing a `simple-iframe.html.twig` in your theme.
- Set a fixed pixel width/height for a specific embed by overriding the field defaults.
- Embed a video player URL where a full media module is overkill.
- Use on any fieldable entity (nodes, taxonomy terms, paragraphs, media).
- Show a fallback message for browsers that do not support iframes (built into the template).
- Configure the widget's URL textfield size on the form display.
- Store protocol-relative URLs (`//example.com/...`) using the placeholder convention.
- Present an embedded map alongside other node fields.
- Provide a quick iframe embed without configuring oEmbed/remote video.
- Theme the iframe wrapper (`.simple-iframe`) with custom CSS.
