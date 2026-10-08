# Configuration

Schema.org PublicationIssue has no settings form of its own. It adds a
**PublicationIssue** type to the Schema.org Metatag framework, and you configure it
from Metatag's settings screens by pointing each property at a value from your
content (typically a token such as `[node:title]`).

## Set up the PublicationIssue mapping

1. Log in as a user who can administer meta tags (an administrator by default).
2. Go to **Configuration → Search and metadata → Metatag → Settings**
   (`/admin/config/search/metatag/settings`).
3. Select the content type you want to describe and tick the **Schema.org:
   PublicationIssue** checkbox to make the fields available for that type.
4. Choose the entity type and bundle, then expand the **Schema.org:
   PublicationIssue** fieldset.
5. Fill in the field mappings you want to publish — for example the issue number,
   publication dates, and any related details — using tokens or fixed values.
6. Save the configuration.

## How to check the result

Visit a page of the configured content type and view its source (or run the URL
through Google's Rich Results Test). A JSON‑LD block in the `<head>` should now
contain a `PublicationIssue` entry populated with your mapped values.

Keep the mapped values accurate to the page — structured data should describe what
a visitor actually sees. The module grants no special access and stores nothing
beyond the mapping configuration.
