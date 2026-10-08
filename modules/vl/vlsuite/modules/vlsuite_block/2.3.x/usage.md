<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block is the suite's block layer: the shared configuration for VLSuite content block types, with ten component submodules — CTA, text, image, icon, video, webform, attachments, headings menu, paragraph — beneath it.

---

Layout Builder places blocks; this is where the blocks come from. Rather than a site building its own block types for every landing-page component, VLSuite ships them as `block_content` bundles with fields, form displays and view displays already configured, and this submodule holds the parts they share.

Its dependency list describes what a VLSuite block can do: `vlsuite_utility_classes` for per-instance styling, `vlsuite_media` for images and video, `vlsuite_slider` and `vlsuite_animations` for behaviour, plus `layout_builder_restrictions` — which is the significant one. Restrictions control which blocks an editor may place in which section, and without them a component library becomes a list of everything the site has ever defined.

The ten component submodules underneath are individually small and collectively the point. Enable the ones a site needs; the shared layer here is what makes them consistent.

Because they are `block_content` entities, VLSuite blocks are revisioned, translatable, and can be made reusable through the block library — so a component placed inline on one page and a shared component used on twenty are the same content type with a different reuse setting.

---

- Provide ready-made block types for Layout Builder.
- Place a CTA or text component on a page.
- Restrict which blocks may go in which section.
- Give components consistent styling options.
- Attach media to a component.
- Add animation to a placed block.
- Revision a component's content.
- Translate a component.
- Reuse a component across pages.
- Keep component configuration in exported config.
- Enable only the component types a site needs.
- Standardise landing-page components.
- Avoid building block types per project.
- Combine components with utility classes.
- Audit which components a site has enabled.
- Extend the set with a custom block type.