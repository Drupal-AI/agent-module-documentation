# Extend — add a file-usage resolver

Before deleting a file, the module asks a **chained** resolver how many times the file is used;
if it is used elsewhere the file is kept. You can add your own usage source.

## The chain

- `media_file_delete.file_usage_resolver.chained` (`ChainedFileUsageResolver`) — the service the
  delete forms consume (injected as `media_file_delete.file_usage_resolver.chained`). It is a
  `service_collector` (`call: addFileUsageResolver`, collecting tag
  `media_file_delete_file_usage_resolver`) and **sums** the counts from every tagged resolver,
  highest priority first.
- `media_file_delete.file_usage_resolver.core` (`CoreFileUsageResolver`, priority `-100`) —
  wraps core `file.usage` (`listUsage()`), the default resolver.

## Interface

Implement `Drupal\media_file_delete\Usage\FileUsageResolverInterface`:

```php
public function getFileUsages(\Drupal\file\FileInterface $file): int;
```

Return the number of usages your subsystem knows about (0 = not used by you).

## Register it

Tag a service in your module's `*.services.yml`:

```yaml
services:
  my_module.file_usage:
    class: Drupal\my_module\MyFileUsageResolver
    tags:
      - { name: media_file_delete_file_usage_resolver }
```

Optionally add `priority: <int>` (default 0; core resolver is `-100`). Because counts are summed,
any resolver reporting a usage keeps the file. The `media_file_delete_entity_usage` submodule is
exactly such a resolver, wrapping the Entity Usage module.
