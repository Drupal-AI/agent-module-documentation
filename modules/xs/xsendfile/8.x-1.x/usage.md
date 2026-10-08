<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Xsendfile offloads private file transfers to the web server for speed.

---

**Xsendfile** speeds up private file downloads by handing the transfer to the web server via the `X-Sendfile` (Apache mod_xsendfile) or `X-Accel-Redirect` (Nginx) header instead of streaming through PHP. A route subscriber overrides core's `system.files`, `system.private_file_download` and `image.style_private` controllers with drop-in subclasses that **preserve core's access model** — access is still delegated to `hook_file_download()` (a module must return headers, or -1 denies), and the image controller keeps core's SA-CORE-2023-005 `..` traversal guard and derivative-token check. The transfer method (PHP / Apache / Nginx) is chosen at `/admin/config/media/file-system/xsendfile` (`administer site configuration`).

Use it on private-file-heavy sites to reduce PHP memory/time spent streaming large files.

---

- Serve private files via X-Sendfile or X-Accel-Redirect.
- Offload large file transfers from PHP.
- Speed up private file downloads.
- Serve private image-style derivatives quickly.
- Override core file-download controllers.
- Preserve hook_file_download() access checks.
- Keep the core image derivative token check.
- Keep the SA-CORE-2023-005 traversal guard on images.
- Choose Apache X-Sendfile transfer.
- Choose Nginx X-Accel-Redirect transfer.
- Fall back to PHP (BinaryFileResponse) transfer.
- Reduce memory use on big downloads.
- Configure the transfer method in admin.
- Gate settings behind 'administer site configuration'.
- Support private-file-heavy sites.
- Deny access when no module vouches for the file.
- Return 404 for missing files.
- Improve throughput for media-heavy sites.