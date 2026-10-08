# Configuration

Setting up Linked Data Lookup Field is a two-part job: first you **define an
endpoint** (where suggestions come from), then you **add a field** that uses it.

## Step 1 — Define a lookup endpoint

1. Go to **Structure → Linked Data Lookup Endpoint** and click **Add**.
2. Give the endpoint a label, then choose an **endpoint-type plugin** and fill in
   its settings:

   - **SparqlQuery** — for a SPARQL service (for example Wikidata). Set the
     `base_url` of the SPARQL endpoint; the text the editor types is sent as the
     query. Use `label_key` and `url_key` to pick which fields of the JSON result
     become the displayed label and the stored URI.
   - **LoCAuthority** — for the Library of Congress suggest API. Point `base_url`
     at the LoC authority you want to search.
   - **URLArgument** — for a generic JSON API. Set `base_url` (the typed argument
     is appended to it), a **result path** identifying where in the JSON the list
     of results sits, and the `label_key` / `url_key` for each result.

3. Save. Because endpoints are configuration entities, you can export them with
   the rest of your site config and deploy them to other environments. You can
   list, edit, and delete them again from the same **Structure → Linked Data
   Lookup Endpoint** page.

> **Tip:** when testing an endpoint's query, appending `?_ldquery_debug=1` to the
> autocomplete request surfaces debugging information about what the endpoint
> returned.

## Step 2 — Add a Linked Data field

1. Go to **Structure → *(your content type)* → Manage fields → Add field** and
   choose the **Linked Data** field type.
2. In the field settings, associate it with the endpoint you created so the
   widget knows which source to query.
3. On **Manage form display**, the autocomplete widget lets editors type and pick
   a match; the module stores the chosen label together with its URI.
4. On **Manage display**, render the stored value — by default it appears as a
   link to the authoritative source, or you can use a custom field formatter.

## Taxonomy autocomplete (v1.1)

Version 1.1 adds a taxonomy autocomplete controller and widget. Add a linked data
field to a taxonomy term so editors can either reference existing terms or create
new ones directly from the autocomplete, seeded from the external source.

## Security notes

- The autocomplete route (`/linked-data-lookup/{endpoint}`) is restricted to
  **authenticated users** — it is not exposed to anonymous visitors.
- The destination host is always the **admin-configured** endpoint `base_url`;
  an editor supplies only the query string, which keeps the server-side-request
  (SSRF) surface bounded. Still, only grant endpoint-management access to trusted
  administrators, since they choose which external hosts your site contacts.
- Outbound requests use Drupal's HTTP client (Guzzle) with normal TLS
  certificate verification.
