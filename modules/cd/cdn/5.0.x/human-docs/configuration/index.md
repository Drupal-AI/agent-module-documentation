# Configuration

All of CDN's behaviour is driven by one config object, **`cdn.settings`**. You edit
it either through the **CDN UI** submodule's form at **Configuration → Development →
CDN** (`/admin/config/development/cdn`) or directly as config (for config-as-code
deployments). This page describes the settings regardless of how you edit them.

## Top-level settings

| Setting | Default | What it does |
|---|---|---|
| **Status** | off | The master switch. Turn it **on** to start rewriting file URLs to the CDN. Turn it off to roll back instantly. |
| **Mapping** | simple, everything except CSS/JS | The rule that maps files to CDN domain(s) — see below. |
| **Scheme** | `//` | The URL scheme: `//` (scheme-relative, works over both HTTP and HTTPS), `https://`, or `http://`. |
| **Far Future** | on | Enable forever-cacheable file serving via the `/cdn/ff/…` route (see below). |
| **Stream wrappers** | `public` | Which local stream-wrapper schemes are eligible for rewriting. |

## Mapping types

The mapping decides which files go to which CDN domain. There are three types.

### Simple — one domain

Serve files from a single domain, optionally limited by file extension:

```yaml
mapping:
  type: simple
  domain: cdn-a.example.com
  conditions: {}                                   # all files
  # or:  conditions: {extensions: [jpg, jpeg, png]}   # only these extensions
  # or:  conditions: {not: {extensions: [css, js]}}   # everything except these
```

The shipped default is a simple mapping with `not: {extensions: [css, js]}` — that
is, serve everything from the CDN except CSS and JS.

### Complex — a fallback plus per-extension domains

Route different extensions to different domains, with a fallback for everything else:

```yaml
mapping:
  type: complex
  fallback_domain: cdn-c.example.com   # or null for "serve nothing else from a CDN"
  domains:
    - {type: simple, domain: cdn-a.example.com, conditions: {extensions: [css, jpg, jpeg, png]}}
    - {type: simple, domain: cdn-b.example.com, conditions: {extensions: [zip]}}
```

### Auto-balanced — spread across several domains

Distribute matching files across several domains using consistent hashing, so a given
file always maps to the same domain (this needs an `extensions` condition):

```yaml
mapping:
  type: auto-balanced
  domains: [cdn-b.example.com, cdn-c.example.com]
  conditions: {extensions: [jpg, jpeg, png]}
```

Domains are validated as bare hosts (no scheme), and the scheme is validated against
the three allowed values.

## Far Future serving

When **Far Future** is on, files can be served through the route
`/cdn/ff/{security_token}/{mtime}/{scheme}` with 480-week cache headers and a
security token, making them effectively cacheable forever. The URL includes a token
derived from your site's private key, so it can't be forged.

On large sites, serving these through PHP is wasteful — replicate the behaviour in
Apache with the `.htaccess` rewrite rules documented in the module's `README`, so the
web server handles far-future files directly.

## What is never served from the CDN

By design, the module does **not** rewrite:

- HTML pages or REST responses (important for SEO correctness),
- private files,
- files whose stream wrapper is not in the eligible **Stream wrappers** list.

It also adds `<link rel="dns-prefetch">` hints for your CDN domains and prevents
duplicate-content issues when the site sits behind a reverse proxy.

## Changing settings with Drush

```bash
drush config:set cdn.settings status true -y
drush config:set cdn.settings mapping.type simple -y
drush config:set cdn.settings mapping.domain cdn-a.example.com -y
drush config:set cdn.settings scheme 'https://' -y
drush config:get cdn.settings mapping
```
