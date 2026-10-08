<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: hook_trusted_redirect_hosts_alter()

Declared in `trusted_redirect.api.php`. Lets modules add to (or otherwise alter) the list of
trusted hosts at runtime, on top of what is stored in `trusted_redirect.settings:trusted_hosts`.

```php
/**
 * Allow modules to alter the list of trusted hosts.
 *
 * @param array $trusted_hosts
 *   Array of trusted hosts (bare hostnames).
 */
function hook_trusted_redirect_hosts_alter(array &$trusted_hosts) {
  $satellite_hosts = \Drupal::config('satellite.settings')->get('hosts');
  $trusted_hosts = array_merge($trusted_hosts, $satellite_hosts);
}
```

## When it runs
`TrustedRedirectHelpersTrait::getTrustedHosts()` loads the stored `trusted_hosts`, then calls
`$moduleHandler->alter('trusted_redirect_hosts', $this->trustedHosts)` and caches the result on
the object for the rest of the request. Entries you add are compared the same exact way as
configured hosts (`in_array($parsedHost, $trusted_hosts)`), so add **bare hostnames**, not URLs.

## Caveat in the example
The doc-block example writes `array_merge(...)` without assigning back to `$trusted_hosts`, which
would be a no-op. To actually add hosts, assign back (as shown above) or push entries onto the
by-reference `$trusted_hosts` array.

## Security note
This hook is a code path that **widens** what the site will redirect to. Anything it adds becomes
an allowed external redirect target for all visitors (including anonymous). Only add hosts you
control or fully trust, and never derive them from request input.
