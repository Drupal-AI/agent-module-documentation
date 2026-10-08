# Configuration

The `strip_tags_safe` filter works with sensible defaults out of the box, so the
settings page is **optional tuning**. It lets you keep certain HTML tags and rewrite
relative links, which is helpful when you index rendered HTML or feed content to an
external search system.

## Open the settings page

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Plain Search Index Filter settings**, or use the
   **Configure** link next to the module on the **Extend** page.

## Allowed HTML tags

By default `strip_tags_safe` removes all HTML tags. If you want to **preserve specific
tags** in the indexed output — for example semantic markup you still want to keep —
add them here. The interface lets you add multiple tags using an **"Add another tag"**
control, one tag per entry. Anything you list is left intact; everything else is
stripped as usual (with spacing preserved).

## Convert relative links to absolute URLs

Tick this option to have the filter rewrite relative URLs into absolute ones — it
converts `href="/path"` and `src="/path"` attributes so they include your full domain.
This is aimed at content that will be indexed by an **external** search system, where
relative paths would otherwise be meaningless. Leave it unticked if your index and
site share the same origin and relative links are fine.

## Save

Click **Save configuration**. The new settings apply the next time content is rendered
through the `strip_tags_safe` filter; clear the cache (`drush cr`) if you want to force
already-cached output to be rebuilt.
