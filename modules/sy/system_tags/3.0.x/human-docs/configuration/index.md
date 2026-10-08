# Configuration

System Tags has no single settings form. "Configuring" it means three things:
managing the tags, attaching a reference field so you can tag content, and (where
relevant) setting up the block-visibility condition. This page walks through each,
then the permissions.

## 1. Manage tags

1. Log in as a user with **Administer system tags**.
2. Go to **Structure → System Tags** (`/admin/structure/system_tags`).

Here you create, edit, and delete tags. A tag is just a **machine name** (the
stable identifier you reference in code, e.g. `news_overview`) plus a human
**label**. Three tags exist out of the box — `homepage`, `access_denied`, and
`page_not_found` — and you can add your own for any well-known page your site or
integrations need to reference (`search_page`, `terms_of_service`, and so on).

## 2. Add a "System Tag" field so you can tag content

Tags do nothing until content points at them. To make a content type taggable:

1. Go to the content type's **Manage fields** and **Add field**.
2. Choose a **Reference → Other…** / entity-reference field whose target type is
   **System Tag**.
3. Give it a name (for example `field_page_system_tag`) and save.

You can add such a field to as many bundles and entity types as you like; System
Tags automatically discovers every field that targets the System Tag type, so a
single tag can be resolved across multiple content types. Then edit an entity and
set its tag.

## 3. The three special pages

When a **node** carries one of these three tags, System Tags overrides
`system.site` automatically:

| Tag | Effect |
|-----|--------|
| `homepage` | That node becomes the site's **front page** — no need to set a front-page path. |
| `page_not_found` | That node becomes the **404 (page not found)** page. |
| `access_denied` | That node becomes the **403 (access denied)** page. |

So to change your homepage, you simply move the `homepage` tag to a different node
— handy for keeping these references portable across dev/stage/prod. (Only nodes
drive these three overrides.)

## 4. Block-visibility condition

The module provides a **System Tags** condition you can use in any block's
visibility settings. Configure it with one or more tags, and the block shows only
on pages whose entity carries a matching tag — for example, show a "Related news"
block only on the page tagged `news_overview`. (With no tags selected and not
negated, the condition is always true.)

## 5. Using tags in Twig and tokens

These don't need configuration — they're available once the module is enabled:

- **Twig:** `{{ system_tag_url('homepage') }}` returns the tagged entity's URL
  (defaults to node; pass an entity type as the second argument for others). It
  returns `'#'` if nothing is tagged.
- **Tokens:** `[system_tags:ENTITY_TYPE--TAG_ID]` (e.g. `[system_tags:node--homepage]`)
  resolves to the tagged entity's **aliased path**. Useful in Pathauto patterns,
  metatags, and mail bodies.

See the [`agent/` tokens-and-twig docs](../agent/api/tokens-and-twig.md) for the
programmatic finder API.

## Permissions

Grant these at **People → Permissions** (none is marked security-restricted, but
read the note below):

- **Administer system tags** — create, edit, and delete tags.
- **View system tags** — view tags, and see the value of System Tag reference
  fields.
- **Assign system tags** — set/change a System Tag reference field on content
  (i.e. who may actually tag content).

> **Note on impact:** *Assign system tags* lets a holder move the `homepage`,
> `access_denied`, or `page_not_found` tags, which changes the site's front, 403,
> and 404 pages. It still requires edit access to a node that carries such a field,
> but grant it with the same care you'd apply to front-page configuration. Field
> access is enforced: even a user who can edit a node cannot see or set its System
> Tag field without the respective *view*/*assign* permission.
