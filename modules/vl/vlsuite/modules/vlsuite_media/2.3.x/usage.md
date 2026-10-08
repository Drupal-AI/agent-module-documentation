<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Media supplies the media types the suite's components use — image, document, icon, local video and remote video — with responsive image support.

---

Components need media, and media needs configuring: a media type per kind of asset, a source plugin, view displays for each context a component renders in, and responsive image styles so a hero image is not the same file on a phone as on a desktop. That is a day of setup per project, done slightly differently each time.

This submodule ships it. The `responsive_image` dependency is the substantive one — it means the suite's images are delivered at appropriate sizes rather than scaled in the browser, which is the single biggest lever on a landing page's performance.

Five nested submodules cover the individual types: `vlsuite_media_image`, `_document`, `_icon`, `_local_video`, `_remote_video`. Enable the ones a site needs.

Worth knowing when planning: because these are core media types, everything else that consumes media on the site can use them too — they are not private to VLSuite components. That is an advantage for consistency and a thing to check before deleting one.

---

- Provide media types for landing page components.
- Deliver responsive images in components.
- Add a hero image at appropriate sizes.
- Attach a document to a component.
- Embed a local video.
- Embed a remote video.
- Use icons as media.
- Configure media displays per context.
- Reuse media types outside VLSuite.
- Improve landing page performance.
- Select media from the media library.
- Standardise media handling across projects.
- Enable only the media types needed.
- Check dependencies before deleting a media type.
- Audit which media types the suite added.
- Add a custom media type alongside.