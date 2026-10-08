# Configuration

Setting up SEO Urls is three steps: say which entity types are eligible, create
the mappings, then use the token in your metatags.

## 1. Choose eligible entity types

1. Log in as a user with the **Administer seo_url entities**
   (`administer seo_url entities`) permission — this is a restricted permission,
   so grant it only to trusted roles.
2. Go to **`/admin/structure/seo_url`** (the settings form, route
   `seo_url.settings`).
3. Set the **allowed content types** — only the entity types you tick here can
   have SEO URLs and expose the `seo-url` token.

## 2. Create your mappings

Manage the mappings at **`/admin/content/seo_url`** (which respects the
`view seo_url entities` / `view own seo_url entities` permissions).

To add one, go to **`/admin/seo_url/add`** and fill in two fields:

- **Canonical URL** — the real, parameterized path (for example
  `/catalog?color=red&type=shoes`), stored internally as an `internal:` link.
- **SEO URL** — the clean, readable path you want (for example
  `/products/red-shoes`).

A quicker route: open the target page in your browser and click **Create SEO
URL** in the admin toolbar — the canonical field is pre-filled from the current
page's redirect destination.

Each mapping has a **status** flag you can toggle on or off, and duplicate
mappings are blocked automatically by a uniqueness constraint. For editors, the
module provides granular `view`, `add`, `update`, and `delete` permissions in
both `any` and `own` variants, so you can let content authors manage their own SEO
URLs without giving them full administration.

## 3. Use the token in your metatags

1. Go to the Metatag settings (**`/admin/config/search/metatag`**).
2. Set the **canonical** tag to `[<entity_type>:seo-url]` — for example
   `[node:seo-url]`.

When the current page matches a mapping, the token resolves to your clean SEO URL;
when it does not, it falls back to the normal canonical URL. (Note the token name
is `seo-url` with a hyphen in this release — it was previously `seo_url`.)

## How resolution works, briefly

- **Inbound:** a request to an SEO path is rewritten back to the real canonical
  internal path, with the canonical query parameters re-added, so routing behaves
  normally.
- **Outbound:** links can be rendered in their SEO form; a leading `//` is
  collapsed to a single `/` to avoid accidentally producing a protocol-relative
  external URL.
- Enable the **`seo_urls_views`** submodule to also map Views page paths.
