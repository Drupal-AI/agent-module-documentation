<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform media registers a **media source** for webforms, so a form becomes a media entity that editors can reference and embed through the ordinary media library rather than by placing a block or writing a token.

---

Getting a webform into a page has always been awkward: place the form's block and constrain its visibility, drop a `[webform:...]` token, or add a webform reference field to the content type. Each works, and each puts the decision somewhere other than where the editor is writing. This module adds a core media-source plugin (`webform_media`, `allowed_field_types: ['webform']`) so you can create a "Webform" media type whose source field is a webform entity reference. A piece of media then *is* a form: it lives in the media library alongside images and video, gets selected in any media reference field, embedded through CKEditor's Media Library button, rendered through a media view mode, reused across pages, and counted through media usage tracking. Setup is done with core's Media Type UI — the module ships only the media source plugin (`src/Plugin/media/Source/Webform.php`), the Media Library "quick add" form (`src/Form/WebformMediaAddForm.php`), and one config-schema entry; there are no routes, permissions, services, or hooks of its own. The requirements are the tightest of any module in this wave and worth checking before proposing it: **PHP >= 8.3**, core `^10.5 || ^11.2`, and Webform **`^6.2@beta`** — a beta constraint, so composer will pull a beta release of Webform to satisfy it.

---

- Turn a webform into a reusable media entity.
- Embed a webform into body content from the media library.
- Insert a form through CKEditor's Media Library button.
- Let editors place a form without touching block layout.
- Reuse one form across many pages as a single media item.
- Reference a webform media from any media entity-reference field.
- Render a form through a media view mode.
- Track where a form is embedded via media usage.
- Give the media its name automatically from the referenced webform's title.
- Avoid `[webform:...]` tokens in content.
- Manage forms alongside images and video in one library.
- Support a component-based editing workflow.
- Place a contact form mid-article.
- Embed a survey in a landing page.
- Reuse a signup form across a campaign.
- Standardise how forms enter content.
- Reduce block visibility rules for form placement.
- Let editors preview an embedded form before publishing.
- Keep form-placement decisions with the content, not layout config.
- Apply the media workflow (revisions, view modes) to forms.
- Add the Webform media type to a media library widget's allowed bundles.
- Pick a webform from a select in the media library "quick add" tab.
