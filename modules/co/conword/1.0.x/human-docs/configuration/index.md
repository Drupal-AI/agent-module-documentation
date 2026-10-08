# Configuration

Conword is inert until you connect it to your Conword account. Everything is done
from one settings form.

## Open the settings form

1. Log in as a user with the **`administer conword`** permission (grant it under
   Administration → People → Permissions to a trusted role).
2. Go to **Configuration → Web services → Conword**, or navigate directly to
   `/admin/config/services/conword`.

## Fields

- **Customer ID** — your valid Conword customer ID, issued by Conword GmbH under
  your contract. This is required for the integration to run. It is an account
  identifier (configuration), not a secret.
- **Display settings** — your individual display options for how the Conword
  integration appears and behaves in your content workflows. Set these to suit how
  your editors work with translation/collaboration.

Save the form when you are done.

## Data‑flow note

Because Conword exchanges content with an external DeepL‑based service, review what
content is sent for translation or collaborative editing and make sure that is
consistent with your privacy and data‑handling obligations. Keep any API
credentials as environment‑backed secrets rather than in exported configuration.
