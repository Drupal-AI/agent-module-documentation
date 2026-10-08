# API: view-username access deciders

The one supported extension point. A **decider** answers a single question: may `$acting_user` see
`$other_user`'s username? Register your own to add site-specific rules (e.g. members of the same
group may see each other) on top of the default policy.

## The contract

`Drupal\view_usernames\Contracts\ViewUsernameAccessDeciderInterface`:

```php
public function canViewUserName(
  \Drupal\Core\Session\AccountInterface $acting_user,
  \Drupal\user\UserInterface $other_user,
): \Drupal\Core\Access\AccessResultAllowed|\Drupal\Core\Access\AccessResultForbidden;
```

Rules (enforced by design, per the README and interface docblock):

- The return MUST be **explicitly** `AccessResultAllowed` or `AccessResultForbidden` — never
  `neutral()`. Neutral means different things for entity vs. field access, so it is disallowed here.
- A decider MUST NOT read contextual state (current route, current request, `current_user`, …). It
  must decide only from the two arguments. (`current_user` is tolerated **only** to optimize
  cacheability, never to drive the decision — the acting user is passed in explicitly because it is
  not always the logged-in user.)
- Attach cacheability so results invalidate correctly. The default decider adds
  `user:<acting_uid>` and `config:user.role.<rid>` cache tags (mirroring
  `AccountPermissionsCacheContext`) to both its allow and forbid results.

## How the deciders are run

`view_usernames.services.yml` wires two pieces:

```yaml
view_usernames.view_username_access_decider:
  class: Drupal\view_usernames\ViewUsernameAccessDeciderCollector
  tags:
    - { name: service_id_collector, tag: view_username_access_decider, required: true }
  arguments: [ '@class_resolver' ]

view_usernames.view_username_access_decider.default:
  class: Drupal\view_usernames\DefaultViewUsernameAccessDecider
  tags:
    - { name: view_username_access_decider, priority: 1024 }
```

`ViewUsernameAccessDeciderCollector` (itself a `ViewUsernameAccessDeciderInterface`) is what the
enforcement hooks call. It iterates the collected decider service ids in **descending priority**,
resolves each through `class_resolver`, and calls `canViewUserName()`:

- the **first decider that returns allowed** short-circuits and its result is returned;
- if none allow, it returns `AccessResult::forbidden('No deciders granted access.')` merging the
  cache contexts, tags and max-ages of every forbid result it saw.

`required: true` means the collector asserts at least one decider exists (the default one always
does). Priorities: the default runs at **1024**; give a custom decider a **higher** priority to be
consulted first, or lower to run after the default. Because the first *allow* wins and the default
never allows for a stranger without permission, ordering between allow-granting deciders only matters
when more than one could allow.

## Add your own decider

```yaml
# mymodule.services.yml
mymodule.same_group_username_decider:
  class: Drupal\mymodule\SameGroupUsernameDecider
  tags:
    - { name: view_username_access_decider, priority: 512 }
```

```php
namespace Drupal\mymodule;

use Drupal\Core\Access\AccessResult;
use Drupal\Core\Access\AccessResultAllowed;
use Drupal\Core\Access\AccessResultForbidden;
use Drupal\Core\Session\AccountInterface;
use Drupal\user\UserInterface;
use Drupal\view_usernames\Contracts\ViewUsernameAccessDeciderInterface;

final class SameGroupUsernameDecider implements ViewUsernameAccessDeciderInterface {

  public function canViewUserName(AccountInterface $acting_user, UserInterface $other_user): AccessResultAllowed|AccessResultForbidden {
    // Decide only from the two arguments; attach cacheability.
    if ($this->shareGroup($acting_user, $other_user)) {
      return AccessResult::allowed()->addCacheTags(['user:' . $acting_user->id()]);
    }
    // Return forbidden (not neutral) so the collector can keep asking others.
    return AccessResult::forbidden()->addCacheTags(['user:' . $acting_user->id()]);
  }

}
```

A decider that returns forbidden does not block other deciders — the collector keeps going until one
allows or the list is exhausted. So a custom decider can only *widen* visibility beyond the default,
never tighten it below.

## Where a decision takes effect

The collector's result is applied wherever the module checks the `view label` operation on a user:
entity access, the `name` field's field access, the `#theme => 'username'` preprocess, and the
`getDisplayName()` format-name alter. See [../hooks/enforcement.md](../hooks/enforcement.md).
