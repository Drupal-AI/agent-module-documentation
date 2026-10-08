# Configuration

Remove HTTP Headers has a single, simple setting: the list of header names to
strip from responses.

## Open the settings form

Go to **Configuration → System → Remove HTTP headers settings**
(`/admin/config/system/remove-http-headers`). Reaching this form requires the
**Remove HTTP headers settings access** permission, which is marked as
security‑sensitive — grant it only to trusted, administrative roles.

## The header list

The form is a single **textarea** where you list **one header name per line**.
Whatever appears here is removed from every main‑request response. The default
list is:

```
X-Generator
X-Drupal-Dynamic-Cache
X-Drupal-Cache
```

- **`X-Generator`** — announces "Drupal N". Removing it also strips the
  `<meta name="Generator">` tag from the page HTML.
- **`X-Drupal-Dynamic-Cache`** — reveals dynamic‑page‑cache state.
- **`X-Drupal-Cache`** — reveals page‑cache HIT/MISS state.

You can keep these, replace them, or add others. A common addition is
**`X-Powered-By`** if your web server or PHP adds one.

When you save, the form validates that no header name contains whitespace; an
entry with a space in it is rejected with a "The format of the HTTP headers field
is not valid" error. Each header name is a single token like `X-Powered-By`.

The list is stored as exportable configuration (in the `remove_http_headers.settings`
object), so you can deploy it between environments with `drush config:export` and
`drush config:import`, or set it from the command line with `drush config:set`.

## Verifying it worked

Load a page and inspect the response headers (for example with your browser's
developer tools or `curl -I`). The headers you listed should no longer be
present.

## Permissions

The module defines one permission:

- **Remove HTTP headers settings access** — controls access to the settings form
  above. It is flagged as restricted because the header list has security
  implications; keep it to site administrators.
