<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Markup (HTML)' Paragraph bundle for experts to embed raw HTML/code snippets.

---

This sub-module of DROWL Paragraphs for Bootstrap installs the `markup` Paragraph type with a single `text_long` field, `field_markup`, plus the shared hidden `field_settings`. The field is edited with a plain textarea and rendered with core's standard text formatter (`text_default`), so the HTML that is actually emitted is filtered by whichever Drupal text format the editor selects for the value — exactly like any other formatted-text field. It is intended for experts who need to drop in HTML snippets (including markup with no visible output, e.g. scripts), and the module even adds an invisible 'empty-check workaround' span so such no-output markup is still rendered by Paragraphs.

---

- Embed a block of custom HTML markup inside Paragraphs-based content.
- Add code snippets that produce no visible output (the module forces them to render).
- Choose the text format per value; filtering follows that format's filters and text-format permissions.
- Combine with the shared field_settings for animations, custom classes and id.
- Enable only where expert editors need raw markup, leave disabled otherwise.
- Use for third-party embed snippets that other bundles do not cover.
- Restrict who can use unfiltered formats through core's 'use text format X' permissions.
- Translate the markup value (field is translatable).
