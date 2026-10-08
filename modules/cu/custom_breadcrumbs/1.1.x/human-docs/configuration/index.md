# Configuration

There are two things to configure: the **global settings** (site-wide behavior that
wraps every trail) and the **individual breadcrumb trails** themselves. A single
permission, *Administer custom breadcrumbs*, governs both.

## Global settings

Go to **Configuration → User interface → Custom breadcrumbs**
(`/admin/config/user-interface/custom-breadcrumbs`). These options apply to every
trail the module builds and are stored in the `custom_breadcrumbs.settings` config
object:

| Setting | Default | What it does |
|---|---|---|
| **Home crumb** (`home`) | on | Prepend a "Home" crumb linking to the front page (skipped on the front page itself). |
| **Home crumb label** (`home_link`) | `Home` | The text of that Home crumb. |
| **Current page crumb** (`current_page`) | on | Append the current page's title as the final crumb. |
| **Link the current page** (`current_page_link`) | off | If on, the current-page crumb links to itself; otherwise it is plain text. |
| **Trim title length** (`trim_title`) | `0` | Maximum characters per crumb title; longer titles are truncated with an ellipsis. `0` means no trimming. |
| **Disable on admin pages** (`admin_pages_disable`) | off | If on, trails are not applied on admin routes. |
| **Site-wide** (`site_wide`) | off | If on, the module builds a breadcrumb on **every** route, not only where a trail matches. |

The Home and current-page crumbs are added *around* whatever crumbs your individual
trail defines.

```bash
drush config:set custom_breadcrumbs.settings home_link 'Start' -y
drush config:set custom_breadcrumbs.settings admin_pages_disable true -y
```

## Building a breadcrumb trail

Manage trails at **Structure → Custom breadcrumbs**
(`/admin/structure/custom-breadcrumbs`) and click **Add**. Each trail is a
configuration entity with these key fields:

- **Label** and **machine name** — how you identify the trail.
- **Status** — only enabled trails are used.
- **Type** — the heart of the matching:
  - **Content entity** — match by entity type and bundle (for example, all `node`
    entities of bundle `article`), optionally restricted to a language.
  - **Path** — match by one or more **path patterns**, where `*` is a wildcard and
    `<front>` means the front page. Tokens are allowed here too.
- **Breadcrumb paths** and **Breadcrumb titles** — two text areas, **one crumb per
  line**, paired up line by line. The first line of Paths goes with the first line of
  Titles, and so on.
- **Extra cache contexts** — optional, one per line (e.g. `url.query_args:search`)
  for cases like search-result breadcrumbs that vary by query string.

### Path and title syntax

Each crumb's **path** and **title** support **Token** replacement — `[node:title]`,
`[term:name]`, and so on — resolved against the matched content. A path line can
also be one of these special values:

- `<front>` — links the crumb to the front page.
- `<nolink>` — renders the crumb as text with no link (great for a section label).
- `<term_hierarchy:field_name>` — expands the named taxonomy term-reference field
  into its full parent-to-child hierarchy, each ancestor becoming its own linked
  crumb. The matched content must actually have that field.

A regular path must start with `/` (or with `[` for a token, or be one of the
special values above). Lines that resolve to an empty path or title are simply
skipped.

**Example** — a trail for Article nodes reading *Home › Blog › [the node's title]*:

- Type: **Content entity**, entity type `node`, bundle `article`.
- Paths: `/blog` on line one, `<nolink>` on line two.
- Titles: `Blog` on line one, `[node:title]` on line two.

### Showing a breadcrumb inside a teaser

The module also adds a **"Breadcrumbs" pseudo-field** to every entity's display
options (hidden by default). Enable it on a *Manage display* screen — for instance
the node teaser view mode — to render the computed breadcrumb inside the entity's
output, which is handy for showing breadcrumbs on node teasers in search results.

## Permission

One permission covers everything:

| Permission | Machine name | Gates |
|---|---|---|
| **Administer custom breadcrumbs** | `administer custom_breadcrumbs` | The global settings form and every breadcrumb-trail operation (list, add, edit, delete, enable/disable). |

```bash
drush role:perm:add site_builder 'administer custom_breadcrumbs'
```
