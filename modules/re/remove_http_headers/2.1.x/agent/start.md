# remove_http_headers — agent start

Strips a configured list of HTTP response headers (default `X-Generator`,
`X-Drupal-Dynamic-Cache`, `X-Drupal-Cache`) from every main-request response via an HTTP
stack middleware, for security/privacy. No dependencies beyond core. Config UI:
**Admin → Config → System → Remove HTTP headers settings**
(`/admin/config/system/remove-http-headers`); configure route
`remove_http_headers.remove_http_headers_settings`.

- Configure the header list, config object, middleware, drush → [configure/remove_http_headers.md](configure/remove_http_headers.md)
- Permission gating the settings form → [permissions/remove_http_headers.md](permissions/remove_http_headers.md)
