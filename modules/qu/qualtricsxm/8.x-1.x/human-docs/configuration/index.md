# Configuration

QualtricsXM needs two things before it can do anything: a Qualtrics **API token**
and the Qualtrics **base URL** for your account. Everything below happens on the
settings form and in the permissions page.

## Open the settings form

1. Log in as a user with the **Administer QualtricsXM settings** permission (this
   permission is marked *restricted* — grant it only to trusted administrators).
2. Go to **Configuration → Content authoring → QualtricsXM**, or navigate directly
   to `/admin/config/content/qualtricsxm`.

## The fields

- **API token** — the token from your Qualtrics account that authorises Drupal to
  call the Qualtrics API. The module sends it server‑side in an `X-API-TOKEN`
  header; it is never written into the page markup. See "Store the token safely"
  below for the recommended way to hold this value.
- **Base URL** — the Qualtrics API/data‑centre URL for your account (your Qualtrics
  organisation has a specific data‑centre host). The module builds both its API
  calls and the embedded iframe `src` from this value, so it must match your
  account's region.

Click **Save configuration**. Then open
**Configuration → Content authoring → QualtricsXM → Surveys**
(`/admin/config/content/qualtricsxm/surveys`) to confirm the module can list your
surveys.

## Grant survey‑viewing access

Embedded surveys are served at `/qualtricsxm/survey/{survey_id}` and are gated by
the **Access QualtricsXM survey** permission. At **People → Permissions**
(`/admin/people/permissions`), grant this permission to whichever roles should be
able to view embedded surveys (for anonymous visitors, grant it to the *Anonymous
user* role).

## Store the token safely

The API token is a secret. Rather than pasting it straight into configuration where
it can end up in exported config or version control, prefer to keep it in an
environment variable and reference it through a **Key** entity.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --qualtrics-api-token=<your-token>
ddev restart
```

That makes the value available as the environment variable `QUALTRICS_API_TOKEN`
inside the container. Keep `.ddev/.env` out of version control. If the Key module
is not already enabled, add it (`ddev composer require drupal/key` and
`ddev drush en key -y`), then create a Key that reads the environment variable and
select that Key wherever the module or your deployment references the token.

## Egress note

QualtricsXM makes outbound HTTPS requests **only** to the base URL you configure —
there is no request‑driven fetch, so no server‑side request forgery surface. TLS
verification is left at Drupal's secure default. If your environment restricts
outbound traffic, allow egress to your Qualtrics data‑centre host so the survey
list and fetch calls can reach Qualtrics.
