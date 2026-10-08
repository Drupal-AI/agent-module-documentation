# Configure domain redirects

## UI

Route `redirect_domain.domain_list` → **Domain redirects** form at
`/admin/config/search/redirect/domain` (permission `administer redirects`,
form `RedirectDomainForm`). Add a source domain and its destination; add sub-path rows to send
different paths of that domain to different destinations.

## Config — `redirect_domain.domains`

Single config object (schema `redirect_domain.schema.yml`). Shape:

```yaml
domain_redirects:
  old-example-com:            # source domain key
    -
      sub_path: '/'
      destination: 'https://www.example.com'
    -
      sub_path: '/shop'
      destination: 'https://shop.example.com'
```

`domain_redirects` is a map of domain → list of `{ sub_path, destination }`. Exportable with
`drush config:export`.

## Runtime

`DomainRedirectRequestSubscriber` (`redirect_domain.request_subscriber`) reads the incoming
host, matches it (and sub-path via `path.matcher`) against the config, checks
`redirect.checker`, and issues the redirect before the page renders. Use the parent Redirect
module for individual per-URL redirects; use this for whole hostnames.
