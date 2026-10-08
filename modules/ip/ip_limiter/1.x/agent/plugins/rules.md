<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — IpLimiterRule rule type

IP Limiter defines one annotation-based plugin type, **`IpLimiterRule`**, used to decide whether a
request matches a rule and with what limits. Other modules can add rule plugins.

## Plugin type wiring
- **Manager service:** `ip_limiter.rule_manager` → `Drupal\ip_limiter\IpLimiterRuleManager`
  (extends `DefaultPluginManager`). Constructed with `'Plugin/IpLimiterRule'`,
  `IpLimiterRuleInterface::class`, annotation `Drupal\ip_limiter\Annotation\IpLimiterRule`.
- **Discovery dir:** `src/Plugin/IpLimiterRule/` in any module.
- **Annotation** (`@IpLimiterRule`): fields `id`, `label` (`@Translation`), `description`
  (`@Translation`).
- **Interface:** `Drupal\ip_limiter\IpLimiterRule\IpLimiterRuleInterface`.
- **Alter hook:** `hook_ip_limiter_rule_info` (alterInfo `ip_limiter_rule_info`).
- **Cache:** definitions cached under `ip_limiter_rule_plugins` (clear with `drush cr` after adding a plugin).
- **Instantiation:** `IpLimiterRuleManager::getConfiguredRules(ImmutableConfig $settings)` reads
  `ip_limiter.settings:rules`, skips entries whose `plugin_id` has no definition, normalizes each
  rule mapping into the plugin `$configuration`, and returns instances in config order.

## Interface methods (`IpLimiterRuleInterface`)
```php
public function applies(Request $request): bool;   // does this rule match the request?
public function getResponseType(): int;            // 403 | 404 | 429
public function getBanDuration(): int;              // seconds
public function getTimePeriod(): int;              // rolling window seconds
public function getMaxRequests(): int;             // threshold
public function isGlobalRestrict(): bool;          // check ban on all requests?
public function getDescription(): string;
public function getMatcherConditions(): array;     // user_agent_filter / query_param_pattern / require_referer
```
The subscriber calls `applies()` + `isGlobalRestrict()` to decide whether to act, then uses the
getters for the ban parameters and response. It does **not** call `getMatcherConditions()` directly —
matcher conditions are consumed inside a rule's own `applies()` (via `RuleMatcherTrait`).

## Built-in plugins
### `path` — `PathRule`
`applies()` = `matchesPath()` AND `matchesConditions()`. Subject is
`trim($request->getPathInfo(), " …/")` (leading/trailing slashes stripped). Exact `in_array()` unless
`regex` is set, then each line is `@preg_match('{' . $pattern . '}', $currentPath) === 1`.

### `route` — `RouteRule`
Implements `ContainerFactoryPluginInterface`; injects `router.no_access_checks`. `applies()` =
`matchesRoute()` AND `matchesConditions()`. Route name is `$request->attributes->get('_route')` if
already resolved, else resolved via `$router->match($request->getPathInfo())` (catches
`ResourceNotFoundException`/`\Exception` → `''`). Exact match unless `regex`.

### `user_agent` — `UserAgentRule`
No matcher_conditions. `applies()` reads the `User-Agent` header, builds a pattern set from selected
presets (`use_presets`+`presets`) plus `custom_patterns` lines, OR-joins them, and matches
`{combined}i`. `blacklist` → applies when matched; `whitelist` → applies when **not** matched. Empty
pattern set never matches (blacklist never fires; whitelist blocks everyone).

## Matcher conditions — `Matcher\RuleMatcherTrait`
Used by `PathRule`/`RouteRule`. `matchesConditions()` returns TRUE (all pass) when
`matcher_conditions` is empty, else ANDs three checks:
- `matchesUserAgent()` — `exclude_bots`/`block_bots` using `isBotUserAgent()`; a UA is a "bot" if it
  is empty or matches the `common_bots` preset.
- `matchesQueryParams()` — `preg_match($pattern, $request->getQueryString())` when a pattern is set.
- `matchesReferer()` — requires a non-empty `Referer` header when `require_referer` is TRUE.

## Presets — `Matcher\UserAgentPresets`
Static map `getAll()` / `get($id)`. Values are regex fragments matched case-insensitively.
- HTTP clients: `curl`, `wget`, `httpie`, `postman`.
- Language libs: `python`, `java`, `go`, `php`, `node`.
- Scrapers: `scrapy`, `headless_chrome`, `phantomjs`.
- Security scanners: `nikto`, `sqlmap`, `nmap`, `masscan`, `wpscan`, `dirbuster`, `nuclei`, `zgrab`.
- SEO/monitoring: `semrush`, `ahrefs`, `mj12`, `dotbot`, `petalbot`.
- Aggregates: `common_bots` (`curl|wget|python|scrapy|nikto|sqlmap|nmap|masscan`),
  `security_scanners`, `seo_bots`.

## Adding a custom rule plugin
```php
// modules/custom/my_module/src/Plugin/IpLimiterRule/MethodRule.php
namespace Drupal\my_module\Plugin\IpLimiterRule;

use Drupal\Core\Plugin\PluginBase;
use Drupal\ip_limiter\IpLimiterRule\IpLimiterRuleInterface;
use Symfony\Component\HttpFoundation\Request;

/**
 * @IpLimiterRule(
 *   id = "http_method",
 *   label = @Translation("HTTP method rule"),
 *   description = @Translation("Restrict by request method.")
 * )
 */
class MethodRule extends PluginBase implements IpLimiterRuleInterface {
  public function applies(Request $request): bool {
    return strtoupper($request->getMethod())
      === strtoupper(trim((string) ($this->configuration['condition'] ?? '')));
  }
  public function getResponseType(): int { return (int) ($this->configuration['response_type'] ?? 403); }
  public function getBanDuration(): int { return (int) ($this->configuration['ban_duration'] ?? 300); }
  public function getTimePeriod(): int { return (int) ($this->configuration['time_period'] ?? 60); }
  public function getMaxRequests(): int { return (int) ($this->configuration['max_requests'] ?? 10); }
  public function isGlobalRestrict(): bool { return (bool) ($this->configuration['global_restrict'] ?? FALSE); }
  public function getDescription(): string { return (string) ($this->configuration['description'] ?? ''); }
  public function getMatcherConditions(): array { return $this->configuration['matcher_conditions'] ?? []; }
}
```
The `$configuration` passed in is the normalized rule array from
`IpLimiterRuleManager::getConfiguredRules()` — every stored key (`condition`, `regex`,
`response_type`, `matcher_conditions`, the user_agent fields, etc.) is available even if your plugin
ignores most of them. The stock settings form only renders inputs for the three built-in ids, so a
custom plugin typically needs config set programmatically or its own form additions.
