# Configuration

Schema.org SoftwareApplication has no settings form of its own. It adds a
**SoftwareApplication** type to the Schema.org Metatag framework, and you configure
it from Metatag's settings screens by pointing each property at a value from your
content.

## Set up the SoftwareApplication mapping

1. Log in as a user who can administer meta tags (an administrator by default).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
3. Select the content type that represents your software — either by editing an
   existing default meta tag configuration or adding a new one for that entity type
   and bundle.
4. Expand the **Schema.org: SoftwareApplication** fieldset.
5. Fill in the fields you want to publish — for example the application name, the
   operating system, the price, and the rating — mapping each to a token or a fixed
   value from the content.
6. Save the configuration.

Because the module is not yet feature‑complete with the full Schema.org
vocabulary, you will find the most common properties here rather than every
possible one.

## How to check the result

Visit a page of the configured content type and view its source (or run the URL
through Google's Rich Results Test). A JSON‑LD block in the `<head>` should now
contain a `SoftwareApplication` entry populated with your mapped values.

Keep the mapped values accurate to the software described — structured data should
match what a visitor actually sees. The module grants no special access and stores
nothing beyond the mapping configuration.
