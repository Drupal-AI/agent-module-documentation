<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSNLog forwards JavaScript log messages and errors from the browser to Drupal's logging system.

---

Front-end errors are invisible from the server. A JavaScript exception that breaks a checkout on one browser version produces no server log line, no watchdog entry and no alert — the only signal is a user who gives up. Shipping client-side errors back to the server is the standard answer, and JSNLog is the Drupal binding for it.

**This release cannot be enabled on a standard Drupal 11 site, and it was verified.** `AjaxLogAccess::__construct()` type-hints eight **concrete classes**, and one of them is decorated by core:

```php
public function __construct(AccountProxy $account, ConfigFactory $config, RequestStack $request_stack,
    AliasManager $path_manager, PathMatcher $path_matcher, CurrentPathStack $path_current,
    CurrentRouteMatch $route_current_matcher, ModuleHandler $module_handler) {
```

Core's `path_alias` module declares `decorates: path.matcher`, so `@path.matcher` resolves to `Drupal\path_alias\AliasPathMatcher` — which implements `PathMatcherInterface` but does not extend `Drupal\Core\Path\PathMatcher`. The service is an access check, so it is built during container compilation:

```
TypeError: Drupal\jsnlog\Access\AjaxLogAccess::__construct(): Argument #5 ($path_matcher)
must be of type Drupal\Core\Path\PathMatcher, Drupal\path_alias\AliasPathMatcher given
```

That takes the container down — site and Drush both — and because `path_alias` is core and enabled on essentially every site, the failure is universal rather than conditional.

**This is the third instance of the same defect class in three waves**, after `complete_webform_exporter` (wave 85) and the same pattern elsewhere: a constructor type-hinting an implementation where Drupal's container is designed to allow substitution. Here the substitution comes from core itself, which makes it the clearest case — the rule "type-hint the interface" is not a style preference, it is what makes a service swappable at all.

Worth noting about the design too, if the type hints are fixed: `/jsnlog/log` accepts messages from the browser under `access content` plus a custom access check, which means an anonymous caller can write into the site's log at request rate. Whatever rate limiting and message sanitisation that access check performs is the thing to review before enabling it on a public site.

---

- Capture JavaScript errors server-side.
- See front-end exceptions in watchdog.
- Diagnose a browser-specific failure.
- Alert on a client-side error rate.
- Log messages from a JavaScript application.
- Correlate client errors with server logs.
- Fix the concrete type hints before enabling.
- Diagnose a container TypeError on path.matcher.
- Understand why core's path_alias decorates path.matcher.
- Recognise the type-hint-the-interface rule.
- Review rate limiting on the log endpoint.
- Consider log flooding from anonymous callers.
- Sanitise client-supplied log messages.
- Recover a site broken by enabling it.
- Report the type hints upstream.
- Choose an alternative front-end error tracker.
