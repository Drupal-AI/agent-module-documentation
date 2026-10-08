<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Billwerk Subscriptions (billwerk_subscriptions) — agent index

**Syncs Drupal users with Billwerk (reepay) subscription contracts and maps plans to roles.**

- **Version:** 1.0.x (1.0.0-beta16)
- **Core:** ^10.3 || ^11 · depends on `locale`
- **Configure route:** `billwerk_subscriptions_manage.settings` → `/admin/config/services/billwerk-subscriptions/settings` (`administer billwerk_subscriptions configuration`, restrict access)
- **Routes:** webhook listener `/billwerk-subscriptions/webhook-listener/{secret}` (`_access: TRUE`, `{secret}` matched with strict `===` then details re-fetched from Billwerk API); `/user/{user}/subscription/refresh` (`_user_is_logged_in` + custom access).
- **Permissions:** administer config; manual refresh; fetch/assign contract ids; self-service manage own / any contract.
- **Key code:** `src/Api.php`, `src/Environment.php`, `src/SettingsHelper.php`, `src/BillwerkRolesManager.php`, `src/Subscriber.php`, `src/EmbedHelper.php`, `src/CacheHelper.php`, `src/LogHelper.php`.

**Security:** webhook is intentionally public but authenticated by a strict `===` secret-in-path check and re-fetches authoritative data from Billwerk (does not trust the POST body) — reviewed as sound. Admin route restrict-access; refresh form requires login + custom access. Keep the API key and webhook secret confidential.

See [configure/billwerk.md](configure/billwerk.md)