# Deleting a managed file in code

The module defines **no public service or API of its own** (its only service is the internal
`FileDeleteHooks` hook object). What it does is codify a safe deletion recipe using core APIs —
the same one the form and action plugins use. Reproduce it in your own code:

## Safe delete (defer to cron) — the module's default

```php
/** @var \Drupal\file\FileUsage\FileUsageInterface $usage */
$usage = \Drupal::service('file.usage');
if ($usage->listUsage($file)) {
  // In use — refuse (this is the module's safeguard).
  return;
}
$file->setTemporary();   // Permanent -> Temporary
$file->save();           // file_cron() deletes temporary files on a later run
```

This is exactly what `MarkFileForDeletion::execute()` does.

## Immediate delete (skip cron)

```php
$file->delete();         // deletes the managed file entity + the file itself now
```

`FileDeleteForm` uses `$file->delete()` for the immediate case. The
`ImmediateDeleteWithUsageChecks` action instead deletes at the storage layer directly:

```php
if (\Drupal::service('file_system')->delete($file->getFileUri())) {
  \Drupal::database()->delete('file_managed')
    ->condition('fid', $file->id())
    ->execute();
}
```

## Force delete despite usage

Before deleting, clear the usage records so the file is no longer "in use":

```php
foreach ($usage->listUsage($file)['file'] ?? [] as $type => $entities) {
  foreach ($entities as $id => $count) {
    $usage->delete($file, 'file', $type, $id, $count);
  }
}
```

This removes usage rows only — the referencing entity/field may still point at the now-missing
file, which is the accepted trade-off of an override delete.

## Bulk / VBO

For mass deletions, use the two shipped `file`-type action plugins (`file_delete_mark_temporary`,
`file_delete_immediately`) rather than looping in custom code — see
[configure/file_delete.md](../configure/file_delete.md).
