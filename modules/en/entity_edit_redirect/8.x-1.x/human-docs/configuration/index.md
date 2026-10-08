# Configuration

## Open the settings form

1. Log in as a user with the *"admininister entity edit redirect configuration"*
   permission (the module's own permission — the spelling really does have the
   extra "in").
2. Go to **Configuration → Content authoring → Entity Edit Redirect**, or
   navigate directly to `/admin/config/content/entity_edit_redirect`.

## The fields

- **Base redirect URL** (`base_redirect_url`) — the external editor's host,
  e.g. `https://editor.example.com`. This is where edit forms are sent. **Leave
  it empty to disable all redirects** — a handy off switch that doesn't require
  uninstalling the module.

- **Append destination** (`append_destination`) — a checkbox. When ticked, the
  editor's return URL is appended to the redirect as a query string, so the
  external editor can send the person back to where they were on your Drupal
  site. The return URL is resolved in this order: the `?destination=` query
  parameter, then a same-origin `referer` header, then the entity's canonical
  URL, then the site base URL.

- **Destination query-string key** (`destination_querystring`) — the name of the
  query parameter used for that appended return URL. Defaults to `destination`.
  Change it only if the external editor expects a different key.

- **Path patterns** (`entity_edit_path_patterns`) — a textarea holding the rules,
  **one per line**, in the form:

  ```
  entity_type[.bundle]:path/pattern/{uuid}
  ```

  - Use `entity_type:…` for a rule that covers every bundle of that type
    (e.g. `node:edit/{uuid}`).
  - Use `entity_type.bundle:…` to target a single bundle
    (e.g. `node.article:articles/edit/{uuid}`), so different content types can
    go to different editing screens.
  - `{uuid}` in the pattern is replaced with the entity's UUID.

  Only entity types/bundles you list here are redirected — omit a content type's
  pattern and its edit forms stay on Drupal as usual.

## How it behaves

For any route named `entity.{entity_type}.edit_form` (with a single route
parameter) that matches one of your patterns, the module builds
`base_redirect_url + '/' + path` and issues a 301 `TrustedRedirectResponse`. The
target host is always your configured base URL — it is never taken from the
request — and Drupal's trusted-redirect handling means this is not an open
redirect.

## Save

Click **Save configuration**. Changes take effect immediately — open an edit form
for a covered entity and you should land on the external editor.
