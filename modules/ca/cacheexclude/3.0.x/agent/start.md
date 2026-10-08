# Cache Exclude — agent index

Excludes specific paths and content types from Drupal's anonymous **page cache** by
firing the core `page_cache_kill_switch` on matching requests. One admin form, one config
object, no permissions of its own. Depends on core `path_alias`.

- **Configure exclusions** (paths, wildcards, content types, config keys, how matching works, D7 migration) → [configure/cacheexclude.md](configure/cacheexclude.md)
- **Access control** (which core permission gates the form) → [permissions/cacheexclude.md](permissions/cacheexclude.md)
