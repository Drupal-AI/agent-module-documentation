# Pager metadata — agent index

Automatic SEO for paginated pages: makes the canonical `<link>` carry the current `?page=N`, and
emits `rel="prev"`/`rel="next"` head links from core and Views Infinite Scroll pagers. No config UI
(`configure` null), no permissions, no Drush, no plugins, no config schema. Enable and it works.

- **Behavior, the three hooks, and the `settings.php` toggle** → [configure/behavior.md](configure/behavior.md)

Key facts:
- Enable: `drush en pager_metadata -y`. Nothing else to configure.
- Sets its own module weight to `1` on install so its preprocess runs after others.
- One tunable: `$settings['pager_metadata_alter_canonical']` (default `TRUE`) in `settings.php` —
  set `FALSE` to stop rewriting the canonical URL (rel prev/next still emitted).
- Works with core pagers, `views_infinite_scroll` pagers, and Views blocks (`views_block`).
