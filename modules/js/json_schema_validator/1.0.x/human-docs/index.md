# JSON Schema Validator — manual setup guide

**JSON Schema Validator** (`json_schema_validator`) integrates the Opis JSON
Schema library with Drupal so you can validate JSON (and YAML) against modern JSON
Schema drafts — draft‑06, draft‑07, 2019‑09, and 2020‑12. It's particularly handy
for validating the contents of JSON fields, or any JSON your code handles, against
a schema you define.

This module is aimed squarely at **developers**. It ships no schemas of its own —
you create your JSON schema files, point the module at them, and then call its
validation service from your own custom module. If you only use older JSON Schema
versions you may not need this module at all: Drupal core and Composer already
include `justinrainbow/json-schema`. Reach for this module specifically when you
want Opis and support for the more recent drafts (draft‑06 and newer).

The validator service offers three methods, so you can choose how strict to be:
reject invalid input outright, sanitize it by replacing invalid values with the
schema's defaults, or a strict middle ground that fills in missing values but
still rejects a present‑but‑invalid one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add your schema
   files, and enable it.
2. [Configuration](configuration/index.md) — pointing the module at your schemas,
   the kill switch, and debug logging.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → JSON Schema
Validator** (`/admin/config/system/json_schema_validator`).

## How developers use it

Call the `json_schema_validator.validator` service (which implements
`JsonSchemaValidatorInterface`) with your data encoded as a JSON string and the
name of your schema:

```php
$encoded_json = json_encode($data_to_validate);
\Drupal::service('json_schema_validator.validator')
  ->validateJsonSchema($encoded_json, 'my-defined-json-schema');
```

The schema name is the schema's `"$id"` with the domain and the `.schema.json`
suffix removed.
