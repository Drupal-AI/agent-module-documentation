<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon CKEditor makes Micon icon fonts render inside the CKEditor editing area by injecting each active Micon package's stylesheet into the editor iframe.

---

This is a tiny glue submodule: its only code is an implementation of `hook_ckeditor_css_alter()` that iterates every active Micon package (`Micon::loadActive()`) and appends the package's generated `style.css` (resolved via the file URL generator) to the list of stylesheets loaded inside the editor. The effect is that icon markup produced by other Micon features (for example an `<i class="fa-user">` pasted or inserted into rich text) displays with the correct glyph while editing, matching the front-end. It has no configuration, no field, no widget, no permission, and no `configure` route — enabling it is the entire setup. It depends only on `micon`. Note the hook is the CKEditor CSS-alter integration point; the packages it adds are exactly the Micon packages that are published/active site-wide.

---

- See Font Awesome (or any active Micon package) glyphs render correctly inside CKEditor.
- Match the editor's icon rendering to the front-end theme.
- Let editors preview icon markup in rich-text fields while editing.
- Automatically pick up every active Micon package's stylesheet in the editor.
- Keep the editor icon CSS in sync when you upload a new package.
- Avoid manually adding icon font CSS to your text format's editor.
- Support both font and (via the package CSS) image icon packages in the editor.
- Provide WYSIWYG parity for icon-decorated content.
- Enable icons in body/description rich-text areas without theme work.
- Drop the module in and get editor icon styling with zero config.
- Ensure icon classes inserted by other modules look right while editing.
- Reuse the same generated package `style.css` the front-end uses.
- Cover all CKEditor-backed text formats at once.
- Remove the need for a custom CKEditor stylesheet just for icons.
- Keep editor and rendered output visually consistent for reviewers.
- Support multiple active packages simultaneously in the editor.
- Update automatically after a package is added, edited, or removed.
- Give content authors accurate icon previews in place.
- Pair with micon_link/micon_menu so link/menu icons preview in rich text.
