<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the authorization service and profile grant/revoke

## Service `authorization.manager`

Class `Drupal\authorization\Service\AuthorizationService`
(interface `AuthorizationServiceInterface`). Constructed with `entity_type.manager` and the
`logger.channel.authorization` channel. It drives reconciliation for a user across profiles.

```php
$service = \Drupal::service('authorization.manager');   // AuthorizationServiceInterface
$service->setUser($account);                             // UserInterface
$service->setAllProfiles();                              // process every enabled profile (saves the user)
$responses = $service->getProcessedAuthorizations();     // AuthorizationResponse[]
```

Key methods:

| Method | Effect |
|---|---|
| `setUser(UserInterface $user)` / `getUser()` | set/get the account to act on (works on the provisional login user) |
| `setAllProfiles()` | fetch + process **all** enabled profiles; **saves** the account |
| `setIndividualProfile($profile_id)` | process one profile; **saves** the account |
| `queryIndividualProfile(string $profile_id)` | process one profile **without** saving (dry run) |
| `getProcessedAuthorizations()` | array of `AuthorizationResponse` from the last run |

The module itself calls `setUser()` + `setAllProfiles()` from `hook_user_login`
(`authorization.module`), so grants normally happen automatically at login. Call the service
directly only to force a re-sync outside login.

## Per-profile: `AuthorizationProfile::grantsAndRevokes()`

The heavy lifting lives on the config entity
(`Drupal\authorization\Entity\AuthorizationProfile`):

```php
$profile = \Drupal::entityTypeManager()->getStorage('authorization_profile')->load('ldap_to_roles');
$response = $profile->grantsAndRevokes($user, $user_save = FALSE);  // AuthorizationResponse
```

What it does: get the provider, fetch + sanitize proposals, then for each
`provider_mappings[i]` filter proposals and hand the survivors to the consumer's
`filterProposals()` using `consumer_mappings[i]`; grant each result via
`grantSingleAuthorization()` (creating targets first if `synchronization_actions.create_consumers`
is set). If `synchronization_actions.revoke_provider_provisioned` is set, it then calls the
consumer's `revokeGrants()` to strip previously granted targets that no longer apply. A
provider may throw `AuthorizationSkipAuthorization` to skip the profile for this user.

Other entity helpers: `getProvider()` / `getConsumer()` (instantiate the plugins),
`hasValidProvider()` / `hasValidConsumer()`, `getConsumerMappings()` / `getProviderMappings()`,
`checkConditions()` (enabled + both plugins resolve).

## No permissions, no Drush

The module declares no permissions of its own (admin routes require
`administer site configuration`) and ships no Drush commands. Build profiles as config
entities — see [configure/authorization.md](../configure/authorization.md).
