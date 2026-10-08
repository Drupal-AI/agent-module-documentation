<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Canonical Download allows media to serve files directly from their canonical routes.

---

Media Canonical Download makes a media entity's canonical URL serve its file directly — so visiting a
media item's canonical route returns/downloads the underlying file instead of the media view page, useful
where the media should be a direct file link. It alters the media routes (via a route subscriber) to a
download controller, in the Media package.

Use it to make media canonical URLs act as direct file downloads. The security-relevant point: because it
alters the media **canonical** route (which is access-checked with media *view* access), serving the file
runs under that access — so a user must be able to view the media to download its file (the module sets
`Cache-Control: private` on the response). Verify that behaviour matches your intent for private/restricted
media (the download follows media view access, not a broader gate). It provides an alter hook for the
response. It has no additional access-control role. Configure the canonical-download behaviour.

---

- Serve a media file at its canonical route.
- Make the canonical URL a direct download.
- Return the file instead of the view page.
- Alter media routes to a download controller.
- Run under media view access.
- Require view access to download.
- Set Cache-Control: private.
- Verify behaviour for private/restricted media.
- Provide a response alter hook.
- Have no additional access-control role.
- Configure canonical download.
- Handle media downloads.
- Serve files directly.
- Configure the behaviour.
- Download media files.
- Handle canonical routes.
- Serve media files.
- Configure downloads.
- Respect media access.
- Serve at canonical.
