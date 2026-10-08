<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Usage (drush_batch_bar)

## Minimal
```php
use Drupal\drush_batch_bar\Batch\DrushBatchBar;
use Drupal\drush_batch_bar\Commands\DrushBatchCommands;

$batch = new DrushBatchCommands(
  operations: $batch_operations,       // standard Batch API operations array
  title: 'Title of your batch',
  finished: [DrushBatchBar::class, 'finished'],
);
$batch->execute();
```

## Custom batch class
Extend `DrushBatchBar` and define your operations, a process method (call `parent::initProcess($context);`), and a finish method. Override `SUCCESS_MESSAGE`/`ERROR_MESSAGE` constants for custom summaries.

## Example module
Enable `drush_batch_bar_example` and run `drush drush-batch-bar` (alias `dbb`) to see the progress bar and output patterns.

## Requirements
PHP >= 8.4, Drupal ^10.4 || ^11.1, Drush >= 12. No configuration or permissions.
