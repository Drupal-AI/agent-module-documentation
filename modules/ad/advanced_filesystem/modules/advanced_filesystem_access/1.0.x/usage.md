Adds signed, expiring download URLs plus per-file download-count limits, IP restrictions and an access log on top of Drupal file entities.

---

Advanced Filesystem: File Access Control (machine name `advanced_filesystem_access`) lets a site hand out time-limited, tamper-proof download links to managed files without exposing their raw public URLs. A signing secret is stored in module settings; the `FileAccessService` HMAC-signs `fid`+`expires` into a token and builds a URL `/adfs/download/{fid}/{token}?expires={timestamp}`. The `SecureDownloadController` re-computes the HMAC, verifies it in constant time, checks IP allow/block lists and the file's download limit, records the download in an access log, then streams the file as an attachment. Themes generate links with the `adfs_signed_url` Twig filter/function. Per-file rules (download limit, expiry, IP allow/block) are set on an "Access Rules" tab on each file; global settings and the log viewer live under the Advanced Filesystem admin area. It depends on `file` and the parent `advanced_filesystem` module and is administered through one restricted permission.

---

- Share a document with a partner via a link that stops working after one hour.
- Publish time-limited download links for paid or gated digital assets (PDFs, ZIPs, media).
- Emit signed download links in a Twig template: `<a href="{{ file|adfs_signed_url('24h') }}">Download</a>`.
- Emit a signed link from an entity-reference field: `{{ node.field_attachment.target_id|adfs_signed_url('2h') }}`.
- Generate a signed link programmatically with `FileAccessService::generateSignedUrl($file, $ttl)`.
- Limit a sensitive file to a fixed number of downloads (e.g. a one-time license file).
- Cap total downloads per file so a leaked link cannot be reused indefinitely.
- Restrict a file so only a corporate IP range (CIDR) can download it via the secure endpoint.
- Block specific abusive IPs/CIDRs from all signed downloads with a global blocklist.
- Block individual IPs for a single file while leaving the rest of the site unaffected.
- Set an absolute expiry date/time on a file after which the signed endpoint denies access.
- Keep an audit trail of who downloaded which file, when, from which IP and user agent.
- Review the recent download log for a specific file on its "Access Rules" tab.
- Prune old access-log rows automatically on cron using a configurable retention window.
- Prune the access log on demand from the settings form's "Prune old log entries now" button.
- Rotate the signing secret to instantly invalidate every previously issued signed URL.
- Use TTL shorthands (`30m`, `2h`, `7d`, `1w`) or raw seconds when building links in Twig.
- Serve downloads with `Content-Disposition: attachment` and no-cache headers for sensitive content.
- Enforce a per-file download-count ceiling even on ordinary core file downloads via `hook_file_access()`.
- Preview the signed URL that would be generated for a file directly on its "Access Rules" tab.
