# How External Hreflang works

## The Metatag tag plugin

`Drupal\external_hreflang\Plugin\metatag\Tag\ExternalHreflang` (extends Metatag's `LinkRelBase`):

```
@MetatagTag(
  id = "hreflang_external",
  label = "External Hreflang",
  name = "hreflang_external",
  group = "advanced",
  type = "string",
  multiple = TRUE,
  secure = FALSE,
)
```

- `form()` renders a textarea with an `element_validate` of `validateTag()`.
- `name()` returns `'hreflang'` (the emitted attribute name is `hreflang`, though the tag id is
  `hreflang_external`).
- `getHrefLangsArrayFromString($value)` splits the textarea on newlines and each line on `|`,
  returning `['<code>' => '<url>', …]`; a line that is not exactly two `|`-separated parts throws,
  which `validateTag()` turns into a form error.
- `output()` iterates that array and returns one render element per alternate:
  `#tag: link`, `#attributes: {rel: alternate, hreflang: <code>, href: <url>}`.

Because it extends `LinkRelBase`/Metatag, its value is stored and edited entirely through
Metatag — there is no separate storage. See `configure/metatag.md`.

## Simple XML Sitemap integration

`external_hreflang_simple_sitemap_links_alter(&$links)` (in `external_hreflang.module`) runs when
the Simple XML Sitemap module dispatches its links-alter hook. For each sitemap link it loads the
applicable metatag defaults (`global`, then entity-type, then bundle via
`_external_hreflang_get_metatags()`), parses `hreflang_external`, processes any
`[current-page:url:relative:<lang>]` tokens against each site language, and adds the results to
`$link['alternate_urls']`. So the same external alternates also appear in the XML sitemap.

## Services

The only service is `external_hreflang.get_url_event_subscriber`
(`ExternalHreflangGetCurrentUrlEventSubscriber`), which answers the module's internal
`ExternalHreflangGetCurrentUrlEvent` with the current request URL (front page → `<front>`). There
is no public API you would normally call; configure the tag through Metatag instead.
