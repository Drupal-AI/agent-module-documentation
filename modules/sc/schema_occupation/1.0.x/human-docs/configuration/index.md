# Configuration

Schema.org/Occupation has no settings form of its own. Instead it adds an
**Occupation** type to the Schema.org Metatag framework, and you configure it from
Metatag's normal settings screens. The idea is to point each Occupation property
at a value from your content — usually a token such as `[node:title]` — so the
JSON‑LD reflects what is actually on the page.

## Set up the Occupation mapping

1. Log in as a user who can administer meta tags (an administrator by default).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
3. Choose the entity type and bundle you want to describe — for example a
   "Job" or "Career" content type — either by editing an existing default meta
   tag configuration or adding a new one.
4. Expand the **Schema.org: Occupation** fieldset.
5. Fill in the Occupation fields you want to publish, mapping each to a token or
   fixed value drawn from the content (for instance the occupation name, the
   description, and any related details the vocabulary offers).
6. Save the configuration.

## How to check the result

Visit a page of the content type you configured and view its page source (or run
the URL through Google's Rich Results Test). You should find a JSON‑LD block in
the `<head>` containing an `Occupation` entry populated with your mapped values.

Because the markup is generated from your existing fields at render time, keep the
mapped values accurate to the page — structured data should describe what a
visitor actually sees. The module itself grants no special access and stores no
data beyond the mapping configuration.
