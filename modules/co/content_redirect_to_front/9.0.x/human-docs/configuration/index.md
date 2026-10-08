# Configuration

## Open the settings form

1. Log in as a user with the **Access content_redirect_to_front settings form**
   permission.
2. Navigate to `/admin/config/content/content_redirect_to_front_settings`.

The settings are saved to site configuration, so they export and deploy like any
other config.

## Fields

### Entities to redirect

A set of checkboxes listing every entity type. **Check a type** to redirect all of
its bundles' canonical pages to the front page by default. This is the main
switch: tick the content types whose standalone pages you don't want reachable.

### Bundle specific settings

For finer control, this section lets you tick **individual bundles** within an
entity type so only those redirect. The rule is: if a type is checked but no
specific bundle is ticked, **all** its bundles redirect; tick specific bundles to
narrow the redirect to just those.

### Message settings

Optionally show a **warning message** to users who hold the skip permission when
they view a page that would otherwise redirect. Enable the message and set its
text to explain, for example, that this page is normally redirected and is only
visible to them because of their role.

## Permissions

Set these under **People → Permissions** (`/admin/people/permissions`):

- **Skip redirecting to front for all content**
  (`skip redirecting to front for all content`) — users with this permission
  bypass the redirect entirely and see the canonical page (optionally with the
  warning message). Administrators typically have this; give it to editors who
  need to preview or manage the content directly. Anonymous users should **not**
  have it if you want the redirect to apply to visitors.
- **Access content_redirect_to_front settings form**
  (`access content_redirect_to_front form`) — grants access to the settings form
  itself.

## Save and clear caches

Click **Save configuration**. **You must clear caches** (`drush cr`, or
**Configuration → Development → Performance → Clear all caches**) after every
change to redirect settings — the redirect runs so early in the request that the
new configuration only takes effect once caches are rebuilt.
