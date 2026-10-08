<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Patterns Media Source lets component (UI Patterns / SDC) props be filled with media chosen from Drupal's Media Library modal.

---

It registers a Media Library opener (`MediaLibraryBrowserOpener`, tagged `media_library.opener`) plus a "Media Browser" UI Patterns source type. Controllers back the modal workflow: `MediaLibraryController::build` renders the library, `SelectionDoneController::content` handles the chosen selection, and `MediaPreviewController::build` returns rendered thumbnails for selected media IDs. Every media-facing route requires the `view media` permission, and the preview controller re-checks `access('view')` on each entity, silently skipping media the current user may not see. A settings form at `/admin/config/media/ui-patterns-media-source` (`administer site configuration`) restricts which media types the source may select.

Setup: enable the module alongside UI Patterns and Media Library, choose the allowed media types, then use the "Media Browser" source when configuring a component's media/image prop. It slots into any UI Patterns-driven layout (Layout Builder, blocks, view modes) that needs editor-friendly media selection.
---
- Pick media for a component prop from the Media Library modal
- Add a "Media Browser" source to UI Patterns components
- Fill an SDC image/media slot via the media library
- Restrict which media types a component may select
- Preview selected media thumbnails in the browser
- Reuse existing library media in components
- Integrate media selection into Layout Builder components
- Enforce `view media` on the selection workflow
- Skip media the current user cannot view
- Configure allowed media types centrally
- Give editors a familiar media-picker UX for patterns
- Select multiple media items for a component
- Support image, media and media_library dependencies
- Open the media library modal from a component form
- Return the chosen selection back into the pattern prop
