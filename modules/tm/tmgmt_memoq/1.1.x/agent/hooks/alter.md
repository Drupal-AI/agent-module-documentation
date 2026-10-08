# tmgmt_memoq alter hooks

Declared in `tmgmt_memoq.api.php`. Both fire in `MemoQTranslator::requestTranslation()` just before the
corresponding payload is POSTed to memoQ, so you can enrich order/job metadata.

## `hook_tmgmt_memoq_order_info_alter(array &$order, JobInterface $job)`

Alter the memoQ **order** payload (fields like `Name`, `Status`, `Deadline`) before `POST orders`.

```php
function my_module_tmgmt_memoq_order_info_alter(array &$order, \Drupal\tmgmt\JobInterface $job): void {
  $words = 0;
  foreach ($job->getItems() as $item) {
    $words += $item->getWordCount();
  }
  $order['Name'] .= ' (' . $words . ' words)';
}
```

## `hook_tmgmt_memoq_job_info_alter(array &$translation_job, JobItemInterface $job_item)`

Alter each memoQ **job** payload (`Name`, `Url`, `SourceLang`, `TargetLang`, `FileType`) before
`POST orders/{OrderId}/jobs`.

```php
function my_module_tmgmt_memoq_job_info_alter(array &$translation_job, \Drupal\tmgmt\JobItemInterface $job_item): void {
  $owner = $job_item->getJob()->getOwner()->getDisplayName();
  $translation_job['Name'] = $owner . ' ' . $translation_job['Name'];
}
```

The module provides no hooks of its own beyond these two. There is no plugin type to implement (it is
itself a `tmgmt` translator plugin); to change behaviour further, decorate/subclass `MemoQTranslator`.
