<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Editoria11y adds a "Fix with AI" button to Editoria11y accessibility tooltips in CKEditor 5, using AI to suggest a WCAG 2.1 AA fix the editor reviews and applies in place.

---

AI Editoria11y connects the Editoria11y real-time accessibility checker with the `drupal/ai` CKEditor integration (`ai_ckeditor`). When Editoria11y flags a supported issue in a CKEditor 5 field, the module's front-end injects a "Fix with AI" button into the issue tooltip. Clicking it captures the flagged element, its attributes and surrounding HTML/text context, then opens the AI CKEditor dialog (`ai_ckeditor.dialog`). The `FixAccessibility` AiCKEditor plugin builds a prompt from configurable system/user templates with placeholders (`{{ element_html }}`, `{{ issue_description }}`, `{{ element_tag }}`, surrounding context, attributes), posts it to the `ai_ckeditor` request endpoint, and streams the model's suggested corrected HTML into a custom preview that shows a before/after diff. The editor reviews and can edit the suggestion, then applies it: the fix is inserted through CKEditor's model (via `insertContent`, preserving undo history and inline/block image type), and Editoria11y re-runs to confirm the issue is resolved. "AI suggests, humans decide." Prompts, a "Fix with AI" button label, and a debug mode (showing element details and the full prompt) are configured in the text format's AI CKEditor plugin settings and stored in `ai_editoria11y.settings`; a single permission gates whether the integration is offered to a role.

---

- Add a "Fix with AI" button to Editoria11y tooltips inside CKEditor 5 fields.
- Suggest a fix for missing or empty table header cells.
- Flag and fix content headings placed inside tables.
- Fix empty headings, over-long headings and skipped heading levels.
- Convert bold "fake headings" into real heading elements.
- Suggest better link text for generic links like "click here" or "read more".
- Fix empty links, links with no accessible label, and link text that is a bare URL.
- Suggest alt text and fixes for over-long image alt text.
- Convert dash/asterisk "fake lists" into proper list markup.
- Rewrite ALL CAPS text blocks into normal case.
- Review the AI suggestion as a before/after diff before applying anything.
- Edit the AI suggestion in the dialog before inserting it.
- Apply the fix in place while preserving CKEditor undo history.
- Re-run Editoria11y automatically after a fix to confirm resolution.
- Customize the AI system prompt (the "accessibility expert" role) per site.
- Customize the user prompt template with placeholders for element, issue and context.
- Choose which AI provider/model handles fixes in the text format's plugin settings.
- Turn on debug mode to inspect element details, surrounding context and the full prompt.
- Rename the "Fix with AI" button via the settings.
- Gate the feature to specific roles with the "Use AI to fix accessibility issues" permission.
- Keep accessibility remediation inside the authoring workflow instead of a separate audit tool.
