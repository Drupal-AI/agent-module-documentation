<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — Provider and Consumer types

Authorization defines **two** plugin types. A profile pairs one of each.

| Type | Annotation | Manager service | Discovery dir | Interface / base |
|---|---|---|---|---|
| Provider | `@AuthorizationProvider` | `plugin.manager.authorization.provider` | `Plugin/authorization/Provider` | `ProviderInterface` / `ProviderPluginBase` |
| Consumer | `@AuthorizationConsumer` | `plugin.manager.authorization.consumer` | `Plugin/authorization/Consumer` | `ConsumerInterface` / `ConsumerPluginBase` |

Both annotations (`src/Annotation/AuthorizationProvider.php`,
`AuthorizationConsumer.php`) carry just `id` and `label`. Both bases extend
`ConfigurableAuthorizationPluginBase` (a `PluginBase`), so plugins also implement a
configuration form and a per-mapping-row form.

## Provider plugin

A provider answers "what does the external identity source say about this user?" Key methods
(from `ProviderInterface` / `ProviderPluginBase`):

- `getProposals(UserInterface $user): array` — return raw proposals (e.g. the user's LDAP
  group DNs). Throw `AuthorizationSkipAuthorization` to abort this profile for the user.
- `sanitizeProposals(array $proposals): array` — normalise before matching.
- `filterProposals(array $proposals, array $provider_mapping): array` — keep the proposals
  that satisfy one provider mapping row (exact match or, if enabled, a regex).
- `buildConfigurationForm()` / `buildRowForm()` — provider settings + one mapping row's fields.

Providers are supplied by integration modules — the canonical one is `ldap_authorization`.
None ships in this project.

## Consumer plugin

A consumer answers "grant/revoke this Drupal-side target." Key methods
(`ConsumerInterface` / `ConsumerPluginBase`):

- `grantSingleAuthorization(UserInterface $user, $mapping, string $profile_id): void` — grant one target.
- `revokeGrants(UserInterface $user, array $context, string $profile_id): void` — revoke targets this module previously granted that no longer apply.
- `createConsumerTarget(string $mapping): void` — create the target if missing (guarded by
  `consumerTargetCreationAllowed()` / the `$allowConsumerTargetCreation` flag).
- `filterProposals(array $proposals, array $mapping): array` — map a matched proposal to the concrete target value.
- `buildConfigurationForm()` / `buildRowForm()` — consumer settings + one mapping row's fields.

The only bundled consumer is **`authorization_drupal_roles`** (grants Drupal roles) — see
[the submodule docs](../../../modules/authorization_drupal_roles/1.5.x/agent/start.md).

## Implementing your own

1. Put the class in `src/Plugin/authorization/Provider/` or `.../Consumer/` of your module.
2. Annotate with `@AuthorizationProvider` / `@AuthorizationConsumer` (`id`, `label`).
3. Extend `ProviderPluginBase` / `ConsumerPluginBase` and implement the methods above.
4. Add config schema for your plugin's config and mapping-row shape, keyed by plugin id:
   `authorization.provider.plugin.{id}`, `authorization.provider_mappings.plugin.{id}`
   (or the `consumer.*` equivalents). See
   `authorization_drupal_roles/config/schema/*.yml` for the minimal example.
5. Alter hooks `authorization_provider_info` / `authorization_consumer_info` let other
   modules tweak discovered definitions.
