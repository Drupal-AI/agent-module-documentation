# Hooks implemented

The module hooks into Simplenews mail rendering to inject the tracking pixel and
rewrite links, and alters Views data for its two entity types.

## `hook_mail_alter` (`simplenews_stats.module`)
Fires for `module == 'simplenews'` and `key in ['node','test']` (the legacy mail
path). Calls `simplenews_stats.mail` → `SimplenewsStatsMail::prepareMail($message)`.

## `hook_mailer_post_render` (`simplenews_stats.module`)
For Symfony Mailer: fires when the email type is `simplenews_newsletter` and subtype
is `node` or `test`. Calls `simplenews_stats.symfony_mail` →
`SimplenewsStatsMailSymfony::prepareMail($email)`.

Both `prepareMail()` implementations do the same three things via the shared
`SimplenewsStatsMailBase`:
1. **`addImageTracker()`** — appends an `<img>` whose `src` is
   `Url::fromRoute('simplenews_stats.hit_view', query: ['sstc' => $tag])` (absolute).
2. **`addTags()`** — `preg_replace_callback` over every `<a href="…">` in the body;
   `replaceLinksUrl()` classifies each URL:
   - external `http(s)://` → stored in `simplenews_stats_allowedlinks` (via
     `SimplenewsStatsAllowedLinks::add()` if not already present) and rewritten to
     `Url::fromRoute('simplenews_stats.hit_click', ['tag' => $tag, 'link' => $url])`;
   - `mailto:` → left untouched;
   - internal / root-relative → the `sstc` tag is added as a query param on the
     original URL (no click route).
3. **`logHitSent()`** — increments the issue's `total_emails` counter once per
   recipient (`SimplenewsStatsEngine::logHitSent()`).

The tag is `u{subscriber_id}nl{node_id}`; nothing is injected when the subscriber has
no id.

## `hook_views_data_alter` (`simplenews_stats.views.inc`)
Adds an `entity_associated` computed field + filter to both `simplenews_stats` and
`simplenews_stats_item`, and swaps the default filter plugin on
`simplenews_stats_item.title` → `simplenews_stats_action` and on
`simplenews_stats_item.uid` → `simplenews_stats_user`. See
[../views/views.md](../views/views.md).

## `hook_help`
Stub only (returns an empty string for the `simplenews_stats.stats_tab` route).
