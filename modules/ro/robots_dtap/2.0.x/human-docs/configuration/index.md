# Configuration

Robots DTAP has exactly one thing to configure: the list of domains that count as
**production**. Everything not on that list is treated as a non-production
environment and receives the `noindex, nofollow` meta tag.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Configuration → System → Robots DTAP**, or navigate directly to
   `/admin/config/system/robots_dtap/settings`.

## Production domains

The form has a single textarea for your **production domain(s)**:

- Enter one domain per line — for example `www.example.com`.
- Add every hostname that should be indexed. If your production site answers on
  more than one hostname (say `example.com` and `www.example.com`), list them all,
  one per line.
- Match how the host actually appears in requests. The module compares the incoming
  request's HTTP host against this list exactly, so a missing `www.` (or an extra
  one) will make production look like non-production.

Save the form when you're done.

## How the decision works

On every page, the module compares the current request's HTTP host to your list:

- **Host is in the list** → nothing is added; the page is indexable as normal.
- **Host is not in the list, and the list is non-empty** → the module attaches
  `<meta name="robots" content="noindex, nofollow">` to the page head, so crawlers
  skip it.
- **The list is empty** → the module adds nothing at all (so a fresh install is
  safe until you configure it).

Because the choice is driven by the host, the **same configuration works across
every environment** — you export this config once and it behaves correctly on dev,
test, acceptance, and production without any per-environment overrides.

## What it does *not* do

Robots DTAP only manages the **robots meta tag**. It does not create or edit a
physical `robots.txt` file. If you need environment-specific `robots.txt` behaviour,
pair it with (or choose) a robots.txt-focused module instead.

## Verify it

View the page source on a **non-production** host — you should see the
`noindex, nofollow` meta tag in the `<head>`. View source on your **production**
host — the tag should be absent.
