# Configuration

All of the useful work in HTTP Status Code happens in one place: a list of
**path → status code mappings**. Each mapping tells the module "when a request
comes in for *this* path, send *this* HTTP status code back instead of the
normal one."

## Open the mappings list

1. Log in as a user with the **Administer HTTP status code**
   (`administer http status code`) permission.
2. Go to **Configuration → HTTP Status Code**, or navigate directly to
   `/admin/config/http_status_code/http_status_entity`.

You'll see a table of any existing mappings with edit and delete links, plus an
**Add** button.

## Add a mapping

Click **Add** (`/admin/config/http_status_code/http_status_entity/add`). The form
has these fields:

- **Label** — a human‑readable name so you can recognise the mapping later in the
  list (for example, "Old careers page → 410"). It has no effect on the response.
- **URL / path** — the request path to match. Matching is **exact** against the
  incoming request URI, so enter it exactly as the browser requests it, including
  the leading slash and any query string. `/old-page` and `/old-page?ref=x` are
  different matches.
- **Status code** — the HTTP status code to return when the path matches, such as
  `410` (Gone), `404` (Not Found), or `503` (Service Unavailable).

Save the form and the mapping takes effect immediately.

## Edit or delete a mapping

From the list, use the **Edit** link to change a mapping's path or status code,
or **Delete** to remove it — for example when a page is restored and should
return `200` again.

## How matching works (and a performance note)

On every response the module compares your configured paths against the current
request URI and, on a hit, overrides the response status code. Because that
lookup runs for *every* request, a very large set of mappings adds a small amount
of overhead to each page load. For a handful of retired URLs this is negligible;
if you find yourself adding hundreds of mappings, consider whether a redirect or
a server‑level rule fits better.

## Exporting mappings

Mappings are stored as configuration entities, so they are included when you
export your site configuration (`drush config:export`) and deploy with the rest
of your config — no need to recreate them by hand on each environment.

## A note on the settings form

The module also ships a separate settings form at
`/admin/config/http_status_code/settings` that exposes a single `automatic_410`
toggle. That feature is documented by the module as **not implemented yet**, so
the toggle currently does nothing useful — you can ignore this form and do all
your work from the mappings list above.
