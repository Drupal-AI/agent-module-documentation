CKEditor iFrame adds an "Iframe Embed" toolbar button to CKEditor 5 in Drupal, letting editors insert and edit `<iframe>` embeds (maps, videos, external widgets) directly in a rich-text field, with a per-format choice of which iframe attributes are allowed.

---

The module registers a single CKEditor 5 plugin, `ckeditor_iframe_embed_iframeembed`, that turns on an `iframeembed.IframeEmbed` JS plugin and adds one toolbar item, `iframeEmbed` (label "Iframe Embed"). It is enabled per text format at `/admin/config/content/formats`: drag the **Iframe Embed** button into the CKEditor 5 toolbar of a format and the plugin activates. When editors click the button a small form asks for the iframe URL (and, depending on configuration, size/attributes) and inserts an `<iframe>` into the content. The plugin is configurable per format via a vertical-tab checkbox group, **Allowed optional attributes**, that controls which attributes beyond the mandatory `src` are permitted on inserted iframes (`align`, `frameborder`, `height`, `width`, `longdesc`, `name`, `scrolling`, `tabindex`, `title`, `allowfullscreen`; four legacy ones — `align`, `frameborder`, `longdesc`, `scrolling` — are labelled *deprecated* and off by default). Those choices drive the plugin's dynamically-computed allowed-elements subset, so the format's "Limit allowed HTML tags" filter (`filter_html`) automatically permits `<iframe src …>` plus exactly the attributes you ticked — no manual editing of the allowed-tags string is required for CKEditor 5. Settings persist on the `editor.editor.<format>` config entity under `settings.plugins.ckeditor_iframe_embed_iframeembed.enabled_optional_attributes`. The project also ships a legacy CKEditor 4 plugin (`src/Plugin/CKEditorPlugin/IFrame.php`) for the transition period, but on Drupal 11 the CKEditor 5 plugin is the one in use.

---

- Let editors embed a Google Map, calendar, or booking widget into body content via an `<iframe>`.
- Embed third-party video players (Vimeo, self-hosted, private streams) that are not covered by oEmbed/Media.
- Insert an external form (Typeform, survey, sign-up widget) inside an article without custom code.
- Add the **Iframe Embed** button only to trusted formats (e.g. Full HTML) so ordinary authors cannot embed arbitrary iframes.
- Restrict which iframe attributes editors may set per format (e.g. allow `width`/`height`/`title`, forbid `name`/`scrolling`).
- Require `allowfullscreen` on iframes so embedded video players can go full screen.
- Enforce accessibility by allowing `title` (and previously `longdesc`) on embedded iframes.
- Keep the allowed-HTML filter and the editor in sync automatically instead of hand-editing `<iframe …>` in the allowed-tags list.
- Migrate CKEditor 4 iframe embeds to CKEditor 5 while keeping the same `<iframe>` markup.
- Embed dashboards or BI reports (Grafana, Data Studio) into internal documentation pages.
- Provide a self-service way for marketing to drop campaign landing widgets into pages.
- Embed a live chat or support widget into a specific content type's body.
- Allow responsive iframes by permitting `width`/`height` and styling them in the theme.
- Disable deprecated attributes (`align`, `frameborder`, `longdesc`, `scrolling`) to produce modern, valid HTML.
- Standardise iframe embedding across a multisite so every editor uses the same button and attribute policy.
- Embed OpenStreetMap or a store-locator map in a contact page.
- Let documentation authors embed interactive demos (CodePen, JSFiddle) inside tutorials.
- Insert a PDF viewer iframe for inline document preview.
- Embed a social media timeline or feed widget where a dedicated media provider is unavailable.
- Give a text format iframe support without unchecking "Limit allowed HTML tags and correct faulty HTML".
- Curate an attribute allow-list per audience (stricter on public formats, looser on internal ones).
- Embed audio players or podcast widgets served from an external host.
- Add scheduling/booking iframes (Calendly, appointment tools) to service pages.
- Support editors embedding interactive charts or maps into reports without touching source HTML.
