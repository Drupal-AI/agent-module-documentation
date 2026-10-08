<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Domain Access Simple Sitemap

- **Settings form:** `/admin/config/domain/domain_simple_sitemap/config`
  (route `domain_simple_sitemap.settings`, form `DomainSimpleSitemapConfigForm`).
- **Permission:** `administer domains` (from Domain Access; the module defines none of its own).
- **Config object:** `domain_simple_sitemap.settings`.

## Keys

| Key | Type | Default | Effect |
|---|---|---|---|
| `domain_simple_sitemap_filter` | boolean | `0` | When TRUE, the domain sitemap is filtered by node **source** (Domain Source field) instead of node **access**. |
| `domain_simple_sitemap_replace_homepage` | boolean | `0` | When TRUE, a link matching the domain's configured front page is rewritten to the domain's clean base URL in the generated sitemap. Requires `domain_config` **or** `domain_site_settings` — otherwise the checkbox is disabled. |

```bash
drush cget domain_simple_sitemap.settings
drush cset domain_simple_sitemap.settings domain_simple_sitemap_filter 1 -y
```

## The "Generate domain's sitemap variants" button

The form also has a submit button **"Generate domain's sitemap variants"**
(`::generateDomainSitemapVariants`) that runs a Batch to call
`DomainSitemapManager::addSitemapVariant()` for every **active** domain — use this to create
variants for domains that already existed before the module was installed. A link
"You can check existing sitemap variants of domains" points at the Simple Sitemap collection
(`entity.simple_sitemap.collection`).

## Typical end-to-end setup

1. Enable indexing for each content type against the domain's variant in *Simple XML Sitemap*
   settings (per-bundle "Index entities of type … in variant …").
2. Rebuild via Simple Sitemap's **Rebuild queue & generate**.
3. The sitemap is served at `<domain>/sitemap.xml`.

See [../api/manager-and-hooks.md](../api/manager-and-hooks.md) for what a variant actually is
and how it is created/removed automatically.
