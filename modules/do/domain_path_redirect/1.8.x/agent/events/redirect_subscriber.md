# Redirect resolution (event subscriber)

Service `domain_path_redirect.request_subscriber` →
`Drupal\domain_path_redirect\EventSubscriber\DomainPathRedirectRequestSubscriber`
(tagged `event_subscriber`). It is what actually performs the redirect for a matching request.

## Subscribed events (`getSubscribedEvents()`)

Both listeners run on `KernelEvents::REQUEST`, chosen so they fire **before**
`RouterListener::onKernelRequest()` (priority 32), which would otherwise abort the request when the
source path has no route:

| Priority | Method | Purpose |
|---|---|---|
| 33 | `onKernelRequestCheckDomainPathRedirect` | Find a matching redirect for the current path+domain and issue it. |
| 31 | `onKernelRequestCheckActiveDomain` | If on the `domain_path_redirect.add` route with no active domain, bounce to the list with an error. |

## `onKernelRequestCheckDomainPathRedirect` flow

1. Clones the request (inbound processing can mutate the original; the clone avoids side effects).
2. Bails unless `redirect.checker` `RedirectChecker::canRedirect($request)` is TRUE (this honours the
   Redirect module's rules — e.g. only GET, not admin routes, respects `route_normalizer`, etc.).
3. Runs `path_processor_manager::processInbound()` on the path (strips language prefix etc.), then
   `trim('/')`.
4. Gets the active domain via `domain.negotiator::getActiveDomain(TRUE)`; returns if none.
5. Calls `DomainPathRedirectRepository::findMatchingRedirect($path, $domain->id(), $request_query, $currentLangId)`
   (see [api/repository.md](../api/repository.md)). A `RedirectLoopException` is caught and turned into
   a **503 "Service unavailable"** response (and logged to the `redirect` channel).
6. If a redirect entity is found:
   - Destination URL comes from `$redirect->getRedirectUrl()` (the stored `redirect_redirect` value).
   - If `redirect.settings:passthrough_querystring` is on, the **incoming** query is merged onto the
     destination's query.
   - Emits a `TrustedRedirectResponse` to `$url->setAbsolute()->toString()` with the redirect's own
     `getStatusCode()` and a header `X-Redirect-ID: <rid>`. The response declares the redirect entity
     as a cacheable dependency.

The destination is always the admin-configured value stored on the matched entity; the incoming
request selects **which** stored redirect matches (by source path + active domain + language + query
hash), it does not supply the destination. `TrustedRedirectResponse` is used because Redirect
destinations may legitimately be external, exactly as the upstream Redirect module does.

## `onKernelRequestCheckActiveDomain` flow

If the current route is `domain_path_redirect.add` and `domain.negotiator::getActiveDomain(TRUE)`
returns nothing, it sets an error message ("There is no active domain…") and returns a
`TrustedRedirectResponse` (301) to `domain_path_redirect.list` — you cannot create a redirect with no
domain to attach it to.

## Notes for integrators

- To suppress redirects for certain requests, use the Redirect module's mechanisms (its
  `redirect.settings` and `RedirectChecker`), since this subscriber defers to `redirect.checker`.
- The `X-Redirect-ID` response header is a convenient way to confirm which record fired during
  debugging.
