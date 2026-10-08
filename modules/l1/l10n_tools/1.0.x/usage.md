<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
L10n Tools is a maintenance module that trims Drupal's interface-translation (`locale`) database tables through three operations: removing translations identical to their source string, removing untranslated source strings, and resetting the translation-update status so core re-checks localize.drupal.org.

---

Install with `composer require drupal/l10n_tools` and enable it (`drush en l10n_tools`); it depends only on core's Interface Translation (`locale`) module and requires no third-party libraries. Grant the restricted **`access l10n_tools form`** permission, then open *Configuration › Regional and language › L10n Tools* (`/admin/config/regional/l10n_tools`). The form has three collapsible sections, each of which acts immediately on the database — there is no saved configuration and no undo. **Equal translations**: click "Show all equal translations" to list every entry whose translated string is byte-identical to its source (optionally scoped to only user-customized, only imported, or both via the filter select), then "Clear translations of all listed equal translations" to delete those target rows. **Orphan / untranslated translations**: list, then delete `locales_source` strings that have no translation at all — the form notes this is safe because Drupal rebuilds those source strings on demand. **Reset translation status**: clears the recorded translation-update status and zeroes the last-checked timestamps for all projects, so the next update check re-downloads from localize.drupal.org (use the provided link, or `drush locale-check && drush locale-update`, to run it). The same three operations are available as Drush commands — `l10n_tools:deet` (with `--custom-only` / `--imported-only` / `--both`), `l10n_tools:deot`, and `l10n_tools:rets`. Because deletions are immediate and irreversible, **back up the database first**; note that hand-entered custom translations live only in the database and cannot be re-downloaded, and that the module's SQL is MySQL/MariaDB-specific. This is version 1.0.3, compatible with Drupal `^9 || ^10 || ^11`.

---

- Delete translations that are identical to their source string.
- Remove only user-customized "equal" translations.
- Remove only imported (localize.drupal.org) "equal" translations.
- Clean up both imported and customized equal translations at once.
- Delete source strings that were never translated.
- List equal or orphan translations to preview before deleting.
- Reset the interface-translation update status.
- Force Drupal to re-check localize.drupal.org for new translations.
- Zero the `locale_file` last-checked timestamps for all projects.
- Run translation cleanup from the admin UI.
- Run translation cleanup from the CLI with Drush.
- Shrink oversized `locales_source` / `locales_target` tables.
- Speed up database exports on a large multilingual site.
- Reduce backup size on a translation-heavy site.
- Tidy an inherited or long-lived multilingual site.
- Clean up a development database after translation testing.
- Prepare a site before a major translation re-import.
- Recover translation-update checking after a stuck status.
- Reduce load on the translation administration UI.
- Automate periodic locale-table cleanup via cron-run Drush.
