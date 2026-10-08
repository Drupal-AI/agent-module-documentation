<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Access Filter filters

A filter is a `Drupal\access_filter\Entity\Filter` config entity (config prefix `filter`, i.e.
`access_filter.filter.<id>`). Manage them at `/admin/config/people/access_filter`
(permission `manage access filters`). Each filter stores three YAML strings — `conditions`,
`rules`, `response` — plus `status` (enabled) and `weight` (evaluation order, ascending).

## Evaluation order (exact)
1. Middleware runs on every request unless `$settings['access_filter_disabled']` is TRUE.
2. Filters are sorted by `weight` ascending; each **enabled** filter is evaluated; the first that
   denies returns immediately.
3. Per filter — **conditions (OR):** the filter applies if any condition matches
   (`isMatched()` XOR `negate`). No condition matches (or none defined) ⇒ filter does not apply ⇒
   allowed.
4. Per filter — **rules (default allow):** every `ip` rule runs in order; `allow` sets allow,
   `deny` sets forbid, non-matching IP is neutral (no change); the **last non-neutral result wins**.
5. On denial: `response.code` default 403; 301/302 ⇒ redirect to `response.redirect_url`; else a
   response with `response.body` and the code.

## Conditions
Each condition is a YAML list item with a `type`. Add `negate: 1` to invert any condition.

```yaml
# Drupal path (uses path.matcher; supports '*' wildcards in non-regex mode)
- { type: path, path: /foo/bar }
- { type: path, path: '/\/foo\/(bar|baz)/i', regex: 1 }

# Full request URI including query string (exact match, or regex)
- { type: uri, uri: '/foo/bar?param=1' }
- { type: uri, uri: '/\/foo\/bar\?param=[0-9]{2}/i', regex: 1 }

# Cookie value ($_COOKIE)
- { type: cookie, key: foo, value: bar }

# Session value ($_SESSION)
- { type: session, key: foo, value: bar }

# $_SERVER value (headers appear as HTTP_*)
- { type: env, key: HTTP_REFERER, value: 'https://example.com/' }

# Chaining (conditions is a nested list of conditions)
- { type: and, conditions: [{ type: path, path: /a }, { type: cookie, key: k, value: v }] }
- { type: or,  conditions: [{ type: path, path: /a }, { type: path, path: /b }] }
```

Notes:
- Conditions at the top level are **OR-combined** — use an explicit `and` group when you need
  *all* of several conditions to hold.
- `path` matches the Drupal path (`Request::getPathInfo()`); `uri` additionally appends the query
  string. Use `uri` when a query parameter is part of what you are matching.
- `env` reads `$_SERVER`; request headers are exposed as `HTTP_*` keys (e.g. `HTTP_USER_AGENT`).

## Rules
Only the `ip` rule ships. `action` is required and must be `allow` or `deny`; `address` is required.

```yaml
- { type: ip, action: deny,  address: '*' }                       # everyone
- { type: ip, action: deny,  address: 192.168.1.100 }             # single IP
- { type: ip, action: deny,  address: 192.168.1.0/24 }            # CIDR subnet
- { type: ip, action: allow, address: 192.168.1.10-192.168.1.20 } # inclusive range
```

Because the **last matching rule wins** and the default is allow, an allowlist is written as a
broad `deny` followed by the narrower `allow`:

```yaml
# Only 203.0.113.5 may reach requests this filter's conditions match:
- { type: ip, action: deny,  address: '*' }
- { type: ip, action: allow, address: 203.0.113.5 }
```

The client IP is taken from Symfony's `Request::getClientIp()`. Behind a reverse proxy / CDN /
load balancer, configure Drupal's `reverse_proxy` and `reverse_proxy_addresses` settings so this
resolves to the real visitor address instead of the proxy.

## Response
`response` is a YAML map (edited via the form's Response fieldset):

```yaml
code: 403            # 200 | 301 | 302 | 403 | 404 | 410 | 500 | 503 (default 403)
redirect_url: null   # used only for 301/302
body: 'Access denied.'  # used for all codes except 301/302
```

## Worked examples
Block one IP from the whole site (front page shown; broaden the path condition to cover more):

```yaml
# conditions
- { type: path, path: '*' }
# rules
- { type: ip, action: deny, address: 198.51.100.10 }
# response
code: 403
body: 'Forbidden.'
```

Restrict `/admin` and its subpaths to an office subnet, redirecting others home:

```yaml
# conditions
- { type: path, path: '/\/admin(\/|$)/', regex: 1 }
# rules
- { type: ip, action: deny,  address: '*' }
- { type: ip, action: allow, address: 203.0.113.0/24 }
# response
code: 302
redirect_url: /
```

## Kill switch
Add to `settings.php` to disable all filtering (use to recover from a self-lockout):

```php
$settings['access_filter_disabled'] = TRUE;
```

Custom condition/rule plugins can be added under `Plugin/AccessFilter/Condition` or
`Plugin/AccessFilter/Rule` using the `@AccessFilterCondition` / `@AccessFilterRule` annotations.
