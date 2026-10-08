# Plugins consumed — Varnish Purger

This module does **not define** its own plugin type; it **provides plugin instances** for
Purge's plugin types (`@PurgePurger`, `@PurgeDiagnosticCheck`, and — in the
`varnish_purge_tags` submodule — `@PurgeTagsHeader`).

## Purger plugins (`@PurgePurger`)

| id | Label | multi_instance | types | config form |
|---|---|---|---|---|
| `varnish` | Varnish Purger | yes | *(chosen per instance via `invalidationtype`)* | yes |
| `varnishbundled` | Varnish Bundled Purger | yes | *(chosen per instance)* | yes |
| `varnish_zeroconfig_purger` | Varnish zero-configuration purger | no | `url, wildcardurl, tag, everything` | no |

- **`varnish`** (`VarnishPurger`) — fires **one async HTTP request per invalidation**, Guzzle
  `Pool` concurrency 10. Best for tag purging where each tag maps to one request. Extends
  `VarnishPurgerBase`; `getTypes()` returns `[invalidationtype]`, so the instance clears the
  single type selected in its settings.
- **`varnishbundled`** (`VarnishBundledPurger`) — builds **a single HTTP request for the whole
  batch** of invalidations. Use when Varnish can accept many tags/URLs in one request to cut
  request count. Also configurable, also single-type per instance.
- **`varnish_zeroconfig_purger`** (`ZeroConfigPurger`) — inspired by Acquia Cloud's purger.
  No config form: reads load-balancer IPs from `$settings['reverse_proxy_addresses']`, sends
  concurrent BAN/PURGE requests (concurrency 6), groups cache tags 15 per request, and works
  with the shipped `zeroconfig.vcl`. Handles `url`, `wildcardurl`, `tag`, `everything` all at
  once.

The two configurable purgers share `VarnishPurgerBase`: it loads the `VarnishPurgerSettings`
entity, builds the URI as `scheme://hostname:port/path` (path token-replaced), and builds
Guzzle options from the timeout/http_errors/verify/headers settings. `getCooldownTime()`,
`getIdealConditionsLimit()` (= max_requests) and `getTimeHint()` come from settings too.

## Diagnostic check (`@PurgeDiagnosticCheck`)

- **`varnishconfiguration`** (`ConfigurationCheck`, title "Varnish") — depends on purger
  plugins `{"varnish"}`. Loops enabled `varnish`/`varnishbundled` instances and:
  - returns **ERROR** ("… not configured") if any of `name`, `hostname`, `port`,
    `request_method`, `scheme` is empty;
  - returns **WARNING** if `scheme` is `https` but `port` ≠ 443, or `scheme` is `http` but
    `port` == 443;
  - otherwise **OK** ("All purgers configured").

## Adding your own purger config

You don't implement a new plugin class to run Varnish purgers — you **add instances** of the
above plugins through Purge (`drush p:purger-add <id>` or the Purge UI) and configure each
one. See [../configure/setup.md](../configure/setup.md).
