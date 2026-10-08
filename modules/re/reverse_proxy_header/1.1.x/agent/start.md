<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reverse Proxy Header — agent index

Tells Drupal which **custom HTTP header** holds the real client IP and restores it into
`REMOTE_ADDR` early in the request. Configured **only via `$settings` in `settings.php`** —
no UI, no config entity, no permissions, no Drush, no plugins. One event subscriber does the
work.

- **The two `$settings` keys, how the header is chosen, trusted-proxy logic, priority 350** →
  [configure/settings.md](configure/settings.md)

Key facts:
- `$settings['reverse_proxy_header'] = 'HTTP_X_FORWARDED_FOR_CUSTOM_HEADER';` — the header
  name to read (a `$_SERVER` key). If unset, the module is a no-op.
- `$settings['reverse_proxy_header_trusted_addresses_ignore'] = TRUE;` — always trust the
  header even when it did not come from a trusted proxy (allows spoofing; default `FALSE`).
- Subscriber `reverse_proxy_header.client_ip_restore` runs on `KernelEvents::REQUEST` at
  priority **350**, before `RouterListener`/`AuthenticationSubscriber`.
- It takes the **first** comma-separated value that passes `FILTER_VALIDATE_IP` and sets
  `REMOTE_ADDR`; invalid/empty values are logged to the `reverse_proxy_header` channel.
- Read the effective value with `drush ev "print \Drupal\Core\Site\Settings::get('reverse_proxy_header');"`.
