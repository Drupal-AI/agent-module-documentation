<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Library Extend is a developer/API module that lets other modules add extra source tabs ("panes") to Drupal core's Media Library, so editors can pull media from services other than local upload.

---

The module defines a `MediaLibrarySource` plugin type (manager `plugin.manager.media_library_source`, annotation-based, base class `MediaLibrarySourceBase`) and a `media_library_pane` config entity that binds one source plugin to one media bundle, with optional per-pane plugin configuration. It decorates core's `media_library.ui_builder` service (`MediaLibraryExtendUiBuilder`) so each configured pane is rendered as an extra tab inside the Media Library dialog whenever its media bundle is allowed for the current field; the tab shows the plugin's filter form, a paged preview grid (themed via `media_library_pane`, `media_library_pane_content`, and `media_library_result_preview` templates), and a selection form (`PaneSelectForm`). When a source item is selected, `hook_form_alter` adds a validate handler that rewrites the transient `mle:<pane>:<item>` id into a real media entity id by calling the plugin's `getEntityId()`, which typically downloads the remote asset into a media entity. By itself the module is not useful — it ships two example image plugins (`lorem_picsum` and `configurable_lorem_picsum`) that fetch placeholder images from picsum.photos; real integrations come from custom plugins or contrib such as Media Library Youtube. Panes are administered at *Configuration » Media » Media library » Panes* (`entity.media_library_pane.collection`, gated by core's `administer site configuration`). It provides config schema for panes and per-plugin configuration but no permissions of its own and no Drush.

---

- Add a "stock photos" or external image-service tab to the Media Library for editors.
- Integrate a DAM or third-party media provider as a selectable Media Library source.
- Pull placeholder images (Lorem Picsum) into media entities during site building/testing.
- Write a custom `MediaLibrarySource` plugin to import assets from any API.
- Bind a specific source plugin to a specific media bundle via a Media Library pane.
- Configure per-pane options such as items-per-page or grayscale on the pane config entity.
- Offer multiple source tabs (e.g. upload + external service) for the same image field.
- Show a source tab only for fields whose allowed media bundles match the plugin's source types.
- Download a selected remote asset into a local media entity automatically on insert.
- Provide a paged, filterable preview grid for a remote catalogue inside the media modal.
- Add a filter form (search, toggles) to an external media source tab.
- Theme the pane, its content grid, or result previews by overriding the module's templates.
- Reuse the `MediaLibrarySourceBase` helpers (`createEntityStub`, `getUploadLocation`, `getSourceField`) when building a plugin.
- Alter source plugin definitions via `hook_media_library_source_info_alter()`.
- Expose community source plugins (e.g. Media Library Youtube) as Media Library tabs.
- Map an external item id back to a Drupal media id through `getEntityId()`.
- Let editors keep using the familiar core Media Library UI while sourcing from elsewhere.
- Build an internal image gallery / shared asset picker as a Media Library pane.
- Prototype a media integration quickly by copying the Lorem Picsum example plugin.
- Manage available panes (add/edit/delete) from a config entity list at the panes admin page.
