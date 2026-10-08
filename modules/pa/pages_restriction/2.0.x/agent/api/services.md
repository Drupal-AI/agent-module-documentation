<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subscriber & session-bypass service

## The request subscriber

`Drupal\pages_restriction\Event\PagesRestrictionSubscriber` subscribes to
`KernelEvents::REQUEST` (`onRequestCheckRestrictedPages`, priority 215; service tag priority
210). On every request it:

1. Loads `pages_restriction.settings`.
2. If the user is **logged in** and has any role listed in `bypass_role` → returns (no
   restriction).
3. Reads `pages_restriction`; if empty → returns.
4. Resolves the current path to its **alias** (lower-cased, url-decoded).
5. If the session array `pages_restriction_bypass` contains that path → returns (one-time
   allow already granted).
6. If the current alias matches a restricted path, builds the target (appending query params
   when `keep_parameters` is set), sends a `RedirectResponse`, calls
   `$event->stopPropagation()` and `exit`s.

Because it runs at the REQUEST stage it can redirect before the normal controller renders.

## Session-bypass service

Service id `pages_restriction.session_service`
(`Drupal\pages_restriction\Service\PagesRestrictionSessionService`).

```php
\Drupal::service('pages_restriction.session_service')->setBypass('/contact/thank-you');
```

`setBypass($path)` pushes `$path` onto the session array `pages_restriction_bypass` and returns
the updated array. This is how you let a user who legitimately completed the preceding step
view the restricted page once — typically called from the form/submit handler of the *target*
page. The subscriber (step 5 above) honors that entry on the next request.

## Helper

`pages_restriction.helper` (`PagesRestrictionHelper::getRestrictedPagesByConfig($lines)`) just
parses the configured lines into the list of restricted paths (the left-hand side of each
`restricted|target` mapping). It carries no state.

There is no Drush command and no plugin type; the module is the settings form + this subscriber
+ these two small services.
