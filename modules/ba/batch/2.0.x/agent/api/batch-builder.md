<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BatchBuilder & finish operations

Files: `src/Batch/BatchBuilder.php`, `src/Batch/Finish/FinishInterface.php`,
`src/Batch/Finish/FinishDefault.php`.

## BatchBuilder (`BatchBuilder.php`)

Extends core `\Drupal\Core\Batch\BatchBuilder`, so all core builder methods (`setTitle`,
`setInitMessage`, `toArray`, etc.) remain available. Adds two convenience methods:

- `addBatchOperation(OperationInterface $operation): self` — registers the operation's callback as
  `[$operation, 'process']` via core `addOperation()`. Pass an operation **object**, not a callable.
- `setFinishOperation(FinishInterface $finish): self` — registers `[$finish, 'finished']` via core
  `setFinishCallback()`.

## FinishInterface / FinishDefault

`FinishDefault` implements `FinishInterface` and runs when the batch completes.
- `setRedirectUrl(Url $url): self` — store a redirect target.
- `finished(bool $success, mixed $results, array $operations): ?RedirectResponse` — returns a
  `RedirectResponse` to the stored URL, or `NULL` if none set. Uses `MessengerTrait`,
  `StringTranslationTrait`, `DependencySerializationTrait`.

Extend `FinishDefault` to add completion behavior (call `parent::finished()` to keep the redirect):
```php
class MyFinish extends FinishDefault {
  public function finished(bool $success, mixed $results, array $operations): ?RedirectResponse {
    $this->messenger()->addStatus('Batch operation complete.');
    return parent::finished($success, $results, $operations);
  }
}
```

## Wiring and running a batch

```php
use Drupal\batch\Batch\BatchBuilder;
use Drupal\batch\Batch\Finish\FinishDefault;
use Drupal\Core\Url;

$batch = new BatchBuilder();
$batch->addBatchOperation(new MyOp($ids));
$batch->setFinishOperation((new FinishDefault())->setRedirectUrl(Url::fromRoute('<front>')));
batch_set($batch->toArray());   // from a form submit / controller
```

Run non-progressively under Drush:
```php
batch_set($batch->toArray());
$batch =& batch_get();
$batch['progressive'] = FALSE;
drush_backend_batch_process();
```

Add several operations to one builder to chain them. Operations and finish objects are serialized
between requests (via `DependencySerializationTrait`), so keep their state serializable.
