# Configuration

Hreflang works out of the box — everything on this page is **optional tuning**.
The form has just three settings, mostly about the `x-default` tag.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Search and metadata → Hreflang tags**, or navigate
   directly to `/admin/config/search/hreflang`.

Settings are stored in the `hreflang.settings` config object and export with
`drush config:export`. Changing any of them invalidates the response cache
immediately, so new settings take effect right away.

## Settings

- **Add x-default tag** (`x_default`, default **on**) — also emit an
  `hreflang="x-default"` tag pointing at your default language. The `x-default`
  tag tells search engines which URL to serve when none of the specific languages
  match the user; leaving it on is the usual recommendation.
- **Use fallback language for x-default** (`x_default_fallback`, default **on**) —
  when you've configured a fallback (selected) language under language
  negotiation, point the `x-default` tag at that fallback language instead of the
  site default. Only relevant if a fallback language is set.
- **Defer to Content Translation module** (`defer_to_content_translation`, default
  **off**) — on content-entity pages, let core's Content Translation module add
  the per-language tags and have Hreflang add only the `x-default` tag there.
  The trade-off: Content Translation does not add query arguments to its tags, so
  pages accessed with query strings won't get a complete tag set — but caching is
  more efficient because there's no separate cache entry per query-argument
  combination. Turn this on only if you specifically want Content Translation to
  own the per-language tags on entity pages.

## Save

Click **Save configuration**. Because the module invalidates the response cache on
save, reload any page and view its source to confirm the tags reflect your new
settings.
