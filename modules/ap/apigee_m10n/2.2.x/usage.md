<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Apigee Monetization brings Apigee's API monetization into Drupal — rate plans, prepaid balances and developer purchases for API products.

---

When an organisation sells access to its APIs, the developer portal is where that transaction happens: a developer browses API products, picks a rate plan, tops up a balance and sees their usage. Apigee handles the metering and billing; Drupal, through the Apigee Edge module family, is the portal. This module adds the monetization half of that portal.

**It cannot be installed on Drupal 11.4, and it was verified.** Its dependency `apigee_edge` 4.1.0 injects the container parameter `%main_content_renderers%` into two event subscribers:

```yaml
arguments:
  - '@class_resolver'
  - '@current_route_match'
  - '%main_content_renderers%'
```

Drupal 11.4 core **no longer defines that parameter**, so the container cannot compile:

```
DefinitionErrorExceptionPass: You have requested a non-existent parameter "main_content_renderers".
```

That is a hard container-build failure — site and Drush both — and because it happens during module installation it takes down the rest of the wave with it: on this install it fataled mid-batch and left **80 of 120 modules half-installed**, a state that reports as Enabled while `hook_install()` never ran. Recovery meant restoring the database and re-running without the module.

The affected subscribers are `EdgeExceptionSubscriber` and `apigee_edge_teams`' `TeamInactiveStatusSubscriber`, both of which use the renderer list to render an error page in the right format. The fix is to inject the renderers via a service or resolve them from the tagged services rather than a removed parameter.

Check `apigee_edge` for a release that supports the core you are on before planning an Apigee portal on Drupal 11.

---

- Sell access to API products.
- Offer rate plans to developers.
- Manage prepaid balances.
- Show a developer their API usage.
- Build a monetized developer portal.
- Integrate Apigee billing with Drupal.
- Check apigee_edge against your core version.
- Diagnose a non-existent container parameter.
- Recover a site after a container-build failure.
- Find modules left half-installed by a mid-install fatal.
- Restore a database after a failed wave.
- Report the removed parameter upstream.
- Plan an Apigee portal on a supported core.
- Evaluate the module once apigee_edge is fixed.
- Understand why 80 modules half-installed at once.
