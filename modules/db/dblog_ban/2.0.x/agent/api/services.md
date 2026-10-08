<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dblog_ban — routes, controller, services, and Views field

## Routes (dblog_ban.routing.yml)
- `dblog_ban.ban` — path `/dblog_ban/{js}/ban/{ip}`, `_controller: IpBanUnbanController::ajaxBan`.
- `dblog_ban.unban` — path `/dblog_ban/{js}/unban/{ip}`, `_controller: IpBanUnbanController::ajaxUnban`.
- Requirements on both: `{js}` matches `nojs|ajax`; `_permission: 'ban IP addresses'` (core `ban`);
  `_dblog_ban_csrf_ajax_token: 'TRUE'` (module CSRF check, below).

## Controller flow (Controller\IpBanUnbanController)
Constructed with `ban.ip_manager`, `dblog_ban.link_generator`, `dblog_ban.ip_validator`.
- `ajaxBan($js, $ip)`: if `$js !== 'ajax'` returns the `IpBanConfirmForm`. Otherwise
  `$rawIp = urldecode($ip)`; if `IpValidator::isValidIp($rawIp)` and NOT `isMyIp($rawIp)`, calls
  `BanIpManager::banIp($rawIp)`, then returns an `AjaxResponse` with a `ReplaceCommand` that swaps
  the ban link (matched by `[data-dblog_ban-ip='$rawIp'][data-dblog_ban-action='ban']`) for the
  unban link.
- `ajaxUnban($js, $ip)`: mirror; on valid IP calls `BanIpManager::unbanIp($rawIp)` and replaces the
  unban link with a ban link. (Unban does not require the isMyIp check.)

## Confirm forms (Form\)
- `BanUnbanConfirmFormBase` (`ConfirmFormBase`): `buildForm(..., $ip)` throws
  `NotFoundHttpException` (404) when `IpValidator::isValidIp($ip)` is FALSE, else stores `$this->banIp`.
  Cancel URL is `dblog.overview`.
- `IpBanConfirmForm` (`dblog_ban_confirm_ban`): on submit, re-checks `isValidIp && !isMyIp` then
  `banIp()`, adds a status/error message.
- `IpUnbanConfirmForm` (`dblog_ban_confirm_unban`): on submit, re-checks `isValidIp` then `unbanIp()`.

## Services
### IpValidator (dblog_ban.ip_validator)
- `isValidIp(?string)`: FALSE if null or `strlen > 40` (core `ban` schema limit); else
  `filter_var($h, FILTER_VALIDATE_IP, FILTER_FLAG_NO_RES_RANGE) !== FALSE` — rejects private/reserved
  ranges. `isMyIp(?string)`: strict `===` compare with `RequestStack` current request `getClientIp()`.

### BanLinkGenerator (dblog_ban.link_generator)
- `getBanLink`/`getUnbanLink` return `Link::fromTextAndUrl(...)->toRenderable()` render arrays with
  `#cache max-age 0`; when `use_ajax_links` is on, attach `core/drupal.ajax` and add the `use-ajax`
  class. `getBanUrl`/`getUnbanUrl` build `Url::fromRoute('dblog_ban.ban'|'.unban', {js:'nojs', ip:urlencode})`.
  `getUrlOptions()` adds a `destination` query param and `data-dblog_ban-ip` / `data-dblog_ban-action`
  attributes (used by the AJAX ReplaceCommand selectors and tests).

### WatchdogViewsRowParser (dblog_ban.watchdog_views_row_parser)
- `getHostnameFromWatchdogResultRow(ResultRow)`: returns `$row->watchdog_hostname` if present and a
  string; else if `wid` present, `getHostnameFromWid((int)$row->wid)`; else NULL.
- `getHostnameFromWid(int)`: parameterized query
  `SELECT hostname FROM {watchdog} WHERE [wid] = :wid LIMIT 1` (bound `:wid`, int cast); NULL if not found.

### CSRF services (internal, workaround for core node/2670798)
- `RouteProcessorCsrfAjax` (outbound `route_processor_outbound`): for routes requiring
  `_dblog_ban_csrf_ajax_token`, injects a `token` query param — either the real token or a
  lazy-builder placeholder (`renderPlaceholderCsrfToken`) preserving cacheability. `preparePath()`
  builds the token path from the route path minus the `js` parameter.
- `CsrfAjaxAccessCheck` (`access_check`, `applies_to: _dblog_ban_csrf_ajax_token`): extends core
  `CsrfAccessCheck`; validates `request->query->get('token')` against the same path (via
  `RouteProcessorCsrfAjax::preparePath`); allowed on match, forbidden otherwise; `max-age 0`.
  This means the ban/unban GET links carry a per-session, path-bound CSRF token.

## Views field plugin (Plugin\views\field\DblogBanBanUnbanLink)
- `@ViewsField("dblog_ban_ban_unban_link")`, registered on `watchdog` via `dblog_ban.views.inc`.
- `render(ResultRow)`: resolves IP via the row parser; returns `[]` (no link) if `isMyIp` or not
  `isValidIp`; else if `BanIpManager::isBanned($ip)` returns the unban link, otherwise the ban link.
- `clickSortable()` FALSE, `usesGroupBy()` FALSE, `query()` no-op.
