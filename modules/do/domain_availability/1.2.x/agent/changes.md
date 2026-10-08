<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Availability — what changed in 1.2.x

Branch **1.2.x**, release **1.2.0** (2026-08-17). This is a **Drupal 12 compatibility and forward-compat refactor release. There is no behavioural or public-API change** — the maintainer notes it was validated on Drupal 11.4.4, with Drupal 12 and Drupal 10.3 compatibility established by static analysis.

## Changed vs 1.1.x

- **Drupal 12 support.** `core_version_requirement` now reads `^10.3 || ^11 || ^12` (was `^10.3 || ^11`) on both the module and its test module; the Composer `drupal/core` / `drupal/core-dev` constraints accept `^12` too.
- **Status-report severities are version-bridged.** All three requirements checks — sockets, the DNS resolver, and WHOIS egress — now resolve their severity through `DeprecationHelper::backwardsCompatibleCall()`, so Drupal 11.2+ gets the `RequirementSeverity` enum while Drupal 10.3 keeps the `REQUIREMENT_*` constants. Applied in both the procedural `hook_requirements()` (`domain_availability.install`, marked `#[LegacyRequirementsHook]`) and the OOP `Hook\DomainAvailabilityRequirements`.
- **Registration modal dialog class.** The modal names its wrapper class through the dialog `classes` map (`['ui-dialog' => 'domain-availability-register-dialog']`) instead of jQuery UI's `dialogClass`, which Drupal 12 removes. Both the `OpenModalDialogCommand` call and the `data-dialog-options` payload on the results-list button were migrated; the rendered class — and therefore the existing CSS — is unchanged. A functional test asserts on the rendered attribute.
- **Twig function** is registered with a first-class callable.

## Unchanged

- No new `hook_update_N` — the last update hook is still `domain_availability_update_10005()` from 1.1.1. Upgrading from 1.1.x needs no database update.
- Routes, permissions, service ids, the `domain_availability_provider` / `domain_availability_pricing_strategy` tags, the entity type, config keys and the JSON response shape are all identical to 1.1.x.
- Providers, pricing subsystem, rate limiting, CORS handling and the registration workflow are behaviourally identical to 1.1.2.

## Upgrade

`composer require drupal/domain_availability` then `drush cr`. No configuration or API changes.
