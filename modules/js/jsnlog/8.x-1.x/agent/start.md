<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSNLog (jsnlog) — agent index

Forwards browser JavaScript log messages into Drupal's logging system.
Configure at `/admin/config/development/jsnlog`. Version **8.x-1.4**. Core `^9 || ^10 || ^11`.
Endpoint `/jsnlog/log` — `_permission: 'access content'` + `_jsnlog_ajax_log_access`.

**Documented from source — cannot be enabled on a standard Drupal 11 site. Verified:**

`AjaxLogAccess::__construct()` type-hints eight **concrete classes**, including
`Drupal\Core\Path\PathMatcher`. Core's `path_alias` declares `decorates: path.matcher`, so the
service is `Drupal\path_alias\AliasPathMatcher` — implements the interface, does not extend the
class:

```
TypeError: …AjaxLogAccess::__construct(): Argument #5 ($path_matcher) must be of type
Drupal\Core\Path\PathMatcher, Drupal\path_alias\AliasPathMatcher given
```

It is an access check, so it is built at container compile time — site and Drush both down. Since
`path_alias` is core, **the failure is universal, not conditional**.

**Third instance of this defect class in three waves** (see `complete_webform_exporter`, wave 85).
Type-hint the **interface** — that is what makes a service swappable at all, not a style
preference.

If the hints are fixed: `/jsnlog/log` lets an anonymous caller write to the site log at request
rate. Review what the custom access check does about rate limiting and message sanitisation.