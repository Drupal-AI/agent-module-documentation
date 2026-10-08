# Configuration

LinkStash works out of the box once the module is enabled and permissions are
granted — **no additional configuration is required for basic use**. Everything
below is optional tuning.

## Module settings

Go to **Structure → LinkStash → Settings**
(`/admin/structure/linkstash/settings`) for the module's own settings. Adjust
these to suit how you want stashing and metadata fetching to behave, then save.

## Permissions

LinkStash is strictly per-user: each person manages only their own stash. Grant
the relevant permissions at **People → Permissions**
(`/admin/people/permissions`):

- **create linkstash** — save new bookmarks.
- **view own linkstash** — see your own saved links.
- **edit own linkstash** — update your own links.
- **delete own linkstash** — remove your own links.

## Tags and categories

LinkStash organises links with two taxonomy vocabularies you can curate:

- **Tags** — `/admin/structure/taxonomy/manage/linkstash_tags`.
- **Categories** — `/admin/structure/taxonomy/manage/linkstash_category`.

Auto-categorisation ships with built-in domain rules (Video, Code, Social,
Articles, Documentation) that file each saved link automatically. You can add or
adjust category terms here to fit your own taxonomy.

## Field display

Control how stashed links are rendered at
`/admin/structure/linkstash/display` — the standard Drupal *Manage display*
screen for the LinkStash entity, where you set which fields show and how (for
example the thumbnail, description, and video embed).

## The bookmarklet

Visit `/linkstash/bookmarklet` and drag the provided bookmarklet to your
browser's toolbar. Clicking it on any page saves that page to your stash in one
click, with popup and fallback support.

## Security notes

LinkStash fetches metadata by requesting the URLs you save, so it includes
**SSRF protection** — it blocks requests to private/RFC 1918 addresses — and
renders fetched content in an XSS-safe way. Keep this in mind if you operate
behind a proxy or need to reach internal hosts: such targets are intentionally
blocked.
