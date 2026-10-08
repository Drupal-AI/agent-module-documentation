<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Garden Gnome Package integrates Garden Gnome Software's Pano2VR and Object2VR exports into Drupal, letting you upload a package archive and embed the interactive panorama or object movie in content.

---

It provides a custom field type (GgnomeField) and field formatter (GgnomeFieldFormatter): when a package file is saved, the module unzips it (via Drupal core's Zip archiver) into a directory under the public files scheme, parses gginfo.json (or legacy player files) to detect whether it is a Pano2VR or Object2VR export, copies the appropriate player into a versioned public directory, and renders the viewer with options like preview-only, autoplay, play button, and start node/view. A settings form at /admin/config/media/garden_gnome_package (perm 'administer site configuration') sets defaults such as the preview icon. It depends on field, media, and system. Because it extracts uploaded ZIP archives into the web-accessible public files directory, restrict who may upload packages to trusted editors. Use it to publish virtual tours, 360 photography, and product object-movies.

---

- Embed an interactive 360 panorama on a page.
- Publish a virtual tour exported from Pano2VR.
- Show a rotatable product object movie from Object2VR.
- Add a panorama field to a content type.
- Render a VR viewer inline in article content.
- Display a preview image that opens the full tour.
- Autoplay a panorama on page load.
- Set a starting node/view for a multi-scene tour.
- Host real-estate walkthroughs on the site.
- Present museum or gallery 360 exhibits.
- Bundle player assets automatically from the uploaded package.
- Manage a default preview icon site-wide.
- Show product 360-spins on commerce pages.
- Publish location tours for travel content.
- Version player files per package automatically.
- Reuse the same package across multiple nodes.
