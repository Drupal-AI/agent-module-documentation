# Entity Usage resolver

This submodule contributes one tagged service into Media File Delete's usage-resolver chain.

`media_file_delete_entity_usage.file_usage` → `Drupal\media_file_delete_entity_usage\EntityUsageResolver`

- Constructor arg: `@entity_usage.usage` (`EntityUsageInterface`).
- Tag: `media_file_delete_file_usage_resolver` (no explicit priority → default `0`, so it runs
  ahead of the core resolver at `-100`; all counts are summed by `ChainedFileUsageResolver`).
- Implements `FileUsageResolverInterface::getFileUsages(FileInterface $file): int` as
  `count($this->entityUsage->listSources($file, FALSE))`.

Effect: when Media File Delete evaluates whether it may delete a file, this resolver adds the
number of sources Entity Usage records for that file. If Entity Usage reports any reference, the
total usage is `> 0`, so the file is retained. No configuration — enabling the submodule is all
that is required.
