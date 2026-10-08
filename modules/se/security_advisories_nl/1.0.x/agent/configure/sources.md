<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Security Advisories NL — sources, fetch pipeline & routes

## Sources (admin only)
`/admin/config/system/security-advisories-nl/sources` (`administer security advisories nl`). Each source in `security_advisories_nl.settings:sources` = `{id,label,url,type(rss|json|html),color,enabled}`. `SourceForm::validateForm()` enforces `FILTER_VALIDATE_URL`. Because only admins with the restricted permission can add URLs, the server-side fetch target is not attacker-controlled.

## Fetch / parse pipeline
`AdvisoryFetcherService` ← parsers (`NcscParserService`, `RssParserService`, `WordPressParserService`) ← `HttpCacheService::get()` which wraps `http_client` with the `cache.security_advisories_nl` bin (per-type TTLs). `fetchDirect()` uses `$httpClient->request('GET',$url,$options)` with Guzzle defaults — **TLS verification stays on** (no `verify=>false`). `QueueManagerService` + `FetchAdvisoryQueueWorker` / `FetchContentQueueWorker` batch the work.

## Admin actions (`AdvisoryController`, all `administer security advisories nl`)
fetch, updateContent, refetchContent, updateCves, updateSeverity, clearCache, queueStatus, processQueueNow, cleanupDuplicates, clearAll, refreshAdvisory (`manage security advisories`).

## Entity & routes
Entity type `security_advisory` (collection/delete under `manage security advisories`). Public: `/security-advisories` (list) and `/security-advisory/{advisory}` (single), both `view security advisories`. Drush: `SecurityAdvisoriesCommands`.

## Hardening
Keep `administer security advisories nl` to trusted staff (controls outbound fetch targets); expose `view security advisories` to your intended audience only.
