# Configuration

Country Path has no dedicated settings form. You configure it in two (optionally
three) places: on each **Domain record**, on the **Domain alias** form if you use
aliases, and in the core **language detection** UI.

## 1. Give a domain a country prefix

Go to **Configuration → Domains** (`/admin/config/domain`) and add or edit a
domain record. Country Path alters the **Canonical hostname** field so you can
append the country prefix directly to the host:

```
example.com/usa
```

When you save, the module splits off the trailing segment: the hostname stays
`example.com`, and `usa` is stored as the domain's country path (the
`country_path.domain_path` third‑party setting). To remove a country restriction
later, simply clear the prefix back to `example.com` and save.

Because Country Path relaxes Domain's usual "hostname must be unique" rule,
several domain records can share the same hostname `example.com` and differ only
by their country path — that's exactly what lets `example.com/usa` and
`example.com/fra` coexist.

Prefer the command line? Set the prefix directly:

```bash
drush php:eval '$d = \Drupal::entityTypeManager()->getStorage("domain")->load("example_com"); $d->setThirdPartySetting("country_path", "domain_path", "usa"); $d->save();'
```

Once set, requests to `example.com/usa/...` resolve to that domain, the `/usa`
prefix is stripped before routing, and it's automatically re‑added to links
generated while the domain is active. When no known prefix is present, the default
domain is used.

## 2. Domain aliases (optional)

If you have the **Domain Alias** submodule enabled, the alias form's pattern
description is adjusted so you can enter patterns like `example.com/usa`. On each
request the module tries to match `hostname/prefix` first, then the bare
`hostname`, so an alias can either capture a country prefix or forward an old
country URL to the canonical one via an alias redirect.

## 3. Language negotiation (with the Language module)

When core's **Language** module is present, Country Path automatically adds its
**`country-path-language-url`** negotiator to the URL language detectors on
install (or when Language is enabled later), placing it ahead of core's own URL
negotiator. You can reorder or disable it at **Configuration → Regional and
language → Detection and selection**
(`/admin/config/regional/language/detection`).

The negotiator is a specialized version of core's URL negotiator. Using the
standard URL‑detection **source** setting, it can resolve language from either:

- the **path prefix** — it looks at the first *and* second path segments, so a
  language prefix can sit right after the country prefix
  (`example.com/usa/fr/...`); or
- the **domain** — matching the request host to a per‑language domain, if you've
  configured language‑by‑domain.

## What you don't configure

There is no global admin page, no permissions, and no Drush commands specific to
this module. Everything is driven off the per‑domain country path plus the core
language settings above. The `url.country` cache context is managed for you so
page caches stay correct per country.
