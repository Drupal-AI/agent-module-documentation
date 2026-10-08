# Configuration

Two steps: store your PostHog API credentials securely with the Key module, then grant
the permission to the roles that should see the analytics.

## 1. Store your PostHog credentials with the Key module

Analyze PostHog reads its PostHog API credentials from a **Key** entity rather than from
plain configuration, which keeps the secret out of exported config. The recommended
pattern is an environment-variable backed key:

1. Put your PostHog project API key into an environment variable on the server (for
   example via your hosting provider's secrets, or — under DDEV —
   `ddev dotenv set .ddev/.env --posthog-api-key=<value>` followed by `ddev restart`).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and create a
   Key that reads from that environment variable, so Drupal never stores the secret in
   the database or in exported config.
3. Point Analyze PostHog at that Key in its settings.

Keeping the key env-backed means it is never committed to version control and never
leaves your infrastructure in an export.

## 2. Grant the viewing permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant **Access posthog
analytics** to the roles that should be able to see PostHog metrics in the Analyze
dashboard. Without this permission a user will not see the analytics display.

## Verify it worked

Open the Analyze report for a piece of content as a user who has the permission. You
should see PostHog pageviews, visitors, and sessions for that content. If nothing
appears, re-check that the Key is resolving to a valid PostHog API credential and that
the environment variable is present in the running container.
