# pantheon_advanced_page_cache — agent start

Maps Drupal cache tags to Pantheon edge cache: emits `Surrogate-Key` headers and purges edge
keys on tag invalidation. No admin UI, no dependencies. Incompatible with `big_pipe`.

- Config keys (`surrogate_key_header_limit`, `override_list_tags`) → [configure/settings.md](configure/settings.md)
- How invalidation works (services, header, file/image clearing) → [api/services.md](api/services.md)
