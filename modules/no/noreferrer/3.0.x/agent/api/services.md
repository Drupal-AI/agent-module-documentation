<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# No Referrer services

Three autowired services in `src/Allowlist/`, registered by **fully-qualified class name**
(not a short id) with `autowire: true`:

```php
$validator  = \Drupal::service(\Drupal\noreferrer\Allowlist\Validator::class);
$publisher  = \Drupal::service(\Drupal\noreferrer\Allowlist\Publisher::class);
$subscriber = \Drupal::service(\Drupal\noreferrer\Allowlist\Subscriber::class);
```
In your own service, type-hint the class and let autowiring inject it.

## `Allowlist\Validator`
```php
public function isAllowed(string $url): bool
```
Returns TRUE if the URL's host is in `noreferrer.settings:allowed_domains`. Match is
case-insensitive against the exact host **or** any subdomain (host ends with `.<domain>`).
Empty list, unparsable host, or non-string entries → FALSE. This is the same check both the
`link_alter` hook and the `noreferrer` filter use to decide whether to skip a link.

## `Allowlist\Publisher`
```php
public function publish(): void      // writes allowed_domains as JSON to getPublishUri()
public function getPublishUri(): string
```
`getPublishUri()` returns `public://noreferrer-allowlist-<hmac>.json`, where `<hmac>` is
`Crypt::hmacBase64('noreferrer-allowlist', $privateKey)` — a per-site secret so the URL is
unguessable. `publish()` json-encodes `allowed_domains` and saves it (overwriting). Called on
form save when `publish` is TRUE.

## `Allowlist\Subscriber`
```php
public function subscribe(string $url): void
```
GETs `$url` (Guzzle), decodes the body as a JSON array, filters to strings, and writes it to
`noreferrer.settings:allowed_domains`. Errors (HTTP failure, non-array body) are logged to the
`noreferrer` logger channel and the current list is left unchanged. Called from
`hook_cron` and on form save when `subscribe_url` is set.

## Hooks the module implements (not extension points)
- `hook_link_alter` (`src/Hook/LinkAlter.php`) — adds `noopener`/`noreferrer` to code links.
- `hook_cron` (`src/Hook/Cron.php`) — re-subscribes if `subscribe_url` is set.
- `hook_help` (`src/Hook/Help.php`).

The module exposes **no `*.api.php`**, so there are no hooks it invites you to implement.
