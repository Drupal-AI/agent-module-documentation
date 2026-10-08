# File Download Token — manual setup guide

**File Download Token** (`file_download_token`) generates tokenized download
links — a URL of the form `/token-download/{token}` that lets whoever holds it
download one specific file, without exposing the file's real path on disk and
without requiring them to log in. It is designed for scenarios like "email
someone a secure, time-limited link after they submit a form or complete a
purchase."

The design is deliberately careful. Each token is a **strong,
cryptographically-random value** (about 440 bits of entropy), so it cannot be
guessed. It is **bound to one specific file** — the download route accepts only
the token, and the file it serves comes from the token record, so nobody can swap
in a different file id. And tokens **expire and are cleaned up after 24 hours**,
so a leaked link does not stay valid forever.

The most important thing to understand about the security model is that the link
is a **capability**: anyone who has the URL can download the file, because the
route is public by design. So treat the link as being exactly as sensitive as the
file itself — **deliver it over a secure channel**, don't post it somewhere it can
be forwarded, don't put highly sensitive files behind a link that might be shared,
and rely on the 24-hour expiry. The module does not add per-user access control;
possession of the URL is the access.

It optionally integrates with the **Webform** module through the bundled
`file_download_token_webform` submodule, and supports Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the Webform submodule.

There is no global settings form to configure — you issue tokenized links (for
example through the Webform integration) and hand them out.

## How to use it with Webform

1. Enable the `file_download_token_webform` submodule (see
   [Installation](installation/index.md)).
2. On your webform, open the **Settings → Confirmation** tab and set a file under
   **Download token file**.
3. Add the `[webform:file-download-token-url]` token into the text of a webform
   handler (for example a confirmation email). When the form is submitted, the
   token resolves to a fresh, time-limited download link for that file.
