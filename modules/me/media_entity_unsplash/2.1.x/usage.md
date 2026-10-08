<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity: Unsplash provides a media source plugin for Unsplash, letting editors use Unsplash images as Drupal media entities.

---

Media Entity: Unsplash provides a media source plugin (`unsplash`) that lets editors search and use
Unsplash stock photos as Drupal media entities. Editors either paste an Unsplash photo ID or URL or use
the in-form autocomplete to search the Unsplash library; the module then fetches the photo through the
Unsplash API, stores a local image, and automatically generates the photographer attribution ("Photo by
… on Unsplash") that the Unsplash API terms require. It provides a ready-made `unsplash` media type with a
source field, an image field, and an attribution field, and works with Drupal's Media Library.

The module authenticates to the Unsplash API using an Access Key and Secret Key, which are entered on the
Unsplash media type's source configuration form. It requires only Drupal core modules (`image`,
`media_library`, `path`, `user`) plus the `unsplash/unsplash` PHP SDK, runs on Drupal 11.3+/12, and uses
the standard per-bundle media permissions for access — it adds no permissions of its own. Configure the
Unsplash credentials, then add photos from the media add form or the Media Library.

---

- Use Unsplash images as Drupal media entities.
- Search the Unsplash library from the media add/edit form (autocomplete).
- Paste an Unsplash photo ID or full URL to add a specific photo.
- Fetch photos through the Unsplash API and store them locally.
- Generate photographer attribution automatically ("Photo by … on Unsplash").
- Provide a ready-made `unsplash` media type with source, image, and attribution fields.
- Integrate with Drupal's Media Library.
- Configure the Unsplash Access Key and Secret Key on the media type source form.
- Set a UTM source parameter for the attribution links.
- Generate and cache local thumbnails for Unsplash photos.
- Show a thumbnail preview when editing an Unsplash media item.
- Populate the attribution field on save.
- Gate the search autocomplete to users with create/edit Unsplash media permission.
- Add Unsplash media to nodes via media reference fields.
- Embed Unsplash photos through the Media Library and CKEditor.
- Run on Drupal 11.3 or 12 with only core module dependencies.
- Store the downloaded image in `field_media_unsplash_image`.
- Keep photographer name, username, and profile URL as media metadata.
- Comply with Unsplash API/attribution terms while using stock images.
- Reuse imported Unsplash photos across the site like any local image.
