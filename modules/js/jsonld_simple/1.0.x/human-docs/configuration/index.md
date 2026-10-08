# Configuration

JSON-LD Simple is configured from one settings form. From there you decide which
content gets JSON-LD structured data and whether to emit breadcrumb schema. The
output is trusted-admin configuration, so access is limited by permission.

## Open the settings form

1. Log in as a user with the **Administer JSON-LD** permission (an administrator by
   default). Grant this permission only to trusted people, since it controls what
   structured data is emitted into every page head.
2. Go to **Configuration → Search and metadata → JSON-LD Simple**, or navigate
   directly to `/admin/config/search/jsonld-simple/settings`.

## What you can configure

- **Enable JSON-LD per content type** — turn the schema output on or off for any
  content type, so only the types you choose emit structured data.
- **Enable JSON-LD per node** — override the setting for an individual node, so a
  specific piece of content can opt in or out regardless of its content type's
  default.
- **Breadcrumb schema** — enable JSON-LD structured data for breadcrumbs, which
  helps search engines display your site's navigation hierarchy in results.

When enabled, the configured JSON-LD is emitted inside a
`<script type="application/ld+json">` tag in the affected pages' `<head>`.

## Save

Save the settings form to apply your choices. View a page that should carry schema
and check the page source for the `<script type="application/ld+json">` block to
confirm the output.
