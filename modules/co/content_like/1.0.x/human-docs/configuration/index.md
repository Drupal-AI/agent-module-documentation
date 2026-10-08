# Configuration

Content Like does nothing visible until you tell it which content should carry the
like widget. That single decision is what this settings page is for.

## Open the settings form

1. Log in as a user with the **Administer content like settings** permission (an
   administrator by default). You can grant this permission to other roles at
   **People → Permissions**.
2. Go to **Configuration → Content authoring → Content Like**, or navigate directly
   to `/admin/config/content/content-like`.

## Choose where likes appear

The form lists your site's **content types** and **custom block types** as
checkboxes:

- **Tick a bundle** to enable the like widget on it. The widget will then be shown
  whenever an entity of that type is rendered.
- **Leave a bundle unticked** to keep the like widget off that type.

For example, tick *Article* and *Blog post* to collect likes on your editorial
content while leaving structural content types alone.

Click **Save configuration** when you're done. The change takes effect
immediately.

## How likes are counted

- **Logged-in users** are tracked by their Drupal user ID, so a given user can
  like a given item only once.
- **Anonymous visitors** are tracked with a browser cookie named
  `content_like_anon_id`. The module stores a *hash* of that anonymous ID rather
  than the raw cookie value, and uses it to prevent repeat likes from the same
  browser.

Because anonymous liking is allowed and cookie tracking is best-effort, treat like
counts as a general engagement signal rather than an exact figure.

## Printing the widget in a custom template

If your theme renders the full content render array (the usual `{{ content }}` in a
template), the like widget appears automatically on enabled bundles — no template
changes needed.

If your theme prints fields individually in a custom Twig template, add the widget
where you want it with:

```twig
{% if content.content_like is defined %}
  {{ content.content_like }}
{% endif %}
```

The module uses a lazy builder to render the widget, which helps keep the
liked/unliked state accurate even when pages are cached.
