<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Media Title adds the ability to override the title attribute of embedded media in CKEditor 5.

---

CKEditor Media Title lets editors **override the `title` attribute of media embedded in CKEditor 5** —
so an embedded image/media item can carry a custom tooltip/accessibility title set in the editor,
without changing the underlying media entity. It depends only on core CKEditor 5 and Media, and sits
in the CKEditor 5 package.

Enable the feature per text format: at `/admin/config/content/formats`, edit a CKEditor 5 format that
uses the Media Embed filter and tick **Enable media image title override**. Editing content, select an
embedded media item and click the **T** button in its inline toolbar to open a small balloon form;
type a title (or leave it blank to fall back to the media entity's default) and Save. The override is
stored on that one embed as `<drupal-media title="...">` and rendered through core's Media Embed
filter and standard render pipeline (which escape output). The module has no routes, services,
permissions, or PHP output path of its own — just a single per-format checkbox and client-side JS.
