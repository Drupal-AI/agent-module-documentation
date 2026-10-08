# Configuration

ads.txt stores the bodies of both files in one config object (`adstxt.settings`,
with keys `content` and `app_content`) and serves them from two public URLs.

## Open the settings form

1. Log in as a user with the **Administer ads.txt** permission.
2. Go to **Configuration → System → ads.txt**, or navigate directly to
   `/admin/config/system/adstxt`.

## The form fields

- **ads.txt content** — a textarea holding the full body of your `/ads.txt` file.
  One authorized‑seller declaration per line, for example:

  ```
  greenadexchange.com, 12345, DIRECT, AEC242
  silverssp.com, 9675, RESELLER
  ```

  Each line names an ad system's domain, your seller/account ID, the relationship
  (`DIRECT` or `RESELLER`), and an optional certification (TAG) ID.

- **app-ads.txt content** — a second textarea holding the full body of your
  `/app-ads.txt` file, for authorizing sellers of your mobile/CTV app inventory.
  Same line format.

When you save, the module normalizes line endings to `\n`.

## Where the files are served

The generated files are available publicly (they must be crawlable) at:

- `/ads.txt`
- `/app-ads.txt`

Both are served as `text/plain` and are cached, invalidating automatically when the
config — or a contributing module (see below) — changes. If, after combining config
and any programmatic additions, the content is empty, the module returns a proper
**404** rather than an empty file (and that 404 is itself cached and correctly
invalidated once you configure content again).

## Adding lines from code (optional)

Other modules can append lines programmatically, so a base list in config can be
combined with dynamically generated lines:

- `hook_adstxt()` — return an array of extra lines for `/ads.txt`.
- `hook_app_adstxt()` — the same for `/app-ads.txt`.

Both receive a cacheable‑metadata object so your implementation can register cache
tags/contexts that keep the served file correctly invalidated. The contributed
lines are merged with the config body, trimmed, and empty lines filtered out. See
the [`agent/`](../agent/start.md) docs for the exact hook signatures.

## Health checks to be aware of

The module adds runtime checks to the status report (**Reports → Status report**):

- **Error** if Clean URLs are disabled — the `/ads.txt` route can't resolve without
  them.
- **Warning** if a physical `ads.txt` file exists in your docroot — the webserver
  would serve that file and bypass the module. Remove it so the dynamic route wins.
