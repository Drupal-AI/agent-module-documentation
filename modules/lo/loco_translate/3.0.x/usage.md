<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Loco Translate provides a normalised way to collect and gather internationalisation assets and translations into and from Loco.

---

Loco Translate integrates Drupal with Loco (localise.biz) — providing a normalized way to collect the
site's interface (i18n) strings and push/pull translations to and from Loco, so translation work happens in
Loco's translation-management platform and syncs back to Drupal. It depends on core Locale, provides Drush
commands and its own permissions, in the Multilingual package.

Use it to manage interface translations via Loco. Security note: it authenticates to the Loco API with an
API key — **store that key as a secret** (Key entity / environment variable), not in exported config, and
operate over HTTPS. It handles interface strings (not typically sensitive content), and it has no
access-control role beyond its permission. Configure the Loco connection and sync.

---

- Sync interface translations with Loco.
- Push/pull translations to/from Loco.
- Collect i18n strings.
- Depend on core Locale.
- Provide Drush commands and permissions.
- Store the Loco API key as a secret.
- Avoid the key in exported config.
- Operate over HTTPS.
- Have no access-control role beyond permission.
- Manage translations in Loco.
- Configure the Loco connection.
- Handle interface translation.
- Sync translations.
- Configure the sync.
- Gather i18n assets.
- Handle credentials securely.
- Integrate Loco.
- Manage i18n.
- Configure Loco.
- Sync i18n strings.
