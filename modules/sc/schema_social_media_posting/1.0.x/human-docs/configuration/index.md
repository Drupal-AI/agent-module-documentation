# Configuration

Schema.org SocialMediaPosting has no settings form of its own. It adds the
SocialMediaPosting family of types to the Schema.org Metatag framework, and you
configure them from Metatag's settings screens by mapping each property to a value
from your content.

## Set up the SocialMediaPosting mapping

1. Log in as a user who can administer meta tags (an administrator by default).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
3. Click **Add default meta tags** (or edit an existing configuration) and select
   the entity type and bundle you want to describe.
4. Expand the **Schema.org: SocialMediaPosting** fieldset.
5. Fill in the field mappings you want to publish, drawing each value from a token
   or a fixed value on the content.
6. Save the configuration.

## Configuring LiveBlogPosting

If you enabled the `schema_live_blog_posting` submodule (see
[Installation](../installation/index.md)), follow the same steps but expand the
**Schema.org: LiveBlogPosting** fieldset instead, and fill in its mappings.

## How to check the result

Visit a page of the configured content type and view its source (or run the URL
through Google's Rich Results Test). A JSON‑LD block in the `<head>` should now
contain the type you configured, populated with your mapped values.

Because the markup reflects your existing content at render time, keep the mapped
values accurate to the page. The module grants no special access and stores
nothing beyond the mapping configuration.
