<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
POST File lets you upload a file using an API endpoint.

---

POST File lets external clients **upload a file through an API endpoint** (`POST /postfile/upload`) — for
integrations that push files into Drupal's managed file storage. It depends on core Basic Auth and File,
provides its own permissions, in the Media package.

Use it to accept file uploads over an API. It is a media/integration feature and it is implemented **safely**:
although the route is `_access: TRUE`, the controller **enforces authorization in code** — it processes the
upload only when the caller is **non-anonymous AND holds the `postfile upload` permission** — and it validates
the file: it rejects Drupal's **insecure-extension** pattern (unless `allow_insecure_uploads`) and requires the
filename to match the admin-configured **allowed-extensions allowlist**, sanitizing the name first. Files save
to a configured directory. Grant `postfile upload` only to trusted API clients, keep the allowlist tight, and
use Basic Auth over HTTPS. It has no broader access-control role. Configure the upload directory and allowed
extensions.

---

- Upload files via an API endpoint.
- Serve integrations pushing files.
- POST to /postfile/upload.
- Depend on core Basic Auth and File.
- Provide its own permissions.
- Enforce authorization in code.
- Require non-anonymous + 'postfile upload' permission.
- Reject insecure extensions + require the allowlist.
- Sanitize the filename.
- Grant the permission only to trusted clients.
- Use Basic Auth over HTTPS.
- Configure directory + allowed extensions.
- Handle file uploads.
- Upload files.
- Configure the endpoint.
- Accept uploads.
- Handle the API.
- Save files.
- Keep the allowlist tight.
- Provide a file-upload API.
