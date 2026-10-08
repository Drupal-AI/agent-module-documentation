<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request attributes on the status report

The whole module is `request_info_requirements($phase)` in `request_info.install`. It implements
`hook_requirements()` and runs only when `$phase == 'runtime'` (the status report,
`admin/reports/status`, not install-time checks). It builds an ordered `$info` array from the
current request obtained via `\Drupal::request()` (a Symfony `Request`), then converts each entry
into a `$requirements['request_info_status_<n>']` row with `'severity' => REQUIREMENT_INFO`.

## Attributes emitted (in order)

| Row title (`Request: %attribute`) | Source call |
| --- | --- |
| Client IP | `$request->getClientIp()` |
| Base URL | `Url::fromUri('base:/')->setAbsolute()->toString()` |
| Trusted proxy | `$request->isFromTrustedProxy()` → `yes`/`no` |
| Secure | `$request->isSecure()` → `yes`/`no` |
| Scheme | `$request->getScheme()` |
| HTTP Headers | `(string) $request->headers`, sanitised then wrapped (see below) |
| HTTP Host | `$request->getHttpHost()` |
| HTTP Port | `$request->getPort()` |
| HTTP Auth | `$request->getUser() ? getUser() . ':****' : 'None'` |
| HTTP Protocol | `$request->getProtocolVersion()` |
| Preferred language | `$request->getPreferredLanguage()` |

Each becomes a row titled `Request: <attribute>` with the value shown. A single description string
is attached to `request_info_status_1` (the *Base URL* row): "If Drupal's base URL is not correct,
check whether reverse proxy configuration is correct. Otherwise your server may be mis-configured."

## Headers handling

`$headers = (string) $request->headers;` renders every request header. Before display the hook:

1. Replaces `session_id()` with a fixed mask (`*************************`) so the session cookie
   value is not printed.
2. Escapes the whole blob with `Html::escape($headers)`, then wraps it as
   `Markup::create("<pre>" . … . "</pre>")` so it renders as preformatted, escaped text.

The `HTTP Auth` row masks the password portion, printing only `<user>:****`.

## Access

The module registers no route and no permission. These rows are visible wherever core renders the
status report — i.e. to users who can reach `admin/reports/status`, governed by core's
`administer site configuration` permission. There is no anonymous or lower-privilege path to this
data added by the module.

## Operating notes

- Purely diagnostic: enabling or disabling the module changes nothing but this status-report block.
- Values reflect the request that renders the status report page, as seen *after* any reverse
  proxy / trusted-proxy processing — which is the point: it shows what Drupal believes about the
  request, so a mismatch with the real client request points at proxy/header misconfiguration.
- `Trusted proxy` = `yes` means the request came from an address in `settings.php`'s
  `trusted_host_patterns`/reverse-proxy config; `Client IP` and `Secure`/`Scheme` are only reliable
  once that is set correctly.
