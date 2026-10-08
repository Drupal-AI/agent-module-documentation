<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Photos is a picture-management module for building photo albums: it adds a "Photo album" content type whose nodes hold many images stored as `photos_image` entities, with multi-upload, image styles, cover images, sorting, comments and search.

---

Enabling Photos installs a **Photo album** node type (`photos`) and a dedicated `photos_image`
content entity (revisionable, translatable, base table `photos_image`), plus extra tables
`photos_album` and `photos_count`. An album is a node; its photos are `photos_image` entities
uploaded to it (single, multi via Plupload, ZIP archive, or directory import). The upload
pipeline is the `photos.upload` service (`Drupal\photos\PhotosUpload`). Global behaviour is
configured at `/admin/config/media/photos` (route `photos.admin.config`,
`PhotosAdminSettingsForm`) with the `photos.settings` config — image-size selections per view
mode, image ordering, pager sizes, per-page counts, cover/teaser display, clean titles, ZIP
upload, Plupload toggle, etc. A structure page (`/admin/structure/photos`, route `photos.admin`,
the `configure` link) is the field-UI base route. Photos ships many plugins: field formatters
(`PhotosAlbumFormatter`, `PhotosAlbumCoverImageFormatter`, a media field formatter), a Block
(`PhotosInformation`), a text-format Filter (`PhotosFilter` to embed images), a Media source
(`Photos`), a Search plugin (`PhotosImageSearch`), Views field/data integration (cover, set
cover), and D7→D10 migrate source/destination plugins. It defines seven permissions (view/create
photo, edit/delete own/any photo, view original) and integrates with nodes, users (per-user photo
counts and a user photos view), comments, tokens, and image styles. The companion submodule
**Photos access** adds per-album privacy (open/locked/user-list/password). Recommended companions
include Crop API, Image Widget Crop, Colorbox and Plupload.

---

- Create a photo album (a "Photo album" node) and upload many images into it.
- Upload multiple images at once with Plupload integration.
- Upload a ZIP archive of images and have them extracted into an album.
- Bulk-import images from a server directory (`/photos/import`).
- Manage individual photos as `photos_image` entities (edit title, description, weight).
- Set an album cover image and display it in teasers/lists.
- Choose which image style is used per view mode (cover, list, full, teaser, pager).
- Order photos in an album by weight, and rearrange them via drag-and-drop.
- Show a per-user gallery of that user's albums/photos.
- Add a photo-count badge to albums and users.
- Let visitors comment on individual photos.
- Vote on / flag photos (with the Flag module).
- Embed a photo or album into rich text via the Photos text-format filter.
- Expose photos as a Media source for the media library.
- Add a "Photos information" block to a page.
- Provide full-size "view original" access controlled by permission.
- Search photos via the core Search integration.
- Paginate large albums with configurable pager sizes.
- Auto-clean uploaded file titles for tidy display.
- Migrate Drupal 7 photo albums/images into Drupal 10/11 using the bundled migrate plugins.
- Restrict who can create, edit, or delete photos via the module's permissions.
- Integrate album/photo data into Views (cover field, set-cover link).
- Use tokens for photo/album fields in patterns and messages.
- Combine with Photos access to lock albums or protect them with a password.
- Auto-fix image orientation on upload (with EXIF Orientation).
- Generate multiple named image sizes for download from a single upload.
