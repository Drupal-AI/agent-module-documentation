<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate retry allows retrying migration items that failed due to unexpected errors, improving migration resilience.

---

Migrate retry improves migration resilience by retrying rows that failed due to unexpected/transient
errors — network hiccups, timeouts, temporary API failures — instead of leaving them permanently failed.
It depends on the Migrate module and is configured at `migrate_retry.settings`; it provides its own
permissions.

Use it on migrations that pull from external/unreliable sources where transient failures shouldn't require
a full re-run. It is a developer/migration tool operating within the Migrate framework (Drush-driven
typically); it re-processes failed rows and has no runtime access role. Configure the retry behaviour
(which errors, how many attempts).

---

- Retry failed migration rows.
- Recover from transient errors.
- Handle network/timeout failures.
- Depend on the Migrate module.
- Configure at migrate_retry.settings.
- Provide its own permissions.
- Improve migration resilience.
- Avoid full re-runs for transient failures.
- Re-process failed rows.
- Configure retry attempts.
- Handle unreliable sources.
- Run within the Migrate framework.
- Have no runtime access role.
- Retry after API failures.
- Reduce permanent failures.
- Configure which errors retry.
- Make migrations robust.
- Retry unexpected errors.
- Recover migration rows.
- Improve import reliability.
