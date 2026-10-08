<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Purge Varnish purges the Varnish layer in front of an Acquia Cloud environment, from an admin form or Drush, with controls that distinguish one environment from another.

---

On Acquia Cloud, Varnish sits between visitors and Drupal, and a content change that Drupal knows about is invisible until Varnish is told. The usual answer is the Purge module stack, which is powerful and involved; this module is the narrower, more direct option — an API client for Acquia's purge endpoint, a form to trigger purges, and Drush commands so purging can be part of a deployment script.

The per-environment controls matter more than they sound. A purge issued against the wrong environment is either useless (you cleared dev and prod is still stale) or disruptive (you cleared prod during a traffic peak and every request now goes to origin). Making the environment explicit in configuration and in the command is what stops a deployment script written for staging from emptying production's cache.

Practically it fits deployment pipelines — purge after a release, purge after a content import, purge a specific path when an editor reports stale content — and incident response, where clearing the cache is the first thing anyone tries. A `acquia_purge_varnish_test` submodule ships alongside for testing the integration.

Requires PHP 8.1. The permission `administer acquia purge varnish` is `restrict access: true`, correctly: a purge is an operation with real production consequences, not a settings change.

---

- Purge Varnish after a deployment.
- Clear cached pages after a content import.
- Purge a specific path reported as stale.
- Trigger a purge from a Drush command in CI.
- Purge one Acquia environment without touching others.
- Clear the cache during incident response.
- Give a release manager purge rights without full admin.
- Script cache invalidation into a release pipeline.
- Avoid purging production from a staging script.
- Confirm which environment a purge targets.
- Use a simpler alternative to the full Purge stack.
- Test the integration with the bundled test submodule.
- Review who may issue purges.
- Document purge steps in a runbook.
- Time a purge to avoid a traffic peak.