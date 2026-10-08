# Configuration

Node Delete Redirect is configured on one settings form at
**Configuration → Content authoring → Node Delete Settings**
(`/admin/config/content/node-delete-settings`). You need the core **Administer
content types** permission to open it, so grant that at **People → Permissions**
(`/admin/people/permissions`) to any role that should manage the redirects.

## Set a redirect for a content type

The form lets you configure the post‑delete destination **per content type**:

1. **Enable redirect** — turn the feature on. When it's off, Drupal's default
   behavior applies and the user goes to the front page after a delete.
2. **Choose the content type(s)** where the custom redirect should apply. Content
   types you don't enable keep the default front‑page behavior.
3. **Redirect path** — enter the internal Drupal path the user should land on after
   deleting a node of that type (for example your news landing page or the content
   list). Because this destination is set here by an administrator and is not read
   from the incoming request, it is not an open‑redirect surface — but do make sure
   the path points somewhere editors expect to end up.

## Save and test

Click **Save configuration**, then delete a test node of the configured content
type. You should be redirected to the path you set rather than the front page. If you
land on the front page instead, re‑check that the redirect is enabled for that
specific content type and that the path is valid.
