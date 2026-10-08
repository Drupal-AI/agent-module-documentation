# Configuration

Metatag Search.gov does not add a settings page of its own — instead it adds three
custom fields to the Metatag module's configuration, which you fill in like any
other meta tag.

## Set the custom Search.gov tags

1. Log in as a user with permission to administer Metatag settings.
2. Go to the Metatag defaults form and open the **Search.gov** section — for the
   node defaults this is at
   `/admin/config/search/metatag/node#edit-search-gov`. (You can also add or edit
   these tags on any other Metatag default or on a per-entity Metatag field.)
3. Fill in the three fields — **`searchgov_custom1`**, **`searchgov_custom2`**, and
   **`searchgov_custom3`** — with the values Search.gov should use for its search
   filters. As elsewhere in Metatag, you can use **tokens** (for example
   `[node:field_topic]`) so the values are drawn from your content automatically.
4. Save the configuration.

Each field renders as a single Search.gov custom meta tag with comma-separated
values — the format Search.gov's faceted search expects — rather than as multiple
separate tags.

## Verify

View the source of a rendered page that matches the configuration and confirm the
`searchgov_custom1`/`2`/`3` meta tags appear in the document head with the values
you set.
