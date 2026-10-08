Blog restores the classic multi-user blogging feature (formerly Drupal core) as a contrib module: enabling it installs a ready-made "Blog post" content type, a set of blog listing/feed Views, and per-user blog pages so every registered user gets a personal blog.

---

On install the module creates a `blog_post` node type (with a Body field, a Blog comments comment field, and an unlimited Blog tags taxonomy reference field) plus a View named `blog` that ships five displays: an aggregated "All blog posts" page at `/blog`, a per-user "All user blog posts" page at `/blog/{uid}`, a "Recent blog posts" block, and two RSS feeds at `/blog/feed` and `/blog/{uid}/feed`. Each user's posts are shown both in the site-wide listing and on their own blog page, and a "My blog" menu link is added to the account menu. Access is governed entirely by standard node bundle permissions (e.g. `create blog_post content`), so there is no dedicated settings form. A breadcrumb builder adds a Home › Blogs › {user}'s blog trail on blog post pages, `hook_node_links_alter` adds an "{username}'s Blog" link to each post, and an optional user-display component ("Personal blog link") can surface a "View recent blog entries" link on user profiles. The module also registers an uninstall validator that blocks uninstalling while any blog posts still exist. It exposes a small `blog.lister` service for building user-blog titles and a `blog_post_counter()` helper for counting published posts.

---

- Give every registered user a personal blog with zero custom content modelling
- Run a shared, multi-author blog where all users' posts aggregate into one `/blog` listing
- Add a journaling / news-updates section to a site using the prebuilt `blog_post` content type
- Provide per-user blog pages at `/blog/{uid}` without writing a custom View
- Publish an RSS feed of all blog posts at `/blog/feed` for syndication
- Publish a per-author RSS feed at `/blog/{uid}/feed`
- Place a "Recent blog posts" block in a sidebar or footer region
- Let authors tag posts with free taxonomy terms via the Blog tags field
- Enable threaded comments on posts out of the box via the Blog comments field
- Add a "Create new blog entry" action button on the blog listing pages
- Surface a "My blog" link in the user account menu for quick access to one's own posts
- Show a "View recent blog entries" link on user profiles by enabling the Personal blog link display component
- Give blog posts a Home › Blogs › author breadcrumb trail automatically
- Add an "{username}'s Blog" contextual link under each blog post
- Count published blog posts site-wide or for a single author with `blog_post_counter()`
- Build a "{username}'s blog" page title programmatically via the `blog.lister` service
- Prevent accidental data loss by blocking module uninstall while blog content exists
- Migrate away from Drupal 7/legacy core blogs onto a supported Drupal 10.4/11 module
- Seed a content type + Views layout that you can further customize instead of starting from scratch
- Restrict who can author posts by granting `create blog_post content` to specific roles only
- Let authors edit only their own posts using `edit own blog_post content`
- Theme blog listings by overriding the shipped `blog` View's displays
- Promote blog posts to the front page (default node behavior) for a blog-driven homepage
- Offer a simple team/status-update log where each member keeps their own thread
- Provide a lightweight alternative to full CMS blog platforms for small sites
- Expose blogs to feed readers and aggregators through the two RSS displays
