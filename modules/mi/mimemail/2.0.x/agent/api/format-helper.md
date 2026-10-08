# MimeMailFormatHelper API

Static utility `Drupal\mimemail\Utility\MimeMailFormatHelper` — the low-level routines the
`mime_mail` plugin uses; callable directly from custom code.

| Method | Purpose |
|---|---|
| `mimeMailAddress($address, $simplify = FALSE)` | Format an address (or array of them) into an RFC-compliant `Name <mail>` string; `$simplify` returns the bare email. |
| `mimeMailHtmlBody($body, $subject, $plain = FALSE, $plaintext = NULL, array $attachments = [])` | Build the full message body: returns `['body' => …, 'headers' => …]`, embedding images, adding a plain-text alternative and any attachments. |
| `mimeMailExtractFiles($html)` | Scan HTML for referenced local files/images and return them as parts to embed. |
| `mimeMailFile($url = NULL, $content = NULL, $name = '', $type = '', $disposition = 'inline')` | Register a file (by URL or raw content) as an inline or attachment part; returns its Content-ID. Called with no args returns everything stored. |
| `mimeMailMultipartBody(array $parts, $content_type = 'multipart/mixed; charset=utf-8', $sub_part = FALSE)` | Assemble MIME multipart body from parts. |
| `mimeMailRfcHeaders(array $headers)` | Encode headers per RFC 2047. |
| `mimeMailHeaders(array $headers, $from = NULL)` | Normalize/merge message headers. |

Typical use is indirect: send through `MailManagerInterface::mail()` with Mime Mail selected
in Mail System (see configure/activate.md). Call these helpers directly only when you need to
pre-build a MIME body or attach generated files outside the normal mail flow. Attaching files
from outside the public files directory is gated by the `send arbitrary files` permission.
