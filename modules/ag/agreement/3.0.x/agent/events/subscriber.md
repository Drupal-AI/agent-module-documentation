# Enforcement subscriber

Service `agreement_subscriber` → `Drupal\agreement\EventSubscriber\AgreementSubscriber`. This is
what forces the redirect to the agreement page. Deps: `agreement.handler`, `path.current`,
`session_manager`, `current_user`, `redirect.destination`.

## Subscribed events

| Event | Method | Priority |
|---|---|---|
| `KernelEvents::REQUEST` | `requestForRedirection` | 28 (runs just above dynamic page cache's 27) |
| `KernelEvents::EXCEPTION` | `exceptionRedirect` | 1 |

`exceptionRedirect()` only re-checks on a `403` (`HttpExceptionInterface` status 403). This lets an
access-denied page still redirect to the agreement instead of looping — without it, a response set
by an access check before the request handler would cause an infinite redirect.

## Logic (`checkForRedirection`)

1. If the user has `bypass agreement`, do nothing.
2. Ask `agreement.handler->getAgreementByUserAndPath(current_user, current_path)`. If it returns an
   agreement:
   - Read `redirect.destination`, strip the site base path, and store it in
     `$_SESSION['agreement_destination_<id>']` (re-saved every check, so a changed target URL is
     respected).
   - Redirect to the agreement's own route `agreement.<id>` via a
     `Drupal\Core\Routing\LocalRedirectResponse` built from `Url::fromRoute()` (no user input in
     the redirect target).

## Destination / redirect safety

The post-acceptance redirect (in `AgreementForm::processAgreement()`) chooses, in order:
`settings.destination` (admin-configured) → `$_SESSION['agreement_destination_<id>']` → `<front>`.
It builds the URL with `Url::fromRoute('<front>')` or `Url::fromUserInput($destination)` and wraps
it in a `LocalRedirectResponse`, which rejects any non-local (external) target. `fromUserInput`
also requires a leading `/`, `#` or `?`. So the stored destination cannot drive an off-site
redirect. Query parameters on the originating URL are preserved through to the final redirect
(see `AgreementRedirectWithQueryTest`).

Because the subscriber runs on every request for targeted users, it can interact with other
redirecting modules and with test harnesses; the module installs at weight `9999` so it is late in
the order.
