<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
THRON integrates the THRON DAM platform into Drupal, providing an Entity Browser widget to search and select THRON assets, a CKEditor 5 embed button, a media source, and a chunked S3 upload flow — with THRON as the single source of multimedia files.
---
The module authenticates to THRON with client_id/app_id/app_key credentials (and optional THRON X client id/secret) stored in `thron.settings` config and edited at `/admin/config/services/thron` (permission `administer thron configuration`, `restrict access: TRUE`). `THRONApi` (service `thron_api`) wraps login, content search/detail, tag/classification/category lookups, player-template and embed-code generation, caching results in the `thron` cache bin. Lower-level HTTP is handled by the `Thronintegration_*` helper classes.

TLS verification is ON: all Guzzle requests in `THRONApi` pass `'verify' => TRUE`, and the only `CURLOPT_SSL_VERIFYHOST`/`CURLOPT_SSL_VERIFYPEER` lines in `Thronintegration_HTTP` are commented out (so cURL keeps its secure defaults). Outbound request URLs are built from configured THRON endpoints and the returned S3 credentials, not from request parameters, so there is no user-controlled SSRF surface. Editor-facing routes — tag/category/language autocomplete and the `/thron/upload/chunk` + `/thron/upload/finalize` chunked upload — require the `thron search media` permission; the upload controller obtains short-lived S3 credentials from THRON and streams chunks to a multipart upload keyed in the session.

Setup: obtain THRON credentials, enter them on the configuration form, choose intelligence classifications to search on, add the THRON button to a CKEditor 5 text format, and expose the THRON Entity Browser widget in your media fields.
---
- Search the THRON DAM from a Drupal Entity Browser widget.
- Embed THRON assets into content via a CKEditor 5 button.
- Upload local files to THRON through a chunked S3 multipart flow.
- Autocomplete THRON tags scoped to enabled classifications.
- Autocomplete THRON categories and languages.
- Configure THRON credentials at `/admin/config/services/thron`.
- Restrict search on selected intelligence classifications.
- Generate THRON player embed codes and templates.
- Cache THRON login and content lookups in a dedicated cache bin.
- Provide a THRON media source and media type.
- Use the media library entity browser with THRON assets.
- Impersonate an upload username for THRON uploads.
- Insert responsive picture markup for THRON images.
- Restrict configuration to trusted admins via a permission.
- Restrict media search/upload with `thron search media`.
- Retrieve content detail via the THRON X tenant API.
- Track content-intelligence interactions through THRON.
- Sort selected THRON tags in the widget UI.
- Finalize a multipart upload after all chunks are sent.
- Serve THRON media without duplicating files in Drupal.