<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `user_blocks` plugin type (ESI per-user content)

Advanced Varnish defines a plugin type for **per-user content fragments** delivered via ESI, so a
page can be cached anonymously while user-specific bits (name, cart count, notifications) are pulled
in dynamically.

## Discovery

`plugin.manager.user_blocks` (`UserBlocksManager extends DefaultPluginManager`):

- **Namespace:** `Plugin/UserBlocks` (i.e. `src/Plugin/UserBlocks/*` in any module).
- **Interface:** `Drupal\adv_varnish\UserBlocksInterface`.
- **Base class:** `Drupal\adv_varnish\UserBlockBase`.
- **Attribute:** `Drupal\adv_varnish\Attribute\UserBlocks` (also legacy annotation
  `Drupal\adv_varnish\Annotation\UserBlocks`).
- **Alter hook:** `hook_adv_varnish_user_blocks_info` (cache id `adv_varnish_user_blocks`).

The manager's `getUserBlockData()` instantiates every plugin and merges each plugin's `userBlockData()`
return (`content`, `js_settings`, `tags`) into the combined per-user payload rendered into the ESI
user-blocks response.

## Implement a plugin

Create `src/Plugin/UserBlocks/MyUserBlock.php` in your module:

```php
namespace Drupal\my_module\Plugin\UserBlocks;

use Drupal\adv_varnish\Attribute\UserBlocks;
use Drupal\adv_varnish\UserBlockBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[UserBlocks(
  id: 'my_user_greeting',
  label: new TranslatableMarkup('User greeting'),
)]
class MyUserBlock extends UserBlockBase {

  public function userBlockData() {
    $user = \Drupal::currentUser();
    return [
      // Keyed render/markup fragments merged into the ESI payload.
      'content' => ['my_user_greeting' => 'Hello ' . $user->getDisplayName()],
      // JS settings exposed to the client for these blocks.
      'js_settings' => ['my_user_greeting' => ['uid' => $user->id()]],
      // Cache tags for this fragment.
      'tags' => ['user:' . $user->id()],
    ];
  }
}
```

`userBlockData()` must return an array with `content`, `js_settings`, and `tags` keys (each an
array); the base `UserBlockBase::userBlockData()` returns `[]` (contributes nothing). The plugin's
`create()`/constructor follow the standard `ContainerFactoryPluginInterface` pattern, so you can
inject services.

## How it is served

The merged data is exposed through the ESI route `/adv_varnish/esi/user_blocks/{block_id}`
(`UserBlocksController`, `no_cache: TRUE`). With `available.esi` on, Varnish caches the outer page and
resolves this fragment per user; enabling `available.esi_purge_user_blocks` purges the `user:id` tag
on POST so a user's blocks refresh after they act.
