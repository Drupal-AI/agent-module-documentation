<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pagedesigner is a drag-and-drop page builder for Drupal, composing pages from components (image, video, gallery, embed, layout, webform and more) via ~19 submodules.

---

Building pages visually by dragging components is a popular editorial experience. Pagedesigner provides a drag-and-drop page builder, with a large set of component submodules (image, image-edit, video, audio, document, gallery, embed, layout, link, media, SVG, webform, page-tree, multitheme, duplication, debug, Yoast, and front-end-publishing integration). It is a substantial page-building system. The security considerations are the ones common to visual builders that embed content: components that embed arbitrary content — the `embed` and `svg` components in particular — warrant attention (an embed component can pull in external content or scripts; an SVG component handles SVG, which can carry scripts if not sanitised), so confirm how those components handle their input and who can configure them. Page building is done by editors within their content-edit access, and the components render authored content. Enable only the component submodules you use, review the embed/SVG components' handling of their input, and restrict page-building to trusted editorial roles. It is the framework; the component set is where to look for anything that renders untrusted markup.

---

- Build pages by drag and drop.
- Compose pages from components.
- Add image/video/gallery components.
- Use a visual page builder.
- Enable only components you use.
- Review the embed component's input.
- Confirm the SVG component sanitises.
- Restrict page building to editors.
- Add a layout component.
- Embed a webform.
- Build a landing page.
- Check components rendering untrusted markup.
- Add media components.
- Use the page-tree.
- Compose rich pages.
- Restrict who builds pages.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.