# Configuration

JSON‑LD has just two settings, and both are optional — the module produces valid
JSON‑LD without touching them. Most of what shapes the output lives in the
**RDF** module (the RDF mappings on your content types), not here.

## Open the settings form

The modules page shows no "Configure" link for JSON‑LD, so reach the form by its
menu path:

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Search and Metadata → JsonLD**, or navigate directly
   to `/admin/config/search/jsonld`.

Settings are stored in the `jsonld.settings` configuration object.

## Remove jsonld parameter from @ids

*(Checkbox — off by default.)*

By default, every `@id` URI in the generated document carries a `?_format=jsonld`
suffix (for example `https://example.com/node/1?_format=jsonld`). Tick this box
to strip that suffix so the `@id` values match your canonical resource URLs
(`https://example.com/node/1`). Turn it on if you want the Linked Data `@id`s to
be your clean, public URLs rather than format‑qualified ones.

You can also set this from the command line:

```bash
drush config:set jsonld.settings remove_jsonld_format true -y
```

## RDF namespaces

*(Text area — empty by default.)*

Register extra RDF namespace prefixes that should appear in the generated
`@context`. Enter one `prefix|namespace` pair per line, for example:

```
schemaOrg|http://schema.org/
```

A read‑only box below the field lists the namespaces already provided by other
modules (core RDF and any modules that implement `hook_rdf_namespaces()`), so you
can see what is already available before adding your own.

## Save

Click **Save configuration**. Because RDF mappings and namespaces are cached,
regenerate a document (in code or over HTTP) to see the change reflected in the
output.
