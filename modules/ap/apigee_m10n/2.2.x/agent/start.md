<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee Monetization (apigee_m10n) — agent index

Apigee API monetization for a developer portal — rate plans, prepaid balances, purchases.
Version **2.2.0**. Core `^10 || ^11`. Depends on **`apigee_edge`** (4.1.0 here).

**Documented from source — cannot be installed on Drupal 11.4. Verified:**

`apigee_edge` injects the container parameter **`%main_content_renderers%`** into
`EdgeExceptionSubscriber` and `apigee_edge_teams`' `TeamInactiveStatusSubscriber`. **Drupal 11.4
core no longer defines that parameter:**

```
DefinitionErrorExceptionPass: You have requested a non-existent parameter "main_content_renderers".
```

Hard container-build failure — site and Drush both down. Because it fires **during module
installation**, it took the rest of the wave with it: **80 of 120 modules half-installed** on this
site, reporting as Enabled with `hook_install()` never run. Recovery required restoring the
database.

Upstream fix: resolve the renderers from tagged services or inject a service, not a removed
parameter. Check `apigee_edge` for a core-11.4-compatible release before planning an Apigee
portal.