<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Tamper Media URL adds a single Tamper plugin that turns a file URL in an imported Feeds row into a Media entity, fetching the file, saving it, and returning the new media's ID for a media-reference mapping.

---

The module ships one Tamper plugin, **`create_media_tamper`** ("Create Media Tamper", category *Other*), used on a Feeds Type source that carries a file URL. It has two settings configured on the Tamper form: **Media type** (a select of the site's media bundles, e.g. `image`, `document`) and **Media field** (a text field naming the file/image field on that media bundle, e.g. `field_media_image`). At import, for each row it derives a filename from the URL's basename (stripping any query string), then looks for an existing `file` entity with that filename. If none exists it downloads the URL's contents with a Guzzle HTTP GET and writes them to `public://{filename}`, creating a managed file. It then looks for an existing media entity referencing that file through the configured field; if none is found it creates a new media entity of the chosen bundle (owner uid 1, English, published) pointing its media field at the file. The plugin returns the media entity's ID, so the mapped target should be a media-reference field. If the same filename is imported again the existing file and media are reused rather than re-downloaded, making imports idempotent by filename. The info file declares no dependencies, so install and enable `feeds`, `feeds_tamper`, `tamper` and core `media` yourself. It is intended for browser-accessible file URLs (the project notes it currently targets images).

---

- Import remote image URLs from a feed and create Media entities from them.
- Populate a media-reference field on imported content from a URL column.
- Download a file named in a CSV/RSS/JSON feed into the site's public files.
- Create an `image` media item for each row of an image-URL feed.
- Create a `document` media item from a linked PDF/file URL.
- Reuse an already-imported file instead of downloading it twice.
- Associate existing media with new content when the filename already exists.
- Build a media library by importing a list of asset URLs.
- Map a product-photo URL feed to a media-reference field on products.
- Turn a third-party asset export (URL list) into local media.
- Attach a hero image to imported articles from a URL source.
- Migrate images referenced by URL from a legacy system into Media.
- Keep imports idempotent by filename so re-running does not duplicate files.
- Select which media bundle each imported file becomes.
- Point the created media at a specific file/image field by machine name.
- Chain after other Tamper plugins that normalise or build the URL string.
- Fetch and store gallery images listed in a feed.
- Create media for downloadable resources listed in a data feed.
- Convert a plain URL string mapping into a usable media reference target.
- Bulk-create media entities as part of a scheduled Feeds import.
- Import avatars/profile images referenced by URL.
- Seed a site's Media with sample assets from a URL manifest during setup.
