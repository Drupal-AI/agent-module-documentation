# Private File Token — manual setup guide

**Private File Token** (`private_file_token`) lets Drupal serve **private files**
(and private image‑style derivatives) through a signed, time‑limited URL — so the
file can be downloaded without the usual per‑user private‑file access check. It
solves a common headache: private files normally require an authenticated Drupal
session, which breaks things like images in HTML emails, files fetched by a CDN
or reverse proxy that strips session cookies, downloads in a decoupled/JSON front
end, or documents opened by print/export tooling. With this module those consumers
can load a private file using nothing but a plain, signed link that expires on its
own.

It works by appending two query parameters — `token` and `timestamp` — to every
URL Drupal generates for a `private://` file. The token is a keyed HMAC computed
over the file's path and the timestamp, signed with the site's private key and
hash salt, so it cannot be forged or guessed by an outsider. When someone requests
a private file with a valid, unexpired token, the module grants the download
regardless of who they are. Tokens are valid for a configurable window (default
**3 hours**).

Enabling the module works site‑wide immediately — there is **no configuration
UI**, no permissions, and no Drush commands. The one setting, the token lifetime,
is changed through configuration. Developers can also mint or verify tokens in
custom code via the `private_file_token` service.

> **Important — tokens are bearer credentials.** A tokenized URL is **not** bound
> to a user or session: anyone who obtains the link can download the file until it
> expires, and enabling the module changes the access posture of **all** private
> files on the site at once (it is not per‑file opt‑in). There is no single‑use or
> revocation mechanism. Treat every signed URL as a temporary secret, keep the
> expiry short for sensitive files. The token itself is cryptographically sound — the risk is a
> *leaked* URL (via referrer headers, proxy logs, browser history, or a forwarded
> link), not a guessable token.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the token lifetime and understand
   the security trade‑offs.

## Where it lives in the admin menu

Nowhere — there is no settings page or menu item. Once enabled, the module signs
private‑file URLs automatically. The only setting (token lifetime) is changed via
Drush or `settings.php`, as described in [Configuration](configuration/index.md).
