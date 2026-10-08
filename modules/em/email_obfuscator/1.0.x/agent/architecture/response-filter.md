<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Response filter + obfuscation mechanism

Two classes do all the work. Cited from `src/`.

## Wiring (`email_obfuscator.services.yml`)

- `email_obfuscator.service` → `Drupal\email_obfuscator\EmailObfuscatorService` (no args).
- `email_obfuscator.response_filter` → `EventSubscriber\EmailObfuscatorResponseFilter`, args
  `['@email_obfuscator.service', '@router.admin_context', '@logger.channel.email_obfuscator']`,
  tagged `event_subscriber`.
- `logger.channel.email_obfuscator` → `logger.channel_base` parent for the `email_obfuscator` channel.

## `EmailObfuscatorResponseFilter::onKernelResponse(ResponseEvent $event)`

Subscribes to `KernelEvents::RESPONSE` (see `getSubscribedEvents()`). On each response it reads
`_route_object`, `_route` and `$response->getContent()`; returns early if any is missing/empty.
It then computes:

- `$isAdminPath = $this->adminContext->isAdminRoute($routeObject)`.
- `$isRouteIgnored = in_array($route, Settings::get('email_obfuscator')['ignored_routes'] ?? [])`.
- `$isAjaxRequest = $request->isXmlHttpRequest()` and `$isWebForm` = request has a `form_id`
  param starting with `webform`.

If admin path, or ignored route, or (`$isAjaxRequest && $isWebForm`), it returns without changing
the response. Otherwise it reads `$useDataNoSnippet = Settings::get('email_obfuscator')['use_datanosnippet'] ?? TRUE`,
calls `$this->emailObfuscator->obfuscateEmails($content, $useDataNoSnippet)`, and writes the result
back with `$response->setContent(...)` / `$event->setResponse(...)`. An `EmailObfuscatorException`
is caught and logged via `$this->logger->error()` (the response is then left as-is).

Note: the filter operates on the raw response string; it does not branch on Content-Type, so any
non-admin route with a non-empty body is a candidate.

## `EmailObfuscatorService`

Public: `obfuscateEmails(string $content, bool $useDataNoSnippet = TRUE): string` — runs
`obfuscateMailtoLinks()` then `obfuscateEmailStrings()` with the fixed hidden text `"zilch"`.

### `obfuscateMailtoLinks()` (private)

Regex `'/(href=)"mailto:([^"]+)"/'` via `preg_replace_callback`. Each match:
- If `filter_var($matches[2], FILTER_VALIDATE_EMAIL)` fails → return the match unchanged.
- Else rebuild the attribute with the address **reversed** (`strrev($matches[2])`) and add two
  inline handlers, `onfocus` and `onmousedown`, both running the same JS that, once per element
  (`this.dataset.obfuscated` guard), reverses `href.substring(7)` back to the real `mailto:` value.
  Two events cover click, right-click and tab-focus (Safari needs `onmousedown`).
- `preg_replace_callback` returning `null` throws `EmailObfuscatorException`.

### `obfuscateEmailStrings()` (private)

Regex `'/(<[^>]+)|(([\w\-\.]+@)([\w\-\.]+\.[a-zA-Z]{2,}))/'`. The first alternative matches the
start of an HTML tag so addresses inside tags/attributes are captured into `$matches[1]` and
skipped. For a bare email (empty `$matches[1]`) that passes `FILTER_VALIDATE_EMAIL`, it splits the
address at the `@`+domain boundary and inserts
`<span style='display:none' {data-nosnippet}>!zilch!</span>` between the local part and domain
(`$matches[3]` + span + `$matches[4]`). `data-nosnippet` is included only when `$useDataNoSnippet`
is TRUE. Invalid addresses and in-tag matches are returned unchanged; a `null` return throws
`\Exception`.

Concrete outputs (from `tests/src/Unit/EmailObfuscatorTest.php`):
- `test@email.com` → `test@<span style='display:none' data-nosnippet>!zilch!</span>email.com`.
- `<a href="mailto:test@email.com">` → href becomes `mailto:moc.liame@tset` plus the two inline
  handlers.
- `<input placeholder="test@email.com">` and `<a href="test@email.com">` (no `mailto:`) → unchanged.

## Enable

`drush en email_obfuscator -y` (or via the modules UI). No further setup is required; see
[../config/settings.md](../config/settings.md) for the optional tuning keys.
