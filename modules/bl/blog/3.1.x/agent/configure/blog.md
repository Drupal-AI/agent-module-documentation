# Blog — content model, Views, routes & permissions

The Blog module has **no settings form** (`configure` is `null`; the module ships no
`*.routing.yml` and no `*.permissions.yml`). Everything is delivered as default config
installed with the module. To turn it on: `drush en blog -y`.

## `blog_post` content type

Created from `config/install/node.type.blog_post.yml`:

- Machine name `blog_post`, label **Blog post**.
- `preview_mode: 1` (optional preview), `new_revision: false`, `display_submitted: true`.
- Promoted to front page uses core node defaults (blog posts appear on the front page).
- Config is `enforced` by module `blog`, so it is removed on uninstall.

Fields added to the bundle:

| Field | Machine name | Type | Notes |
|---|---|---|---|
| Body | `body` | text_with_summary | standard node body |
| Blog comments | `field_blog_comments` | comment | comment_type `comment`, cardinality 1 |
| Blog tags | `field_blog_tags` | entity_reference → taxonomy_term | cardinality -1 (unlimited) |

Form and view displays are installed for default and teaser view modes.

## The `blog` View and its routes

Installed from `config/install/views.view.blog.yml` (View id `blog`). Displays and their
**verified** routes/paths:

| Display id | Type | Route name | Path | Purpose |
|---|---|---|---|---|
| `blog_all` | page | `view.blog.blog_all` | `/blog` | All blog posts (site-wide) |
| `blog_user_all` | page | `view.blog.blog_user_all` | `/blog/{arg_0}` | One user's posts (`arg_0` = uid) |
| `blog_block` | block | (block plugin) | — | "Recent blog posts" block |
| `feed_1` | feed | `view.blog.feed_1` | `/blog/feed` | RSS of all posts |
| `feed_2` | feed | `view.blog.feed_2` | `/blog/{arg_0}/feed` | RSS of one user's posts |

Note the per-user route parameter is named `arg_0` (a uid), used by
`Url::fromRoute('view.blog.blog_user_all', ['arg_0' => $uid])`.

## Menu & action links

- **Account menu:** a "My blog" link (`blog.myblog_link`, plugin
  `Drupal\blog\Plugin\Menu\MyBlogLink`) pointing at the current user's
  `view.blog.blog_user_all` page; hidden for anonymous users.
- **Action buttons:** "Create new blog entry" (→ `node.add` for `blog_post`) appears on
  the `blog_all` and `blog_user_all` View pages (`blog.links.action.yml`).

## Enabling the "Recent blog posts" block

The block is not placed automatically. Place the `views_block:blog-blog_block` block in a
region via **Admin › Structure › Block layout** (`/admin/structure/block`) or with config.

## Showing the personal-blog link on user profiles

`hook_entity_extra_field_info()` registers a user display component
`blog__personal_blog_link` ("Personal blog link"), **not visible by default**. Enable it on
**Admin › Configuration › People › Account settings › Manage display**
(`/admin/config/people/accounts/display`) to show a "View recent blog entries" link on the
profile of any user who can create blog posts.

## Permissions

Blog defines **no permissions of its own**. Access is controlled by the standard node
bundle permissions generated for `blog_post`, e.g.:

- `create blog_post content`
- `edit own blog_post content` / `edit any blog_post content`
- `delete own blog_post content` / `delete any blog_post content`
- `access content` (to view listings/posts)

The personal-blog link and profile component are only shown to users who hold
`create blog_post content`.
