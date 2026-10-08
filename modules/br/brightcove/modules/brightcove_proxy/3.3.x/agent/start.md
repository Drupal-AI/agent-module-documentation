# Brightcove Proxy — agent index

Submodule of `brightcove`. Routes Brightcove API traffic through an HTTP/SOCKS proxy. Settings at
`/admin/config/system/brightcove-proxy` (route `brightcove_proxy.config_form`, permission
`administer brightcove configuration`). Provides config schema; no permissions/Drush/plugin types.

- **All proxy settings keys and the connectivity test** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `brightcove_proxy.config`: `use_proxy`, `proxy`, `proxy_port`, `proxy_username`, `proxy_password`, `proxy_auth` (CURLAUTH_* int), `proxy_type` (CURLPROXY_* int), `http_proxy_tunnel`.
- `BrightcoveProxyInitSubscriber` applies these to the Brightcove SDK's cURL client.
- Route `brightcove_proxy.test` (`/brightcove-proxy/test`, `_access: TRUE`) is a trivial reachability page used only by the form's save-time proxy validation.
