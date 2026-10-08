# Configuration

The settings page tells the module where your schemas live and how it should
behave when validation fails.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → System → JSON Schema Validator**, or navigate directly
   to `/admin/config/system/json_schema_validator`.

## Settings

- **Schema Domain.** The domain used for the `"$id"` of your JSON schemas. All of
  your schemas must share this domain — the module strips it (and the
  `.schema.json` suffix) from a schema's `"$id"` to derive the short schema name
  you pass to the validator.
- **Schema Directory Path.** The filesystem path to the directory that holds all
  your `.schema.json` files.
- **Validation Enabled** *(on by default).** A kill switch. When you turn it
  **off**:
  - `validateJsonSchema()` returns TRUE for any input without checking it;
  - `validateAndUseDefaultsWhenInvalid()` still applies the schema's defaults but
    skips the final validation pass;
  - `validateAndApplyDefaults()` instead fails closed and throws, because its
    strict guarantee can't hold without the validator running.

## Debug logging

When validation fails, the module logs the failure with the schema name, the user
ID, and the failing paths and schema‑derived reasons. **The data being validated is
not included** by default, and the thrown exception reports only the paths and
reasons. The same applies when invalid values are reset to defaults: each reset is
logged with its path and the applied default, but not the rejected value itself.

- **Enable Debug: log full payload on validation failure.** Turning this on
  *additionally* records the data being validated — the complete payload on a hard
  failure, and the rejected value on each reset‑to‑default.

  > **Leave this off in production.** That payload can contain sensitive values
  > (for example fields stored encrypted), and logging it in plaintext defeats
  > that protection.

## The three validation methods (for developers)

The `json_schema_validator.validator` service implements
`JsonSchemaValidatorInterface` with three methods:

- **`validateJsonSchema()`** — validates and throws on an invalid value. Use it
  when invalid input should be rejected.
- **`validateAndUseDefaultsWhenInvalid()`** — replaces every missing or invalid
  value with the schema's `"default"`, returning data guaranteed to validate. Use
  it to sanitize input rather than reject it.
- **`validateAndApplyDefaults()`** — fills missing values from the schema's
  `"default"` but leaves a present‑but‑invalid value in place so validation
  rejects it (strict). Use it where silently overwriting a wrong value would be
  unsafe.

## Save

Click **Save configuration** to apply your settings.
