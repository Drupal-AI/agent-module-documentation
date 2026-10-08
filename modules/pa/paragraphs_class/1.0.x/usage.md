<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Class adds a Paragraphs **behavior plugin** that lets editors type a custom CSS class into each paragraph, which the module then adds to the paragraph's wrapper element on render.

---

The module ships a single Paragraphs behavior plugin, `paragraphs_class_paragraph_class` ("Paragraphs wrapper class"), extending `ParagraphsBehaviorBase`. Its `isApplicable()` returns TRUE for every Paragraphs type, so once you enable the behavior on a Paragraphs type (Structure → Paragraphs types → *Edit* → Behaviors), a "Wrapper class" text field appears on that paragraph in the content form. Whatever the editor enters is saved as the paragraph's behavior setting `wrapper_class`, and at view time the plugin's `view()` appends that string to `$build['#attributes']['class'][]` on the paragraph's render array. There is no global configuration page (`configure` is null), no permissions of its own (the behavior is gated by Paragraphs' standard "edit behavior plugin settings" permission), no config schema, and no Drush commands. It depends only on the contrib `paragraphs` module. The value is a free-text field with a single input — no validation, whitelist, or multi-class helper — so it is up to the editor to supply valid, space-separated class names, which Drupal renders through its attribute system (class values are escaped on output).

---

- Give a specific paragraph a custom wrapper CSS class for theming.
- Add a utility/spacing class (e.g. `mb-4`, `bg-light`) to a single paragraph instance.
- Apply a design-system component class to a paragraph without editing templates.
- Let content editors pick layout variants by typing an agreed class name.
- Add a background or color-modifier class to one hero/CTA paragraph.
- Tag paragraphs with classes that JavaScript (e.g. scroll animations) can hook onto.
- Distinguish two instances of the same Paragraphs type with different classes.
- Enable the behavior selectively — only on the Paragraphs types that need per-instance styling.
- Add multiple classes at once by typing them space-separated in the field.
- Provide a "full width" vs "boxed" toggle via a class convention.
- Attach print- or screen-only classes to specific paragraphs.
- Add anchor/scroll-target helper classes to a paragraph wrapper.
- Give editors control over vertical rhythm between paragraphs via margin classes.
- Mark promotional paragraphs with a campaign-specific class.
- Reuse existing theme CSS classes on paragraphs without custom code.
- Apply grid/column classes to paragraphs inside a layout.
- Add state classes (e.g. `is-featured`) that CSS or JS reacts to.
- Keep styling decisions in content rather than hardcoding them in templates.
- Prototype styling variations quickly by changing a paragraph's class in the editor.
- Combine with a CSS framework so non-developers can restyle individual paragraphs.
