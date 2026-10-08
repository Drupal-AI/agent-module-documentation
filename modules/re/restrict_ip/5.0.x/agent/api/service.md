# Restrict IP — service API

Service id **`restrict_ip.service`** → `Drupal\restrict_ip\Service\RestrictIpService`
(interface `RestrictIpServiceInterface`). This is where the allowed IP list and page
white/blacklist actually live (backed by `restrict_ip.mapper` → DB tables), so use it rather
than reading config for those.

```php
$svc = \Drupal::service('restrict_ip.service');
```

## Methods (from `RestrictIpServiceInterface`)

| Method | Purpose |
|---|---|
| `userIsBlocked(): bool` | Whether the current user is currently blocked. |
| `testForBlock(bool $runInCli = FALSE)` | Run all checks and decide whether to block (the event subscriber calls this). |
| `getCurrentUserIp(): string` | The current client IP. |
| `getCurrentPath(): string` | The current path (lowercased). |
| `cleanIpAddressInput(string $input): array` | Parse a newline-separated textarea (strips `#` comments/whitespace) into an array of candidate IPs. |
| `getWhitelistedIpAddresses(): array` | The allowed IP list. |
| `saveWhitelistedIpAddresses(array $ips, bool $overwriteExisting = TRUE)` | Save the allowed IP list. |
| `getWhitelistedPagePaths(): array` / `saveWhitelistedPagePaths(array $paths, bool $overwrite = TRUE)` | Read/write whitelisted pages (used when `white_black_list = 1`). |
| `getBlacklistedPagePaths(): array` / `saveBlacklistedPagePaths(array $paths, bool $overwrite = TRUE)` | Read/write blacklisted pages (used when `white_black_list = 2`). |

## Example — set the allowlist programmatically

```php
$svc = \Drupal::service('restrict_ip.service');
$svc->saveWhitelistedIpAddresses(['203.0.113.10', '203.0.113.0/24'], TRUE);
print_r($svc->getWhitelistedIpAddresses());
```

## Related services

- `restrict_ip.mapper` (`RestrictIpMapper`) — the DB data mapper the service delegates to.
- `restrict_ip.event_subscriber` (`RestrictIpEventSubscriber`) — subscribes to `kernel.request`
  and calls `testForBlock()` to enforce the restriction.
- The service optionally consumes `ip2country.lookup` (via `setIp2Country()`) for country checks.
