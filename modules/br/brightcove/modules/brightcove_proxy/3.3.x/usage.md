Brightcove Proxy lets a site route all Brightcove API traffic through an HTTP or SOCKS proxy, for environments where outbound connections to Brightcove must go through a corporate/egress proxy.

---

The submodule adds a settings form at `/admin/config/system/brightcove-proxy`
(route `brightcove_proxy.config_form`, permission `administer brightcove configuration`) that stores
proxy parameters in config object `brightcove_proxy.config`: `use_proxy` toggle, `proxy` host,
`proxy_port`, `proxy_username`/`proxy_password`, `proxy_auth` (a cURL `CURLAUTH_*` constant —
Any/Any-safe/Basic/Digest/GSS/NTLM), `proxy_type` (`CURLPROXY_HTTP`/`SOCKS4`/`SOCKS5`), and
`http_proxy_tunnel`. On save (when `use_proxy` is on) the form validates connectivity by curling the
site's own `brightcove-proxy/test` route through the configured proxy and erroring if it doesn't
return HTTP 200. An event subscriber (`BrightcoveProxyInitSubscriber`) applies these proxy options to
the Brightcove API client's cURL calls. The module depends on the main `brightcove` module.

---

- Route Brightcove API calls through a corporate HTTP proxy.
- Route Brightcove API calls through a SOCKS4/SOCKS5 proxy.
- Authenticate to the proxy with a username and password.
- Choose the proxy authentication scheme (Basic, Digest, NTLM, GSS, Any).
- Enable HTTP tunnelling through the proxy.
- Validate proxy connectivity from the settings form before saving.
- Operate Brightcove from a network with no direct outbound internet access.
- Disable proxying quickly with the `use_proxy` toggle.
- Set a non-standard proxy port.
- Keep proxy settings in exportable Drupal configuration.
- Use NTLM authentication for a Windows/enterprise proxy.
- Use SOCKS5 for a proxy that must resolve DNS remotely.
- Apply the proxy transparently to all CMS, Dynamic Ingest, and Player Management API calls.
- Override proxy credentials per environment via `settings.php` config overrides.
- Diagnose a failing egress path by watching the save-time proxy test result.
- Restrict proxy administration to holders of `administer brightcove configuration`.
