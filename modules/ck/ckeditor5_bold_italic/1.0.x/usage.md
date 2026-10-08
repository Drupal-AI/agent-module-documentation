<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes CKEditor 5's Bold and Italic buttons produce `<b>` and `<i>` tags instead of the default `<strong>` and `<em>`.

---
Out of the box CKEditor 5's basic styles emit semantic `<strong>` and `<em>` markup. Some sites, migrations or brand guidelines require the presentational `<b>` and `<i>` tags instead. This tiny module swaps that behaviour without any custom plugin build.

It implements `hook_ckeditor5_plugin_info_alter()`. For italics it strips the emphasis plugin's second CKEditor plugin entry and repoints its library at core's `ckeditor5.basic`; for bold it appends the `drupalBold.DrupalBold` CKEditor plugin and points the library at the module's own `ckeditor5_bold_italic/internal.drupal.ckeditor5.bold`. The result is that the existing Bold/Italic toolbar buttons keep working but write `<b>`/`<i>`.

There is no configuration, no routes, no permissions and no settings — install it and the change applies to text formats that use CKEditor 5's bold/italic. Remember to allow `<b>` and `<i>` in the text format's allowed-HTML if a filter restricts tags.
---
- Make the Bold button output `<b>` instead of `<strong>`.
- Make the Italic button output `<i>` instead of `<em>`.
- Match legacy/brand markup that expects `<b>`/`<i>`.
- Keep the existing CKEditor 5 toolbar buttons unchanged.
- Avoid building a custom CKEditor 5 plugin for the swap.
- Align editor output with an imported content style.
- Satisfy a style guide requiring presentational tags.
- Apply the change to any text format using CKEditor 5.
- Simplify downstream parsing that keys on `<b>`/`<i>`.
- Install with zero configuration.
- Remove the need for a post-save text filter to rewrite tags.
- Ensure consistency with a theme expecting `<b>`/`<i>`.
- Repoint the emphasis plugin at core's ckeditor5.basic library.
- Add the drupalBold library for bold output.
- Interoperate with content migrated from other systems.
- Reduce semantic-vs-presentational markup mismatches.
- Keep allowed-HTML filters in sync by permitting `<b>`/`<i>`.
- Provide predictable inline markup for editors.
- Support Drupal 9.4/10/11 CKEditor 5 formats.
- Uninstall cleanly to revert to `<strong>`/`<em>`.