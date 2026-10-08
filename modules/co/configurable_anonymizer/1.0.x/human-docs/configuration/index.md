# Configuration

Configuring Configurable Anonymizer has two parts: deciding which fields hold
personal data and how each is scrubbed (done in the admin form), and running the
anonymization itself (done with Drush). Because this tool deletes real personal
data, read the safety notes below before you run anything.

## Open the configuration form

1. Log in as an administrator.
2. Go to **Configuration → Development → Anonymizer**, or navigate directly to
   `/admin/config/development/anonymizer`.

## Map fields to anonymizer plugins

On the form you configure anonymization **per entity type and bundle**: for each
entity type and bundle, choose which fields should be anonymized and which anonymizer
plugin handles each field. The available plugins include:

- **Default anonymizer** — uses Drupal core's
  `FieldItemListInterface::generateSampleItems()` to generate replacement sample data
  for the field.
- **UUID anonymizer** — replaces the value with a UUID, useful for fields that need a
  unique but meaningless value.
- **Custom anonymizers** — any plugins your project adds via the module's
  attribute-based plugin type, for field types that need specific handling.

Take care to list *every* field that holds personal data. A field you do not map keeps
its real values after a run — deciding what counts as PII is a data-protection
decision, so review the mapping against your actual privacy obligations.

## Run the anonymization

Anonymization is performed with the module's Drush command (run it after configuring
the field mapping):

```bash
drush anonymizer:run
```

This replaces the configured PII fields with anonymized values across the site.

## Safe workflow — read before running

Because the command overwrites real user data, the sequence matters:

1. **Never run it against production.** Run it only on a copied database.
2. **Run it immediately after a database sync and before anyone uses the copy**, so
   real data is never exposed on the lower environment. A typical pipeline pulls the
   production database down, runs `drush anonymizer:run`, and only then hands the
   environment over.
3. **Test the result.** Confirm the fields you expected to be scrubbed really are, and
   that nothing sensitive slipped through, before trusting the environment.

Treat the field configuration as part of your data-protection process rather than a
one-time setting — revisit it whenever new fields that could hold personal data are
added to the site.
