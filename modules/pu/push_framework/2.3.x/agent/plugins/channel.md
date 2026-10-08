# `PushFrameworkChannel` plugin type — write a delivery channel

A channel plugin renders a notification and delivers it over one transport (email, SMS, Slack, push,
webhook, …). The base module ships **no** concrete channel; each is its own contrib module. Bundled
example: the `eca_push_framework` submodule's derived `eca` channel.

- Discovery dir: `Plugin/PushFrameworkChannel`. Manager: `push_framework.channel.plugin.manager`
  (`ChannelPluginManager`, extends `DefaultPluginManager`).
- Interface: `Drupal\push_framework\ChannelPluginInterface`. Base class:
  `Drupal\push_framework\ChannelBase` (implements `ContainerFactoryPluginInterface`, injects
  `entity_type.manager`, `logger.channel.push_framework`, `renderer`, `token`, `event_dispatcher`,
  and both `push_framework.settings` and the plugin's own config).
- Annotation: `@ChannelPlugin` (`Drupal\push_framework\Annotation\ChannelPlugin`) — fields `id`,
  `title` (Translation), `description` (Translation). (Note: the settings form reads `label` from the
  definition; supply a translatable label so the channel-order and action UIs show a name.)
- Alter hook: **`hook_push_framework_channel_info(&$definitions)`**.
- Ordering: `ChannelPluginManager::getDefinitions()` sorts channels ascending by the config value
  `order_<plugin_id>` (default 1), set on the settings form. Lower = tried first.

## Interface contract

```php
// ChannelPluginInterface (extends PluginInspectionInterface)
public function getConfigName(): string;                  // e.g. "my_channel.settings"
public function isActive(): bool;                          // from <config>.get('active')
public function label(): string;
public function applicable(UserInterface $user): bool;    // does this channel fit this recipient?
public function send(UserInterface $user, ContentEntityInterface $entity,
                     array $content, int $attempt): string; // return a RESULT_STATUS_* constant
public function prepareContent(UserInterface $user, ContentEntityInterface $entity,
                     ?SourcePluginInterface $plugin = NULL, ?string $oid = NULL): array;
```

Result constants (`ChannelPluginInterface`): `RESULT_STATUS_SUCCESS = 'success'`,
`RESULT_STATUS_RETRY = 'retry'`, `RESULT_STATUS_FAILED = 'failed'`. Returning `retry` re-queues the
task (the Advanced Queue job re-fails with a 300s delay, max ~99 retries); `success` on a task with
`skip subsequent on success` stops the remaining channels for that item.

`ChannelBase` implements everything **except `applicable()` and `send()`** — those two are yours. Its
constructor is `final`; override `create()` only if you need extra services (call
`ChannelBase::create()` first). `getConfigName()` is abstract on the interface but you must return the
name of your channel's own config object (see below).

## Per-channel configuration

Each channel has its own config object named by `getConfigName()` (convention `<plugin_id>.settings`).
`ChannelBase::__construct` loads it as `$this->pluginConfig` and sets `$this->active` from its
`active` key. Content templates resolve per key in this order (`ChannelBase::getConfigValue()`):

1. the channel's own `<channel>.settings` value, unless empty or its `use_default_settings` is TRUE;
2. otherwise the global `push_framework.settings` value;
3. otherwise the hardcoded fallback.

Keys read while building content: `display_modes.<entity_type_id>` (fallback `push_framework`),
`pattern.subject` (fallback `[push-object:label]`), `pattern.body.value` (fallback
`[push-object:content]`), `pattern.body.format` (fallback `plain_text`). See
[../configure/settings.md](../configure/settings.md). The per-channel settings form is produced by
`Drupal\push_framework\Form\Settings` when pointed at your config name (add a menu/route in your own
module if you want a dedicated tab; the base module only registers the global `SettingsGeneral`).

## `prepareContent()` — what you receive in `send()`

`ChannelBase::prepareContent()` (final) returns an array **keyed by language code**; each entry is
`['subject' => string, 'body' => string|Markup, 'is html' => bool]`. It renders the entity with the
view builder (`renderInIsolation`) in the resolved display mode, converts to plain text when the body
format is not `plain_text`, then token-replaces the subject/body patterns with `['clear' => TRUE]`
against token data `user`, `push-object` (`label`, `content`), `push_framework_source_plugin`,
`push_framework_source_id`. HTML bodies are wrapped in `Markup`. During the build it dispatches the
four [channel events](../events/channel-events.md) so other modules can rewrite templates/output.

## Minimal skeleton

```php
namespace Drupal\my_channel\Plugin\PushFrameworkChannel;

use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\push_framework\ChannelBase;
use Drupal\push_framework\ChannelPluginInterface;
use Drupal\user\UserInterface;

/**
 * @ChannelPlugin(
 *   id = "my_channel",
 *   title = @Translation("My channel"),
 *   description = @Translation("Delivers over My transport."),
 * )
 */
class MyChannel extends ChannelBase {

  public function getConfigName(): string {
    return 'my_channel.settings';
  }

  public function applicable(UserInterface $user): bool {
    // TRUE if this user can/should receive on this transport
    // (e.g. has a stored device token / phone number).
    return !empty($user->getEmail());
  }

  public function send(UserInterface $user, ContentEntityInterface $entity, array $content, int $attempt): string {
    foreach ($content as $langcode => $message) {
      // $message['subject'], $message['body'], $message['is html']
      // ... deliver via your transport; on transient failure return RETRY ...
    }
    return ChannelPluginInterface::RESULT_STATUS_SUCCESS;
  }
}
```

Store transport credentials (API keys, tokens) in environment-backed **Key** entities or settings, not
in exported config. Clear caches after adding the plugin so the manager discovers it.
