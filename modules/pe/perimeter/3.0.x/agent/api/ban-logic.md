<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ban logic & services

Perimeter exposes no public API service of its own — it is one event subscriber
plus one hook. The moving parts:

## The event subscriber

`Drupal\perimeter\EventSubscriber\PerimeterSubscriber` (service id
`perimeter.perimeter`, injected with `logger.factory`, `config.factory`,
`current_user`, `ban.ip_manager`, `flood`).

- Subscribes to **`KernelEvents::EXCEPTION`** only (`onKernelException`).
- Acts only when the throwable is a `Symfony\...\NotFoundHttpException` (HTTP 404).
- Flow in `handleBannedUrls(Request $request)`:
  1. Bail if the current user has `bypass perimeter defence rules`, or the client
     IP is whitelisted (`IpUtils::checkIp` against `whitelisted_ips`).
  2. Loop `not_found_exception_patterns`; `preg_match($pattern, $request->getPathInfo())`.
  3. On a match, if `flood_threshold > 0` and the flood service still allows it,
     register a flood hit and return (no ban yet).
  4. Otherwise `\Drupal::service('ban.ip_manager')->banIp($clientIp)`, log a
     `notice` on the **`Perimeter`** logger channel, clear the flood counter, break.

Important: the subscriber fires on **uncached 404 exceptions only**. A page served
from the page cache never dispatches the exception, so repeated hits to the *same*
banned URL can be served from cache and count as a single attempt — which is why
the flood examples in core's tests visit *different* URLs.

Flood key: `perimeter.not_found_attempt_ip` (the Honeypot path uses
`perimeter.honeypot`).

## The core Ban service (how the ban is actually stored)

`ban.ip_manager` → `Drupal\ban\BanIpManagerInterface`:

```php
$m = \Drupal::service('ban.ip_manager');
$m->banIp('203.0.113.45');        // MERGE into the {ban_ip} table
$m->isBanned('203.0.113.45');     // bool
$m->unbanIp('203.0.113.45');      // DELETE by IP string (param is the IP, not the id)
$m->findAll();                    // Statement: rows of (iid, ip)
$m->findById($iid);               // returns the ip for a row id
```

Once an IP is in `{ban_ip}`, core Ban's own middleware/subscriber returns 403 for
every request from it — Perimeter is not involved after the ban is written.

## Reproducing a ban programmatically

There is no "perimeter ban this IP" API; to represent Perimeter's effect you call
the same core service it calls:

```bash
drush php:eval '\Drupal::service("ban.ip_manager")->banIp("203.0.113.99");'
drush php:eval 'var_dump(\Drupal::service("ban.ip_manager")->isBanned("203.0.113.99"));'
```
