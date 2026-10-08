<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the CDN & Sitemap warmers

Two plugins, two config paths. Schema: `warmer.settings.warmer_plugin.cdn` and
`warmer.settings.warmer_plugin.sitemap`.

## `cdn` — warm a URL list (`warmer.settings:warmers.cdn`)

```yaml
warmers:
  cdn:
    id: cdn
    frequency: 300
    batchSize: 50
    urls:                      # absolute or root-relative, one per line in the UI
      - 'https://example.com/'
      - '/about'
    headers: {  }              # 'Header-Name: value1; value2' per line
    verify: true               # SSL certificate verification
    maxConcurrentRequests: 10  # parallel requests (default 10)
```

## `sitemap` — warm URLs from XML sitemaps (`warmer.settings:warmers.sitemap`)

```yaml
warmers:
  sitemap:
    id: sitemap
    frequency: 300
    batchSize: 50
    sitemaps:                  # sitemap URLs to parse
      - 'https://example.com/sitemap.xml'
    minPriority: 0.5           # only warm URLs with <priority> >= this
    headers: {  }
    verify: true
    maxConcurrentRequests: 10
```

Notes: both fire async Guzzle GETs; a response status < 399 counts as warmed. `headers`
format is `Name: value1; value2` (semicolons split multiple values). The `sitemap` warmer
depends on `vipnytt/sitemapparser` and warms the URLs it discovers through the CDN logic.

## Set it up

UI: `/admin/config/development/warmer/settings` → the **CDN** or **CDN via Sitemap** tab.

Drush / scripted (lists need `php:eval`):

```bash
drush cset warmer.settings warmers.cdn.frequency 600 -y
drush php:eval '\Drupal::configFactory()->getEditable("warmer.settings")
  ->set("warmers.cdn.urls", ["https://example.com/", "/about"])
  ->set("warmers.cdn.verify", TRUE)
  ->set("warmers.cdn.maxConcurrentRequests", 10)->save();'
```

Then warm: `drush warmer:enqueue cdn` or `drush warmer:enqueue sitemap`
(add `--run-queue` to populate immediately).
