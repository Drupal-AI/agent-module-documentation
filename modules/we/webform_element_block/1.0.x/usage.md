<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Element Block adds a "Webform Block Element" element to Webform that renders any Drupal block plugin inline inside a form, identified by the block plugin machine name you type into the element's Block ID field.
---
The module (project `webform_block_element`, shipped module machine name `webform_element_block`) provides a single Webform element plugin, `webform_block_element`, that extends Webform's markup element (`WebformMarkup`). You add it like any other element on a webform's Build tab; it appears under the "Custom" element category. Its one custom setting is Block ID, a text field where you enter the machine name of a block plugin (for example `system_powered_by_block` or a custom block plugin id). When the form is prepared for display, the module instantiates that block plugin, calls its build method, renders the result to HTML, and injects that HTML as the element's markup so the block appears as static, read-only content in the form. Because it extends the markup element it collects no submitted value and stores nothing in the submission. There is no configuration page, no permission, no Drush command and no config schema; behaviour is entirely per-element. It depends only on Webform and targets Drupal core 10 or 11.
---
- Add a "Webform Block Element" element to a webform (Custom category).
- Render a Drupal block plugin inline as part of a form.
- Show a block's output by entering its plugin machine name in Block ID.
- Embed a custom block plugin's markup inside a webform.
- Display a "Powered by Drupal" or similar system block within a form.
- Place informational block content between form fields.
- Add promotional or call-to-action block markup to a form.
- Surface a menu or branding block inside a multi-step form.
- Reuse an existing block plugin's rendered content without a page/region placement.
- Insert read-only reference content (built by a block) alongside input fields.
- Add contextual help produced by a block into a form.
- Include a block-rendered notice at the top or bottom of a webform.
- Show marketing content from a block plugin during form completion.
- Combine block output with other webform markup/HTML elements.
- Present a block's rendered widget as non-editable form content.
- Use a single element to swap which block is shown by changing its Block ID.
- Keep block markup out of the submission data (display only).
- Provide layout/branding continuity by embedding site blocks in forms.
