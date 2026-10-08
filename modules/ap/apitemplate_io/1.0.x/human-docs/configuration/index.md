# Configuration

The module needs your APITemplate.io endpoint and API key before it can generate
anything. Configuration is stored in the `apitemplate_io.settings` config object
and edited through an admin form.

## Open the settings form

1. Log in as a user with the **Administer APITemplate.io configuration**
   (`administer apitemplate_io configuration`) permission.
2. Go to **Configuration → System → APITemplate.io**, or navigate directly to
   `/admin/config/system/apitemplate-io`.

## Settings

- **API endpoint** — the APITemplate.io REST base URL (for example
  `https://rest.apitemplate.io`). Use the region-specific endpoint your account
  was issued if applicable.
- **API key** — the key from your APITemplate.io account. It is sent to the
  service in an `X-API-KEY` header over TLS. **See the note below about how it is
  stored.**
- **Default template ID** — the template used by `createPdf()` when a call does
  not name a template explicitly. Optional.

Save the form. You can then open the **Test Tool** (the module's test route) to
render a template with sample variables and preview the returned PDF before using
it in a real workflow.

## Keeping the API key out of version control

This module stores the API key as **plaintext in configuration** — it is a normal
text field, not a Key entity. That means the key will appear in any configuration
export. To avoid committing a secret:

- **Exclude** `apitemplate_io.settings` from public config exports, or
- Feed the key from an environment variable instead of typing it into the form.
  On this DDEV site, save it into the container environment
  (`ddev dotenv set .ddev/.env --apitemplate-api-key='<key>'`, then
  `ddev restart`) and override the config value from `settings.php` with
  `getenv('APITEMPLATE_API_KEY')`, so the real key never lands in exported config.

Never commit the API key to the repository.

## Using it from code

Other modules call the `apitemplate_io.client` service to do the work:
`createPdf()` to generate a PDF from a template, `mergePdfs()` to combine PDFs,
`listTemplates()` to list what is available, `deleteObject()` to remove a prior
transaction's object, and `serveFile()` to return a file as a download. Per-call
template variables are passed as the JSON body, and a request-scoped
`tempConfigOverride()` lets a single call override config values (used by the Test
Tool). Failures are logged to the `apitemplate_io` logger channel.
