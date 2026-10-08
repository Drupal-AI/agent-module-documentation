<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Grounded in `src/Form/JsonLdSettingsForm.php`, `jsonld.routing.yml`,
`config/install/jsonld.settings.yml`, and `config/schema/jsonld.schema.yml`.

Form route `system.jsonld_settings` at **`/admin/config/search/jsonld`**
(menu: *Configuration → Search and Metadata → JsonLD*), permission
`administer site configuration`. There is **no `configure` key** in `jsonld.info.yml`, so the
module page has no "Configure" link — reach the form via the menu or the path above.

Config object: **`jsonld.settings`** (two keys).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `remove_jsonld_format` | boolean | `false` | Form label *"Remove jsonld parameter from @ids"*. When `true`, generated `@id` URIs drop the `?_format=jsonld` suffix (`JsonldNormalizerUtils::getEntityUri()` respects this). |
| `rdf_namespaces` | sequence of `{prefix, namespace}` | `[]` | Extra RDF namespace prefixes, surfaced into core RDF's registry via `jsonld_rdf_namespaces()` so they appear in the `@context`. |

The RDF-namespaces textarea uses one `prefix|namespace` pair per line, e.g.
`schemaOrg|http://schema.org/`. A read-only textarea below it shows namespaces already provided
by other modules.

## Set via drush (no UI)

```bash
# Strip the ?_format=jsonld suffix from @id URIs
ddev drush config:set jsonld.settings remove_jsonld_format true -y

# Inspect current config
ddev drush config:get jsonld.settings
```

Setting `rdf_namespaces` (a sequence of maps) is easiest through the form or a config import;
each item is `{ prefix: <str>, namespace: <str> }`.
