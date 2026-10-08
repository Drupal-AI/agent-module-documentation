# Configuration — editing robots.txt

RobotsTxt has a single settings page with one textarea holding the entire
`robots.txt` file body. Whatever you type here is served at `/robots.txt`. There
are no other options to configure — the whole file is edited in place.

Before you begin, make sure you have completed the
[installation](../installation/index.md) step of removing the physical
`robots.txt` file; otherwise your edits here will not be served.

## Open the settings page

1. Go to **Configuration → Search and metadata → RobotsTxt**
   (`/admin/config/search/robotstxt`).
2. You will see the **Contents of robots.txt** textarea, pre-filled with a default
   robots.txt (comments plus `User-agent`, `Allow`, and `Disallow` lines).

![The RobotsTxt settings page with the robots.txt contents textarea](../images/settings.png)

## Edit the contents

Type your rules directly into the textarea, one directive per line, following the
standard [robots.txt format](https://www.robotstxt.org/). The most common lines
are:

- **`User-agent:`** — which crawler the following rules apply to. Use `*` to target
  all bots, or a specific bot name (for example `User-agent: Googlebot`) to target
  one.
- **`Disallow:`** — a path prefix crawlers should not fetch, for example
  `Disallow: /admin/` to keep bots out of the admin area. `Disallow: /` blocks the
  entire site (useful on a staging or development site).
- **`Allow:`** — a path to permit even inside an otherwise disallowed directory,
  letting you carve out exceptions to a broader `Disallow`.
- **`Sitemap:`** — the full URL of your XML sitemap, for example
  `Sitemap: https://example.com/sitemap.xml`, so search engines can find it.

You can also add comment lines beginning with `#` to document why particular paths
are blocked.

A minimal example:

```text
User-agent: *
Disallow: /admin/
Disallow: /user/

Sitemap: https://example.com/sitemap.xml
```

## Save

Click **Save configuration** at the bottom of the form. Your changes take effect
immediately.

## Verify the result

Visit `/robots.txt` in your browser (for example
`https://example.com/robots.txt`). You should see exactly the content you saved.
If instead you see different content — or an old default — the physical
`robots.txt` file is probably still present in the docroot and is being served
before Drupal's route; return to [Installation](../installation/index.md) and
remove it.
