<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime request filter & client script

Two runtime surfaces, both gated on `key_site` being set and both applying the same role-exclusion
logic (skip when `roles_exclude` is on and the current user has any role in `roles`).

## Stack middleware (server side)

Source: `src/StackMiddleware/CloudfiltStackMiddleware.php`; service `cloudfilt.stack_middleware`
(`http_middleware`, `priority: 280`, `responder: true`), args `@http_client`, `@config.factory`.

`handle()` first delegates to the wrapped kernel to build `$response`, then — if configured and the
user is not role-excluded — calls `filterRequest()`:

1. Client IP via `$request->getClientIp()` (honours Symfony trusted-proxy settings; **not** a raw
   header read).
2. Request URI via `$request->getUri()`.
3. Reads the raw body from `php://input`; if `CONTENT_TYPE` is `application/json` it `json_decode`s
   it, else for POST it `parse_str`s it into `$text20_CF`.
4. **Body scrubbing:** if any key is in `['log','pwd','password','pass']` the whole body payload is
   discarded; otherwise keys starting with `form`/`check`/`op`/`confirm` are unset (drops Drupal
   form internals + credential fields before sending).
5. POSTs to `https://api{key_site}.cloudfilt.com/phpcurl` with `form_params`
   `ip`, `KEY` (= `key_back`), `URL`, `TEXTCF`, `timeout: 1`.
6. If the response body is non-empty and `!= 'OK'`, replaces `$response` with a **307 redirect** to
   `https://cloudfilt.com/stop-{ip}-{key_front}` (no-cache headers). Empty body or `'OK'` → request
   proceeds.

Operational caveats:
- The Guzzle call in `filterRequest()` has **no try/catch**. A timeout/connection error or non-2xx
  from CloudFilt throws out of the middleware, surfacing as a 500 for that request — i.e. a CloudFilt
  outage degrades every request. Confirm the fail behaviour you want before production.
- Runs on **every** request (priority 280), adding one outbound round trip per request.

## Client script (browser side)

Source: `cloudfilt.module` `hook_page_attachments` → `_cloudfilt_attach_script`. Injects into
`html_head`, `async`:

```
https://srv{key_site}.cloudfilt.com/analyz.js?render={key_front}
```

Only `key_site` and the **public** `key_front` reach the browser; the private key is never emitted
client-side.

## Requirements hook

`hook_requirements` (runtime): `REQUIREMENT_OK` "Your website is protected" when `key_site` is set,
else `REQUIREMENT_WARNING` linking to the config form.
