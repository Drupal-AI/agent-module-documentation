Re-exposes the full Metatag SEO tag groups (Basic, Advanced, Open Graph, Facebook, Twitter Cards) on Drupal Canvas page edit forms, each independently toggleable.

---

Drupal Canvas (Experience Builder) hides almost the entire Metatag field on its `canvas_page` edit form, leaving only a single SEO title. Canvas Page Metatag restores the hidden tag groups so Canvas pages get the same Metatag editing experience as nodes and other fieldable entities. It is a pure Form API integration — `hook_form_canvas_page_form_alter()` flips `#access` back on for the Basic, Advanced, Open Graph, Facebook, and Twitter Cards groups according to a small settings config, and can also hide groups you don't want. It renders nothing itself: once the required Metatag submodules are enabled, Metatag's own page-attachment code emits the saved tags into the page `<head>`. The module additionally repairs a real Canvas/Metatag bug where the React builder submits Metatag's Robots checkboxes as a boolean `1` instead of the checkbox key, which otherwise fails validation with "The submitted value 1 in the Robots element is not allowed."

---

- Give Canvas pages full Metatag editing instead of only the built-in SEO title field.
- Add per-page meta descriptions to Canvas landing pages for better search snippets.
- Set the `keywords` and `abstract` Basic tags on individual Canvas pages.
- Control indexing per Canvas page with the Advanced Robots group (index/noindex, follow/nofollow).
- Fix the "submitted value 1 in the Robots element is not allowed" error when saving Robots checkboxes from the Canvas builder.
- Expose Open Graph tags so Canvas pages share correctly on Facebook/LinkedIn.
- Expose Twitter Cards tags to control how Canvas pages preview on X/Twitter.
- Expose the Facebook-specific tag group (fb:app_id, etc.) on Canvas pages.
- Turn off tag groups you don't use (e.g. hide Facebook/Twitter Cards) to declutter the editor.
- Show only the Basic description field to editors while keeping other groups hidden.
- Let content editors set canonical, referrer, and other Advanced tags on marketing pages.
- Provide the same SEO workflow across nodes and Canvas pages without custom form alters.
- Roll out Metatag on an Experience Builder site without writing bespoke form-alter code.
- Combine with site-wide Metatag defaults so Canvas pages inherit global tags and override per page.
- Configure which groups appear centrally at `/admin/config/search/canvas-page-metatag`.
- Ship the tag-exposure configuration through the config system across environments.
- Restore the Basic group as a collapsible details section (Canvas flattens it to a plain container).
- Keep Open Graph image/description tags editable for social-share previews of Canvas pages.
- Standardize which SEO tags editors can touch across a team by toggling groups once.
- Enable SEO auditing of Canvas pages by making all tag values editable and inspectable.
