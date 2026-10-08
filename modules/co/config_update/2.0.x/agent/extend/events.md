# config_update events

`ConfigReverter::import()` and `revert()` dispatch events so you can react to or alter the
operation. Event name constants live on `ConfigRevertInterface`.

| Constant | Value | Event class | When |
|---|---|---|---|
| `PRE_IMPORT` | `config_update.pre_import` | `ConfigPreRevertEvent` | before an import writes |
| `IMPORT` | `config_update.import` | `ConfigRevertEvent` | after a successful import |
| `PRE_REVERT` | `config_update.pre_revert` | `ConfigPreRevertEvent` | before a revert writes |
| `REVERT` | `config_update.revert` | `ConfigRevertEvent` | after a successful revert |

`ConfigRevertEvent`: `getType()`, `getName()`.

`ConfigPreRevertEvent` (mutable): `getType()`, `getName()`, `getActive()` (current active
value), `getValue()` and `setValue(array $value)` — modify the value that is about to be
written.

```php
class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [ConfigRevertInterface::PRE_REVERT => 'onPreRevert'];
  }
  public function onPreRevert(ConfigPreRevertEvent $event): void {
    if ($event->getType() === 'view') {
      $value = $event->getValue();
      // adjust $value before it is saved...
      $event->setValue($value);
    }
  }
}
```
