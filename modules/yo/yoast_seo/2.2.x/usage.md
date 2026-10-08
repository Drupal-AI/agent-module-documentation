Real-time SEO for Drupal (Yoast SEO) adds a live content-analysis panel to entity edit forms, scoring how well a page is optimized for a chosen focus keyword and showing a Google snippet preview as you type.

---

The module integrates the goalgorilla/rtseo.js port of the Yoast SEO JavaScript library into Drupal's entity edit forms. It provides a `yoast_seo` field type (with widget and formatter) that you add to content types, media, block content, or taxonomy terms; when present, the edit form gains a **Real-time SEO** section with a focus-keyword input, a live SEO score, a bulleted analysis of concrete improvements, and a Google search-result snippet preview. It builds on the Metatag module for the actual meta title/description output, and uses the Path module so the snippet can show the real URL alias. Scores are computed client-side as the editor writes, then summarized into a Good/Okay/Bad/Not-available status controlled by configurable score rules. Custom title and description entered in the SEO field override the Metatag defaults via `hook_metatags_alter()`. Site-wide behavior (which bundles are enabled, auto-refresh, score labels) is managed at Admin → Configuration → Real-time SEO. Two permissions separate administering the module from using the analysis per entity. It requires the external rtseo.js library to be installed under `/libraries/rtseo.js`.

---

- Show editors a live SEO score while they write a node.
- Set a focus keyword and see whether the content targets it well.
- Display a Google-style snippet preview of the title, URL, and description.
- Get a bulleted checklist of concrete SEO improvements per page.
- Override the meta title and description directly from the edit form.
- Enable real-time SEO analysis only for chosen content types.
- Add SEO analysis to media entities as well as nodes.
- Add SEO analysis to custom block content.
- Provide SEO scoring on taxonomy term pages.
- Encourage consistent keyword usage across an editorial team.
- Warn writers when a meta description is too long or too short.
- Check that the focus keyword appears in the title, URL, and headings.
- Surface readability-style feedback on content as it is drafted.
- Display an overall SEO score column/field in a Views listing of content.
- Configure Good/Okay/Bad score labels to match editorial standards.
- Auto-refresh the analysis result as content changes.
- Train new content editors on on-page SEO with immediate feedback.
- Improve click-through rate by tuning the snippet before publishing.
- Keep meta tags and on-page content aligned through one interface.
- Restrict who can edit SEO analysis with a dedicated permission.
- Let admins configure per-bundle SEO settings centrally.
- Combine with Metatag defaults so unedited pages still get sensible tags.
- Preview how a page will appear in search results for a target query.
- Standardize URL, title, and description structure across a large site.
- Reduce reliance on external SEO tools by analyzing inside Drupal.
