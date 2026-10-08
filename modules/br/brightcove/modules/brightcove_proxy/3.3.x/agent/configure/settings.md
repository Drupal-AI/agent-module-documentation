# Configure Brightcove Proxy

Form `BrightcoveProxyForm` at `/admin/config/system/brightcove-proxy`
(route `brightcove_proxy.config_form`, permission `administer brightcove configuration`). Writes
config object `brightcove_proxy.config`.

## Settings keys

| Key | Type | Meaning |
|---|---|---|
| `use_proxy` | bool | Master toggle; when off the other values are cleared on save. |
| `proxy` | string | Proxy host to tunnel requests through. |
| `proxy_port` | int (1–65535) | Proxy port. |
| `proxy_username` | string | Proxy auth username. |
| `proxy_password` | string | Proxy auth password. |
| `proxy_auth` | int | cURL `CURLAUTH_*` constant: Any, Any-safe, Basic, Digest, GSS-Negotiate, NTLM. |
| `proxy_type` | int | cURL `CURLPROXY_*` constant: HTTP, SOCKS4, SOCKS5. |
| `http_proxy_tunnel` | bool | Enable `CURLOPT_HTTPPROXYTUNNEL`. |

## Behavior

- **Save-time validation:** when `use_proxy` is on, `validateForm()` runs
  `curl_init("{HTTP_HOST}:{SERVER_PORT}/brightcove-proxy/test")` with the entered proxy options and
  sets a form error unless the response is HTTP 200 — a connectivity smoke test against the
  submodule's own `brightcove_proxy.test` route.
- **Runtime:** `BrightcoveProxyInitSubscriber` reads this config and applies the proxy options to
  the cURL transport used by the `brightcove/api` SDK, so all CMS/DI/PM API calls go through the
  proxy.
- Turning `use_proxy` off nulls out the proxy fields on save.
