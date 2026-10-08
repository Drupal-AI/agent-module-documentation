# Blog — services, helper function & hooks

Defined in `blog.services.yml` and `blog.module`. Blog exposes no plugin types and no
`blog.api.php` (it invites no hooks); it *implements* a few core hooks itself.

## Services

| Service id | Class | Purpose |
|---|---|---|
| `blog.lister` | `Drupal\blog\BlogLister` | Builds a user-blog title |
| `blog.breadcrumb` | `Drupal\blog\BlogBreadcrumbBuilder` | Breadcrumb builder (tagged, priority 100) |
| `blog.uninstall_validator` | `Drupal\blog\BlogUninstallValidator` | Blocks uninstall while posts exist |

### `blog.lister` (`BlogListerInterface`)

```php
$title = \Drupal::service('blog.lister')
  ->userBlogTitle($user); // $user is a \Drupal\user\UserInterface
// Returns TranslatableMarkup: "@username's blog"
```

Constructor args: `@current_user`, `@config.factory`. Also used by
`Drupal\blog\Controller\BlogController::userBlogTitle()` to title user blog pages.

### `blog.breadcrumb`

Applies on `entity.node.canonical` routes when the node bundle is `blog_post`, producing a
breadcrumb: **Home › Blogs (`/blog`) › {owner}'s blog (`/blog/{uid}`)**. Registered with
the `breadcrumb_builder` tag at priority 100.

### `blog.uninstall_validator`

Implements `ModuleUninstallValidatorInterface`; returns a blocking reason
("first delete all Blog Post content") whenever `blog_post_counter() != 0`, so the module
cannot be uninstalled while any blog posts remain.

## Helper function

```php
blog_post_counter($account = NULL): int
```

Returns the count of **published** (`status = 1`) `blog_post` nodes. Pass a user object to
scope the count to that author (`uid` condition); pass nothing for a site-wide total. Uses
an access-checked entity query.

## Hooks the module implements (behavior to expect)

- `hook_entity_extra_field_info()` — adds the hidden user display component
  `blog__personal_blog_link` ("Personal blog link").
- `hook_ENTITY_TYPE_view()` (`blog_user_view`) — when that component is enabled and the
  user can `create blog_post content`, adds a "View recent blog entries" link
  (`view.blog.blog_user_all`, param `arg_0` = uid) to the user profile.
- `hook_node_links_alter()` — on non-RSS `blog_post` views, adds an "{username}'s Blog"
  link (theme `links__node__blog`) to each post, linking to that author's blog page.
- `hook_help()` — help text on `help.page.blog`.

## Menu link plugin

`Drupal\blog\Plugin\Menu\MyBlogLink` (the "My blog" account-menu link) resolves at runtime
to `view.blog.blog_user_all` with `arg_0` = current uid for authenticated users, and to an
empty route for anonymous users. Cache context: `user`.
