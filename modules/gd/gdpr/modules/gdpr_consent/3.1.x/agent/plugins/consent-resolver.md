<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The ConsentUserResolver plugin type

A consent record sits on some entity (a user, a node, a profile, a webform submission…). A
**consent user resolver** answers "which user does this entity's consent belong to?", so the
module can attribute and list consent per user.

## Plugin type

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.gdpr_consent_resolver` (`ConsentUserResolverPluginManager`) |
| Interface | `Drupal\gdpr_consent\ConsentUserResolver\GdprConsentUserResolverInterface` |
| Annotation | `@GdprConsentUserResolver` (keys `id`, `label`, `entityType`) |
| Plugin namespace | `Plugin/Gdpr/ConsentUserResolver` |

Each resolver declares the `entityType` it handles and resolves an entity to its owning user.
The manager's `getDefinitionForType($entityType, $bundle)` finds the resolver for an entity
type/bundle; adding a `gdpr_user_consent` field to a bundle with **no** resolver fails
validation (`gdpr_consent_field_add_validation`).

## Built-in resolvers

| id | entityType | Resolves |
|---|---|---|
| `gdpr_consent_user_resolver` | `user` | the user itself |
| `gdpr_consent_node_resolver` | `node` | `$entity->uid->entity` (author) |
| `gdpr_consent_profile_resolver` | `profile` | `$entity->uid->entity` (owner) |

## Add a custom resolver

```php
namespace Drupal\my_module\Plugin\Gdpr\ConsentUserResolver;

use Drupal\gdpr_consent\ConsentUserResolver\GdprConsentUserResolver;

/**
 * @GdprConsentUserResolver(
 *   id = "my_thing_resolver",
 *   label = "My thing resolver",
 *   entityType = "my_thing"
 * )
 */
class MyThingResolver extends GdprConsentUserResolver {
  // resolve the owning user for a 'my_thing' entity
}
```

After enabling, `plugin.manager.gdpr_consent_resolver->getDefinitions()` includes it, and a
`gdpr_user_consent` field can be added to that entity type. No config is needed — discovery is
by class + annotation.
