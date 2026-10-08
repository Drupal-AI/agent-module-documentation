# Spam Master — runtime architecture & services

## Request-time firewall — `SpamMasterFirewallSubscriber`

Subscribes to `KernelEvents::REQUEST` (`checkForRedirection`). Steps:
1. Bootstrap: ensures version/db-version state, runs `SpamMasterUpdaterService` when db version differs.
2. **Gate:** returns immediately unless license status ∈ {VALID, MALFUNCTION_1, MALFUNCTION_2}
   AND `spammaster.settings:subtype === 'prod'`.
3. Lazy license sync every ~2 days (`SpamMasterKeyService::spamMasterKeyLazy` → license daily call + cleanup).
4. Reads `form_id`, `spammaster_extra_field_1`, `spammaster_extra_field_2` from the POST body.
5. **Exemptions:** whitelisted IP/form-id (query on `spammaster_white`) or admin
   (`administer site configuration` / `administer nodes`) → return.
6. **Flood control** (if enabled, on POST): counts recent `post-flood` rows for the IP in
   `spammaster_keys`; over limit → 429 firewall response (calls elusive check + inserts block marker
   once per window).
7. **Buffer block:** if the client IP is in `spammaster_threats` and the user is anonymous → 403
   firewall response (with rate-limited logging to avoid log-flood DOS).
8. **Honeypot:** if a honeypot field is non-empty → `SpamMasterHoneypotService::spamMasterHoneypotCheck`
   then 403.
9. **Elusive:** advanced bot heuristic (`SpamMasterElusiveService::spamMasterElusiveCheck`) → 403 if `ELUSIVE`.

Block responses come from `getFirewallBlockResponse()` which HTML-escapes IP and User-Agent
(`htmlspecialchars`, ENT_QUOTES) before echoing them.

## SaaS / license services

- `SpamMasterApiService` — thin Guzzle wrapper: `postLicenseData()`, `postScanData()` POST
  `form_params` to a spammaster.org endpoint and JSON-decode the reply.
- `SpamMasterLicService` — builds the license payload (site name, admin email, IP/hostname,
  version, license key, db hash) and calls:
  - `…/core/lic/lic_gen.php` (auto-create FREE license on install; sends fixed
    `spam_trial_nounce = PW9pdXNkbmVXMndzUw==` — a shared, non-secret vendor trial nonce),
  - `…/core/lic/get_lic.php` (manual + daily sync),
  - `…/core/lic/get_other.php` (uninstall/disable).
  Stores returned status/type/expiry/threat-count in state. The per-install `license_key` and the
  rotating `spam_master_db_protection_hash` (regenerated every 7 days via `md5(uniqid(mt_rand()))`)
  are generated locally — nothing secret is shipped in code.
- `SpamMasterActionService::spamMasterAct()` — when the license reply signals `a=1`, POSTs
  `blog_license_key` + `blog_hash_key` to `…/core/learn/get_learn_act.php`; applies the returned
  `action` (Add/Remove/Change) + `where`/`pack`/`type` to the local threat/white/exempt tables and,
  for `where=editable`/`state`, to `spammaster.settings_protection` config or state. Loops until no
  new options.
- `SpamMasterCronService` — hook_cron entry: daily license sync + cleanup + reports.
- `SpamMasterCleanUpService`, `SpamMasterUpdaterService`, `SpamMasterMailService`,
  `SpamMasterUserService`, `SpamMasterCollectService` — cleanup by retention days, DB schema
  updates, alert/report mail, current-user/IP collection.

## Routes / controllers

| Route | Path | Method | Access | Purpose |
|---|---|---|---|---|
| `spammaster.spammasterfirewall` | `/firewall` | GET | `access content` | Themed firewall/block landing page (`firewall.html.twig`), shows client IP + UA. |
| `spammaster.spammasteraction` | `/spam-master/v1` | POST | `access content` | SaaS callback: apply actions / return statistics. |

`/spam-master/v1` (`SpamMasterActionController::spamMasterToAct`) requires the POST JSON body to
contain `k` == `spammaster.settings:license_key` AND `h` == `state:spam_master_db_protection_hash`
(both htmlentity-encoded); any mismatch → 401. With `v=1` it returns a statistics dump; otherwise it
invokes `spamMasterAct()`. So although the route permission is the near-universal `access content`,
every meaningful action is gated by knowledge of the site's per-install license key + rotating hash.

## DB tables (`hook_schema`)

- `spammaster_threats` — blacklist buffer: `id, date, threat` (IP or email).
- `spammaster_white` — whitelist: `id, date, white` (IP or form-id).
- `spammaster_keys` — everything else: logs, `exempt-*` rules, `post-flood[-blocked]` counters,
  `white-transient-*`; columns `id, date, spamkey, spamvalue`.

All queries use `:placeholder` parameters or the query builder; there is no Drush integration.

> Note: `spammaster.services.yml` declares three block services
> (`spammaster.block_totalblockcount`, `…_statusblock`, `…_headsupblock`) whose
> `Drupal\spammaster\Block\*` classes are not present in this release — those block services are
> non-functional dead config, not usable blocks.
