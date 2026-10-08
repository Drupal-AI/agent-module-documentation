<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI IIP Image connects a collection to an IIP image server, so high-resolution images are served as tiles rather than as files.

---

A 400-megapixel scan of a manuscript page cannot be delivered as a file — the browser would have to download hundreds of megabytes to show a thumbnail. Tiled image servers solve that: the client requests only the tiles for the region and zoom level it is showing, and IIPImage is a long-established open-source implementation.

This submodule is the Drupal side of that arrangement, so a WissKI record's images are served through IIP and can be deep-zoomed and viewed in a IIIF viewer such as Mirador.

**This is infrastructure, not a module setting.** IIPImage is a separate server process that has to be installed, configured and kept running, with the images in a tiled format (typically pyramidal TIFF) that a conversion step produces. A project planning high-resolution imaging should budget for that server and its storage from the start — retrofitting it after a digitisation campaign means reprocessing everything.

The payoff is that the same infrastructure makes images usable by other institutions' viewers, which is the point of publishing to IIIF at all.

---

- Serve a very high-resolution image.
- Deep-zoom a manuscript page.
- Avoid downloading huge image files.
- Serve images as tiles.
- Connect a collection to an IIP server.
- Feed images to a Mirador viewer.
- Publish images for external IIIF viewers.
- Plan an image server before digitising.
- Budget storage for pyramidal TIFFs.
- Convert images to a tiled format.
- Avoid retrofitting IIIF after a campaign.
- Share images with another institution.
- Diagnose images that will not zoom.
- Audit which images are tiled.
- Keep the image server running.
