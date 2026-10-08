# Configuration

W3C Validator has two places you interact with it: a small **settings form** where
you choose the endpoint and behaviour, and the **report** where you launch and
review validation runs.

## Who can configure it

All state-changing actions — editing the endpoint and launching a full
re-validation — require the restricted **Administer w3c_validator** permission.
The read-only report and its confirm step additionally accept core's **Access
site reports** permission, so you can let a wider group *view* results without
letting them change the endpoint.

## The settings form

Go to **Configuration → Development → W3C Validator**
(`/admin/config/development/w3c_validator`). It edits three settings:

### Validator URL

The endpoint the module submits pages to. **Leave it empty** to use the library's
default public service (`validator.nu`). To use your own instance, enter its URL,
for example `http://localhost/w3c-markup-validator`. Both the settings form and
the report warn you when the configured host is a known rate-limited public
service (`validator.nu`, `validator.w3.org`) — for any real volume, self-host.

### Validate as the current user (token)

**On by default.** When enabled, a validation run creates a short-lived token for
the current (admin) user and passes it with each page request, so the module's
authentication provider logs those fetches in as you. That lets the validator see
**access-restricted pages** as an editor would, rather than the anonymous view.
Turn it **off** to validate anonymously — i.e. to check exactly the markup the
public receives. The token exists only for the duration of a run and is revoked
when the batch finishes.

### Include admin/router pages

**Off by default.** When enabled, the page list also includes routed admin paths
(the non-argument, non-placeholder ones), not just the front page and nodes.
Leave it off unless you specifically want to validate back-end markup.

You can also set the token and admin-pages options directly on the report's
"advanced operations" form before a run; changing them there saves them back into
this configuration.

If you prefer the command line, the same settings are plain config values:

```bash
ddev drush config:set w3c_validator.settings validator_url 'http://localhost/w3c-markup-validator' -y
ddev drush config:set w3c_validator.settings use_token 1 -y
```

## Running a validation and reading the report

1. Go to **Reports → W3C Validator** (`/admin/reports/w3c_validator`).
2. The top of the page shows the advanced-operations form (endpoint reminder plus
   the token / admin-pages toggles); below it is a table of every page the module
   knows about — the front page and every node, plus router paths if you enabled
   admin pages.
3. Each row shows a colour-coded status — **Valid**, **Invalid**, **Outdated**
   (validated before the page changed), or **Unknown** (not yet validated) — and
   expands to reveal the specific error, warning and info messages with source
   extracts.
4. Choose **Re-validate all pages** to launch a batch. You'll be asked to confirm
   first (large runs can hit the validator hard), then the module walks each page,
   checks it is viewable by the chosen identity, fetches and validates it, and
   records the result.

Results are stored between runs, so the report always reflects the last validation
of each page until you re-run it.
