<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
This is a small glue module that makes *Inline Block Title Automatic* work correctly with *Layout Builder Symmetric Translation*: when an editor translates an inline block, it hides the block-title (info) field and suppresses the duplicate-title validation error.
---
Inline Block Title Automatic derives a block's admin title automatically; Layout Builder Symmetric Translation adds a translate form for inline blocks. Used together, the translate form would still expose the title field and could raise a validation error about duplicate block titles. This module's `hook_form_block_content_form_alter()` detects the `BlockContentInlineBlockTranslateForm`, converts the title field to a hidden `value` element (supplying a default label if empty), and removes the `info` element from the submit action's `#limit_validation_errors` so the duplicate-title validation is skipped.

Setup is zero-configuration: install it alongside both dependencies and it takes effect automatically on the inline-block translate form. No settings, routes, or permissions.
---
- Hide the block title field when translating inline blocks
- Suppress duplicate-block-title validation on translation
- Provide a default label for empty inline-block titles
- Make Inline Block Title Automatic compatible with LB ST
- Smooth inline-block translation in Layout Builder
- Avoid manual title entry when translating blocks
- Zero-configuration bridge module
- Keep symmetric translation of layouts error-free- Prevent editors having to invent block titles per language
- Bridge two contrib modules without extra configuration
- Reduce translation friction for content editors
- Preserve automatic titles across symmetric translations
- Skip only the info-field validation, keep other validation
- Support multilingual Layout Builder workflows
- Apply automatically once dependencies are enabled
- Keep translated layouts consistent with source layouts
