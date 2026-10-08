# Configuration

## Open the settings form

1. Log in as a user with the **Admin url restriction by role settings**
   permission.
2. Go to **Configuration → Search and metadata → URL aliases → URL restriction by
   role**, or navigate directly to
   `/admin/config/search/path/url-restriction-by-role`.

## The restrictions table

The form is a table of URL rows plus two message options:

- **URL** — the path pattern to restrict, for example `/node/add` or `/members/*`.
  A validator **rejects any URL that contains a dot (`.`)**, so file-like paths
  (anything with an extension) cannot be entered here.
- **Enabled** — a per-row toggle. Unticked rows are ignored, so you can retire a
  restriction without deleting it.
- **Allowed Roles** — a multi-select of the roles allowed to reach the URL. A
  visitor who holds **none** of the allowed roles is denied.
- **Error Message** — the text shown to a denied visitor when the custom-message
  option (below) is on. The default is *"You do not have access to this page"*.
- **Use custom error message?** — when checked, denied visitors get a raw 403
  response carrying your message; when unchecked, they are sent to the site's
  standard 403 page instead.

Click **Save configuration** when you're done.

## How matching works

On every request, the module checks each enabled rule against **both** the current
internal path and its URL alias, using Drupal's path matcher — so `*` wildcards
work (`/members/*` covers `/members/join`, `/members/area/profile`, and so on). If
the visitor lacks all of the allowed roles for a matching rule, they're blocked.

## Caveats to understand before you rely on this

This module is a coarse, path-based gate. It is genuinely useful, but there are
enforcement limits worth knowing:

- **It's an allow-list, not a default-deny.** Only the paths you list *and* enable
  are restricted; everything else is fully accessible. To cover a whole section you
  need a wildcard pattern that catches every path within it.
- **Anonymous users + the page cache.** The check runs as a request
  subscriber, but Drupal's Internal Page Cache serves cached pages to anonymous
  visitors *before* that subscriber runs. So a restriction meant to hide a page
  from **anonymous** users is not applied on a cache hit. Do **not** rely on this
  module to hide content from anonymous visitors while Internal Page Cache is on —
  use real route/entity permissions for that. It works reliably for restrictions
  based on authenticated roles.
- **Matching is exact/wildcard on the raw path string** and is case- and
  encoding-sensitive. Alternate casing, URL-encoding, or trailing variations that
  resolve to the same page may slip past a rule. Prefer wildcard prefixes and test
  each rule.
- **Paths with a dot can't be configured** (the validator blocks them), so
  file-like URLs can't be restricted here.

### Avoid locking yourself out

Because a rule blocks anyone lacking the allowed roles, be careful restricting
broad admin-ish paths. Always include a role you personally hold (for example
*administrator*) in the **Allowed Roles**, save, and immediately test in a private
browser window or as a lower-privileged user — not by logging yourself out — so you
can undo a mistake. If you do lock yourself out of the settings form, you can clear
the restriction from the command line, for example:

```bash
ddev drush cset url_restriction_by_role.settings urls.'/members/*'.enabled 0 -y
```

## The config object

No config schema ships, so the stored config is plain YAML in
`url_restriction_by_role.settings`:

```yaml
urls:
  '/members/*':
    enabled: true
    role:            # role IDs allowed to view
      - member
      - administrator
  '/node/add':
    enabled: true
    role:
      - editor
error_message: 'You do not have access to this page'
use_custom_error_message: false
```

Editing this via the admin form (or a config import) is easiest, because the
allowed roles are stored as a list.
