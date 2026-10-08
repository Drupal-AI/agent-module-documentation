# POST File — manual setup guide

**POST File** (`postfile`) adds an API endpoint — **`POST /postfile/upload`** — that lets an
external client push a single file into Drupal's managed file storage. It's built for
integrations that need to send files into your site programmatically (for example a nightly
export that drops a CSV into a private directory).

The endpoint authenticates callers with Drupal core's **Basic Auth** REST provider, and the
upload only proceeds when the caller is a **real, authenticated user who holds the "POST file"
permission** — anonymous requests are rejected in code. Uploaded files are validated before
they are saved: filenames are sanitised, Drupal's insecure‑extension rule is enforced, and the
name must match an **allowed‑extensions allowlist** you configure. Files are written to a file
system (public, private, and so on) that you choose.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

The module's few settings are covered under "How to use it" below rather than in a separate
configuration chapter.

## How to use it

1. **Create a dedicated API user** and grant it the **POST file** permission on
   **People → Permissions**. Grant this permission only to trusted integration accounts — it
   allows writing files into your site.
2. **Configure the upload settings** — the target **file system / directory** and the
   **allowed file extensions** allowlist. Keep the allowlist as tight as the integration needs
   (for example just `csv`), so unexpected file types are refused.
3. **Send files** with an authenticated multipart POST. Always use **HTTPS** so the Basic Auth
   credentials are not sent in the clear:

   ```bash
   curl --location 'https://www.example.com/postfile/upload' \
     --header 'Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=' \
     --form 'file=@"/path/to/file.csv"'
   ```

The endpoint accepts one file per request and returns once the file is validated and stored.

### Security notes

- The upload route is technically open (`_access: TRUE`), but the controller enforces
  **non‑anonymous + "POST file" permission** itself, so an unauthenticated request cannot
  upload. Still, treat the permission as sensitive and grant it only to trusted clients.
- Keep the **allowed‑extensions allowlist** tight and leave Drupal's insecure‑extension
  protection in place.
- Serve the endpoint over **HTTPS only**, since Basic Auth transmits the username and password
  with every request.
