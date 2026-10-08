CKEditor Read More adds a CKEditor 5 toolbar button that wraps selected content in a collapsible "Read more" region, shown/hidden by a text link or button on the rendered page.

---

The module ships a CKEditor 5 plugin (`readMore.ReadMore`) whose toolbar item wraps the current selection in a `<div class="ckeditor-readmore" data-readmore-type="…">` container holding the hidden content. Per text-format editor settings you choose whether the toggle renders as plain `text` or a `button`, and optional extra CSS `classes` for the toggle element (`ReadMore` CKEditor5Plugin config, schema `ckeditor5.plugin.ckeditor_readmore_plugin`). A companion text filter, **Filter readmore** (`filter_readmore`, a reversible TYPE_TRANSFORM filter), must be enabled on the format: on output it detects the `data-readmore-type` marker, injects the configured `more_text`/`less_text` labels as `data-readmore-more-text` / `data-readmore-less-text` attributes, and attaches the front-end library (`js/ckeditor-readmore.js`, jQuery + once) that wires the click-to-toggle behavior. The front-end library is also attached globally via `hook_preprocess_html`. Because the wrapper `<div>` uses custom attributes, formats with "Limit allowed HTML tags" must whitelist `<div class="ckeditor-readmore" data-readmore-type data-readmore-more-text data-readmore-less-text data-readmore-classes>` (the module normally adds this automatically via the plugin's declared `elements`). v3 drops CKEditor 4 support but ships a `CKEditor4To5Upgrade` plugin mapping the old `btn_readmore` button and `readmore` settings to the new plugin. No permissions, no config UI page, no Drush.

---

- Hide a long section of body copy behind a "Read more" link that expands in place.
- Add a spoiler/expandable block inside rich-text content without custom code.
- Let editors collapse supplementary detail (specs, fine print, FAQs) under a toggle.
- Render the toggle as a styled button instead of a plain text link.
- Render the toggle as inline plain text for a lighter visual treatment.
- Apply custom CSS classes to the toggle element to match a theme's styling.
- Customize the "Read more" label text per text format via the filter settings.
- Customize the "Show less" label text per text format via the filter settings.
- Localize the more/less labels through the translatable filter settings.
- Provide expand/collapse content that works with just jQuery, no framework.
- Wrap product descriptions so listings stay short but full text is one click away.
- Collapse terms-and-conditions or legal text under a toggle in article bodies.
- Add "read more" teasers inside CKEditor without using core's node teaser break.
- Migrate an existing CKEditor 4 read-more button configuration to CKEditor 5.
- Enable the feature on a specific text format only (e.g. Full HTML) by toolbar + filter.
- Ensure the required `<div>` markup survives the "Limit allowed HTML tags" filter.
- Give content authors an in-editor visual boundary for the hidden region.
- Toggle multiple independent read-more regions within a single rich-text field.
- Keep pages short for SEO/above-the-fold while retaining full crawlable content.
- Offer a consistent collapse UX across all rich-text-driven content types.
