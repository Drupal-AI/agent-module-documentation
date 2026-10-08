<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Access via Webform provides token-gated file downloads via webform.

---

File Access via Webform provides a **token-gated file download tied to a webform** — after a webform
interaction, a user gets a link (`/…/{file}/{token}`) to download a file, with a Webform handler and a download
formatter. It depends on the Webform and core File modules, in the Webform package.

Use it to deliver files gated behind a webform flow. It is a forms/file-delivery feature and its access is
implemented **soundly (defense-in-depth)**: the download route's custom access check requires **both** a valid
**token bound to the specific file id** (`verifyToken($file->id(), $token)`) **and** the user's own core file
access (`$file->access('download')->orIf($file->access('view'))`) — the two are AND-combined, so the token is an
*additional* gate that can never grant access beyond what core file access already allows. Keep files in the
appropriate scheme (use private:// for restricted files) so core file access is meaningful. It has no broader
access-control role. Configure the webform handler and download.

---

- Provide token-gated file downloads via webform.
- Deliver a file after a webform flow.
- Link to /{file}/{token}.
- Depend on Webform and core File.
- Serve file delivery.
- Provide a Webform handler + formatter.
- REQUIRE a file-id-bound token (verifyToken).
- AND require core file access ($file->access).
- Combine them with AND (token can't grant beyond core access).
- Use private:// for restricted files (so core access is meaningful).
- Have no broader access-control role.
- Configure the handler and download.
- Handle webform file access.
- Download files.
- Configure the handler.
- Deliver files.
- Handle the token.
- Gate downloads.
- Keep files private.
- Provide token-gated downloads.
