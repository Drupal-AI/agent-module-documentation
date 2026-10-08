# Configuration

Private File Token has **no admin settings form**. It works automatically once
enabled, and has exactly one setting — how long a signed URL stays valid. This
page covers that setting and, just as importantly, the security trade‑offs you
should weigh when choosing its value.

## The one setting: token lifetime

The setting lives in the config object `private_file_token.settings`, key
`expiration_time` (an integer number of **seconds**). It defaults to **10800**
seconds — **3 hours**.

A token minted for a private‑file URL is valid until this many seconds have passed
since it was generated. After that the URL stops working and the normal per‑user
private‑file access check applies again.

### Change it with Drush

```bash
# Shorten to 5 minutes for sensitive downloads:
ddev drush config:set private_file_token.settings expiration_time 300 -y
```

### Or override it in settings.php

```php
$config['private_file_token.settings']['expiration_time'] = 300;
```

Lower the value for shorter‑lived, safer links; raise it where longer‑lived links
are acceptable (for example an emailed link a recipient may open hours later).

## Choosing a value — security considerations

Because a tokenized URL is a **bearer credential** (anyone who has the link can use
it, with no login), the expiry window is your main lever for limiting exposure:

- A URL can leak through referrer headers, proxy/access logs, browser history, or a
  simply forwarded link. For the remainder of the window, whoever holds it can
  download the file. Tokens **cannot be revoked** before they expire and are
  **reusable** during their lifetime.
- For anything sensitive (invoices, reports, personal documents), prefer a short
  window — minutes rather than hours.
- Remember the effect is **site‑wide**: there is no per‑file or per‑field opt‑in,
  so this one value governs every private file on the site.

The token itself is a keyed HMAC over the file path and timestamp, signed with the
site's private key and hash salt — it is not guessable or forgeable, and it is
scoped to a specific path. The exposure you are managing is a *leaked* URL, not a
weak token.

## Which files and routes are covered

Once enabled, tokens are honored on Drupal's three private‑file download routes:
the standard private file download, the generic `/system/files` route, and private
image‑style derivatives (`/system/files/styles/...`). So both raw private files and
private image derivatives can be served with a signed URL.

## For developers: minting and verifying tokens

You normally don't touch tokens yourself — URLs are signed automatically and
validated on download. For custom URL shapes, the `private_file_token` service
(`PrivateFileTokenGenerator`) exposes:

- `get(string $path, int $timestamp): string` — mint a token for a path.
- `validate(string $token, string $path, int $timestamp): bool` — verify one.

The `$path` must be the exact request path (base path stripped) that the browser
will hit. See the sibling [`agent/`](../agent/start.md) API docs for a full
example.
