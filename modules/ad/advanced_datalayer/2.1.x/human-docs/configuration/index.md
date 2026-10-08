# Configuration

You configure Advanced Datalayer by assigning **values to tags, per page context**.
Remember the prerequisite from installation: the base module ships no tags, so enable
`example_advanced_datalayer` (or add your own tag plugins) first — otherwise the
screens below will have nothing to fill in.

## Open the Page variables screen

1. Log in as a user with the **Administer advanced datalayer defaults settings**
   permission.
2. Go to **Configuration → Search and metadata → Advanced Datalayer → Page
   variables** (`/admin/config/search/advanced-datalayer/page-variables`).

This lists the **page contexts** — each one a set of tag values that applies to a
particular kind of page:

| Context | Applies to |
|---------|------------|
| **Global** | Every supported page — merged into all the others. |
| **Front** | The front page. |
| **Node** | Node canonical pages. |
| **Taxonomy term** | Taxonomy term pages. |
| **403 / 404** | Access‑denied / not‑found pages. |
| **Login / Register** | The user login / registration pages. |
| **Pass** | The password‑reset page. |

Use the **Add**, **Edit**, and **Delete** actions to manage contexts, and the
**Settings** form for module‑wide options.

## Assign tag values

Edit a context (for example **Node**) and you'll see a field for each available tag.
Fill in the value you want that tag to have on that kind of page. A few examples:

- On **Global**, set a `siteName` tag to your site's name so it appears on every
  page.
- On **Node**, set a `pageName` tag to `[node:title]` and a `pageCategory` tag to
  `[node:field_category]`.
- On **404**, set a `responseCode` tag to `404` so analytics can see not‑found hits.

Save the context. Its values are stored as configuration, so they export and deploy
like the rest of your site config.

### Values and tokens

- **Values are strings that may contain tokens.** Tokens such as `[node:title]` or
  `[node:field_category]` are resolved at render time against the entity of the
  current page, so one tag can emit a different value on every node.
- **Translation.** A tag whose plugin is marked translatable is resolved in the
  current content language; otherwise it uses the site's default language.
- **Empty values.** A tag defined not to "show empty" is simply left out of the
  dataLayer when its resolved value is empty.
- **Ordering, required, global.** Whether a tag is always present, whether it may be
  empty, and its output order are properties of the tag *plugin*, not something you
  set here — they're chosen by whoever wrote the tag.

## Settings form

The **Settings** form (linked from the Page variables screen, at
`/admin/config/search/advanced-datalayer/page-variables/settings`) holds the
module‑wide options. It's reached from the same collection page and gated by the same
permission.

## Per‑entity values (the datalayer field)

As well as the context defaults, an individual entity can carry its **own** datalayer
tag values. The module provides an `advanced_datalayer` **field type** (with a widget
and formatter): add that field to a bundle, and editors can then set datalayer values
directly on the entity's edit form, layered on top of the context defaults.

## Permission

- **Administer advanced datalayer defaults settings** — gates every Page variables
  route (list, add, edit, delete) and the settings form. Grant it at **People →
  Permissions** to the roles that should manage datalayer configuration.

## For developers

Tags and groups are plugins, and the final datalayer array can be adjusted in code
before it's injected via `hook_advanced_datalayer_alter()` and
`hook_advanced_datalayer_attachments_alter()`. See the agent docs at
[`agent/plugins/tags-and-groups.md`](../agent/plugins/tags-and-groups.md),
[`agent/hooks/alter.md`](../agent/hooks/alter.md), and
[`agent/api/manager.md`](../agent/api/manager.md).
