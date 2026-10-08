<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Body Index builds a content index (table of contents) from the headings inside a body/text field and renders it via a field formatter.

Use it on long-form content to give readers a jump-to navigation of the page's sections.

---

Install with `composer require drupal/body_index` and enable it (`drush en body_index`).

On the entity's Manage Display, apply the Body Index formatter to a formatted-text field; it parses the field's headings and outputs a linked index using the module's Twig template. Configuration schema is provided for the formatter settings.

---

- Generate a table of contents from body headings.
- Provide a dedicated field formatter for text fields.
- Parse HTML heading elements in the field value.
- Render the index through a Twig template.
- Offer a jump-to navigation for long content.
- Configure via the field's Manage Display screen.
- Ship configuration schema for the formatter.
- Target Drupal 10.
- Require no custom routes or permissions.
- Improve readability of long-form pages.
- Work with standard formatted-text fields.
- Keep the index in sync with the content's headings.
- Add an install hook for setup.
- Serve as a lightweight ToC solution.
- Integrate cleanly with Field UI.
- Avoid third-party JavaScript libraries.
- Enhance content display for articles and documentation.