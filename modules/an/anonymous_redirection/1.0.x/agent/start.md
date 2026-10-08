<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Anonymous Redirection (anonymous_redirection) — agent index

Zero-config "force site-wide login". A single kernel `REQUEST` event subscriber redirects **every**
anonymous request to a **fixed internal** `/user/login` (`302`), except the three auth routes it whitelists
to avoid a loop. Version **1.0.0**. Core `^10 || ^11`. Depends on core `user`.

## What it provides
- **Service / event subscriber**: `anonymous_redirection.event_subscriber` →
  `Drupal\anonymous_redirection\EventSubscriber\AnonymousRedirectionSubscriber`
  (`src/EventSubscriber/AnonymousRedirectionSubscriber.php`). Args: `@current_user`, `@request_stack`.
  Tagged `event_subscriber`; subscribes to `KernelEvents::REQUEST` with priority **28**.
- **No** routes (`anonymous_redirection.routing.yml` is empty), **no** config, **no** config schema,
  **no** permissions, **no** settings form, **no** Drush, **no** plugins, **no** submodules.

## Behavior (key facts)
- `onRequest()`: if `currentUser->isAnonymous()` and `_route` is not `user.login`, `user.register` or
  `user.pass`, it calls `$event->setResponse(new RedirectResponse('/user/login'))`.
- The redirect target is hardcoded — not admin-set, not request-derived. There is no path allow/deny list.
- Blanket gate: also intercepts the front page, REST/JSON:API, image derivatives and AJAX system routes
  for anonymous users. Suited to fully private sites, not sites with a public front end.

## Solution docs
- [agent/services/redirect-subscriber.md](services/redirect-subscriber.md) — the subscriber, whitelist,
  priority, install/enable, operational caveats and how to extend the whitelist.
