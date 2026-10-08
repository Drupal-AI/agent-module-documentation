# Configuration

Setting up Robots Rerouter takes one short form. You name your production hostname
and point the module at two files — the real `robots.txt` for production and a
fallback for everywhere else.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator).
2. Go to **Configuration → Search and metadata → Robots Rerouter**, or navigate
   directly to `/admin/config/search/robots-rerouter`.

## The settings

- **Production Hostname** — the domain that should serve your real `robots.txt`, for
  example `www.example.com`. Requests to `/robots.txt` whose host matches this get
  the production file; every other host gets the fallback.
- **Production File Path** — the path (relative to `public://`) of the file holding
  your real robots rules, for example `robots/good_robots.txt`.
- **Fallback File Path** — the path (relative to `public://`) of the disallow-all
  file served on non-production environments, for example
  `robots/nocrawl_robots.txt`.

## What happens when you save

On save, the module **automatically creates any missing folders and files** under
`public://` using secure, sandboxed file handling (this works even on hosted
platforms such as Acquia). So you don't have to pre-create the files — though you
will usually want to **edit the production file afterwards** to contain your real
`robots.txt` rules.

The fallback file defaults to a full disallow. A typical disallow-all looks like:

```
User-agent: *
Disallow: /
```

## How serving works

Once configured, a request to `/robots.txt` is answered dynamically:

- **Host matches your production hostname** → the **production file** is served.
- **Any other host** → the **disallow-all fallback** is served, keeping QA, staging,
  and dev out of search indexes.

## Verify it

Visit `/robots.txt` on a **non-production** environment and confirm you get the
disallow-all content. Visit `/robots.txt` on **production** and confirm you get your
real rules. If a non-production site still serves the production file, double-check
that the **Production Hostname** exactly matches how production's host appears in
requests (including or excluding `www.`).
