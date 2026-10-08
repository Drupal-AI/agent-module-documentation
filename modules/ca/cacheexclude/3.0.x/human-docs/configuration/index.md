# Configuration

Cache Exclude has one settings form where you declare what should bypass the
anonymous page cache. Saving the form triggers a full cache flush so your rules
take effect immediately.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Cache exclusions**, or navigate directly to
   `/admin/config/system/cacheexclude`.

## Excluded paths

Enter Drupal paths to exclude, **one per line**, using internal paths (not
aliases — though aliases are matched too, see below):

- A plain path such as `contact` excludes exactly that page.
- A wildcard such as `blog/*` excludes every page under `blog/`.
- The token `<front>` matches the site's front page.

Both the current internal path **and** its URL alias are tested, so an aliased
page is excluded whichever form the visitor uses. The list is also compared against
the site's configured 404 page, so you can exclude that too.

Examples, one per line:

```
<front>
blog/*
contact
```

## Excluded content types

Below the path list, tick any **content types** you want to keep out of the page
cache. When a node of a ticked type is rendered, its response bypasses the page
cache regardless of its path — handy for a whole type like *Event* or *Offer* whose
pages are always time‑sensitive.

## Save

Click **Save configuration**. The module flushes all caches on save, so the new
rules are active right away. From then on, each matching request triggers Drupal's
core page‑cache kill switch and is not written to the anonymous page cache, while
the rest of the site keeps caching normally.

> **Scope note.** This affects the anonymous **page cache** only. It does not
> change the dynamic page cache or render‑cache behaviour — it simply prevents the
> whole‑page anonymous cache from storing the matched responses.
