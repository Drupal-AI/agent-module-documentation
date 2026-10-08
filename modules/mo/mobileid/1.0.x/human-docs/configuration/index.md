# Configuration

Configuring Mobile ID means connecting Drupal to your Mobile ID service provider and
storing that provider's credentials safely. The authentication flow itself (the
JWKS endpoint and the live SSE stream that waits for the user to approve the login
on their phone) is handled by the module — your job is to supply valid provider
settings and keep the secrets out of your codebase.

## Set up the provider connection

As an administrator, open the module's settings and enter the details your Mobile ID
provider gave you — the service endpoint(s) and the credentials that identify your
site to the provider. Save, and the module can then start authentication flows for
users who enter their mobile number.

## Store credentials as secrets

Provider credentials must never be hard-coded or committed. With DDEV, save them as
environment variables and reference them from the module's settings (env-backed):

```bash
ddev dotenv set .ddev/.env --mobileid-client-secret=<value>
ddev restart
```

Confirm the variable is present in the container without printing its value:

```bash
ddev exec 'test -n "$MOBILEID_CLIENT_SECRET"'   # exit status 0 means it is set
```

## A note on the endpoints

The module publishes a **JWKS endpoint** whose keys are public *by design* — that is
expected and safe. The authentication **SSE stream** is keyed by an unguessable
per-request UUID, which is what lets the browser securely wait for the phone
approval. You don't configure these directly; they're mentioned so their presence
doesn't surprise you when reviewing the site's routes.

## Test the flow

Trigger a Mobile ID login: enter a mobile number, approve the prompt on the phone
(or enter the authorisation code), and confirm the user is signed in. Test a
declined/timed-out prompt too, and confirm it fails cleanly.
