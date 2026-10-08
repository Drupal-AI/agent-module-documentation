# Configuration

Setting up Domain Libraries Attach is two steps: first define the asset library in
your theme, then assign it to the domains that should load it.

## Step 1 — Define a library in your theme

The libraries this module can attach come from your **active (default) theme**.
Define one the standard Drupal way, as an entry in your theme's
`THEME.libraries.yml` file, for example:

```yaml
brand_a_styles:
  css:
    theme:
      css/brand-a.css: {}
  js:
    js/brand-a.js: {}
```

Clear caches after editing the file so Drupal picks up the new library. (See
Drupal's own "Adding assets (CSS, JS) to a Drupal theme via *.libraries.yml"
documentation for the full syntax.)

## Step 2 — Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Domain → Domain libraries settings**, or navigate
   directly to `/admin/config/domain/domain_libraries_attach`. It appears as a tab
   within the Domain records area.

## Step 3 — Assign libraries to domains

The form lists your domains and lets you choose which of the theme's libraries each
domain should load:

- **Domain** — each of your configured domains is listed, so assignments are scoped
  per domain.
- **Library** — pick the library (or libraries) from the active theme that should
  be attached on that domain. A domain with no assignment simply loads nothing
  extra.

Assign the libraries you want per domain and click **Save**.

## Verify

Load a page on a domain you assigned a library to, and view the page source (or use
your browser's developer tools) to confirm the domain-specific CSS/JS is present.
Load a different domain to confirm it loads only its own assigned libraries.
