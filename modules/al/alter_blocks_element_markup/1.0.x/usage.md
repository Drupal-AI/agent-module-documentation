<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alter blocks element markup lets site builders change the wrapper element (tag), markup and CSS classes of blocks without writing a custom theme override.

---

Install the module (requires core block). It adds a form element / third-party settings on block configuration to choose the wrapper tag and classes, and provides a block.html.twig template plus config schema that apply the chosen markup.

---

- Alter the wrapper element of rendered blocks.
- Customise block markup and CSS classes.
- Add a tag-selection form element to blocks.
- Provide a block.html.twig template.
- Define a config schema for the settings.
- Depend on core block.
- Avoid custom theme overrides for simple changes.
- Let site builders pick the wrapper HTML tag.
- Serve block-enhancement/theming use cases.
- Apply per-block markup settings.
- Store choices in block configuration.
- Provide a render Element plugin.
- Keep changes in configuration, not code.
- Work across Drupal 9.3+ and 10.
- Have no permissions or routes of its own.
- Improve block markup flexibility.
- Target site structure/presentation.
- Render classes onto the block wrapper.
