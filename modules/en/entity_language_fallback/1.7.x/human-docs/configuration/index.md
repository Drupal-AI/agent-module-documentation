# Configuration

There is no module settings page. You configure fallbacks **per language**, on that
language's edit form. (Editing languages already requires the *Administer
languages* permission, so there's no separate permission for this.)

## Set a fallback chain for a language

1. Go to **Configuration → Regional and language → Languages**
   (`/admin/config/regional/language`).
2. Click **Edit** on a language — say, French.
3. The module adds an **Entity fallback language** section to the form, with one
   **Priority N** select for each of the site's other languages.
4. Choose fallback languages **in priority order**: Priority 1 is tried first,
   then Priority 2, and so on. Leave a slot on **- None -** to skip it.
5. **Save.** Empty selections are filtered out, and the ordered list is stored on
   the language.

For example, on the French language you might set Priority 1 = Norwegian Bokmål,
Priority 2 = English. Now when an entity has no French translation, Drupal shows
the Norwegian one if it exists, otherwise the English one, before ever falling
back to the site default.

## When the fallback applies

The fallback chain kicks in when an entity is **viewed** or **upcast from a route**
and it has no translation in the requested language. For a translatable entity, the
order Drupal considers becomes: the requested language first, then each fallback
language you configured, in priority order (duplicates removed). Non-translatable
entities are untouched, and there is no on/off toggle beyond the per-language
selects themselves — configuring a chain *is* enabling it for that language.

Because the translation that actually renders can differ from the page's language,
the module re-checks entity access against the fallback translation, so core access
handlers (for nodes and so on) evaluate the version that's really shown.

## Search API (optional)

If the [Search API](https://www.drupal.org/project/search_api) module is enabled,
you also get a **fallback datasource** you can add to a search index. It indexes
fallback translations — so a piece of content that isn't translated into a given
language is still findable (and facetable) under that language — and keeps the index
up to date as entities are created, updated and deleted. If Search API isn't
installed, this part simply doesn't apply; the per-language fallback behaviour works
regardless.
