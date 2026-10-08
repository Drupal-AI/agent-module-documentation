<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Tags (Dynamic Tags)

Inserts inline "dynamic tag" placeholders in CKEditor 5 that JavaScript can replace at runtime.
Project `ckeditor5_tags`; **Drupal machine name is `ckeditor_tags`** (enable with `drush en ckeditor_tags`).


## What & when

- Use it to place named placeholder tokens in body content that front-end JS fills in later (prices, counts, personalised values).
- Each tag is a widget: a `code.tag-id` (the lookup key) plus a `span.tag-label` (the visible placeholder text).
- The editing key is sanitised to `[a-zA-Z0-9-_]` by a model post-fixer.

---

## Install & configure

- `composer require drupal/ckeditor5_tags` then `drush en ckeditor_tags -y` (note the machine name).
- Requires core `ckeditor5`.
- Edit a text format and drag the **Dynamic Tags** button into the CKEditor 5 toolbar.
- Allowed markup (from `ckeditor_tags.ckeditor5.yml`) includes `<span class="dynamic-tag">`, `<code class="tag-id">`, `<span class="tag-label">`.
- No settings form, permissions, or routes.

---

## Usage & behaviour

- Insert a placeholder token an editor can label, then have JS swap in a live value.
- Build personalised content blocks (e.g. "Hello <name>") resolved client-side.
- Show dynamic counts/prices fetched by the site's own script after page load.
- The runtime API is `window.dynamicTags.tags` — an object keyed by each element's `dynamic-tag` attribute.
- Each tag object exposes `replace(value)` (sets `.tag-label` innerHTML), `wait()` (spinner), and `stop()`.
- `replace()` is meant to be called by the site's own trusted JS with its own values — it is not driven by page content.
- The tag id is constrained to alphanumeric/dash/underscore in the editor, keeping keys URL/JS-safe.
- Data downcast writes `<span class="dynamic-tag" dynamic-tag="<id>">` with `code.tag-id` and `span.tag-label` children.
- Upcast recognises existing `span.dynamic-tag` markup so saved content re-opens as a widget.
- The widget is inline and selectable; it can sit in paragraphs, headings, table cells, list items, etc.
- Provide a `css/tags.editor.css` skin in the editor and `css/tags.lib.css` on the rendered page.
- Load order: the `tags` runtime library is attached to every page via `hook_preprocess_html`.
- Combine with other CKEditor 5 plugins; it does not conflict with standard formatting.
- No server-side token resolution — replacement is entirely client-side and developer-driven.
- Good for lightweight dynamic content without a full token/render pipeline.
