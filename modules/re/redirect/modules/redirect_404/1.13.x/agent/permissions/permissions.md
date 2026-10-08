# Permissions

Defined in `redirect_404.permissions.yml`.

| Permission | Gates |
|---|---|
| `ignore 404 requests` | Lets a user ignore specific logged 404 requests **without** the broader `administer redirect settings` (so they can't edit the exclude patterns). |

Related permissions from the parent module apply here too:

- `administer redirects` — view the **Fix 404 pages** report and create redirects from it.
- `administer redirect settings` — edit `redirect_404.settings` (row limit, exclude
  patterns, suppress_404); also permits ignoring 404s.

The ignore route requires `administer redirect settings+ignore 404 requests` (either grants
access).
