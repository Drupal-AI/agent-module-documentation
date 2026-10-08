# Configuration

## Open the settings form

1. Log in as a user with the **Administer psa_oecd_publishing**
   (`administer psa_oecd_publishing`) permission.
2. Go to **Configuration → Web services → OECD GlobalRecalls API**, or navigate
   directly to `/admin/config/services/psa-oecd-publishing`.

## The settings

- **API key** — your OECD GlobalRecalls key. It is sent as an `apikey` parameter on the
  import endpoint, over HTTPS.
- **Use production host** — a switch that chooses between the OECD **production** and
  **testing** hosts. Use the testing host while you set up and verify the field
  mapping, and switch to production when you're ready to publish live recalls.
- **Production host / testing host** — the hostnames for each environment. The client
  always builds a `https://{host}/…` URL, so transport is over TLS.
- **Field mapping** — map the fields on your recall nodes to the corresponding OECD
  GlobalRecalls fields. Refer to the module's field‑description references (for country
  IDs and recall fields) when filling this in.

## Validate the connection

The module can **ping** the OECD endpoint to confirm the API key and connection are
working. Run this before your first publishing run to make sure the key and host are
correct.

## The editor tools

With the **Use psa_oecd_publishing** (`use psa_oecd_publishing`) permission, editors get
three screens under the same path:

- **Publish needed** (`/admin/config/services/psa-oecd-publishing/publish-needed`) —
  lists recalls that still need to be published.
- **Search** (`/admin/config/services/psa-oecd-publishing/search`) — find a recall on
  the portal by its recall ID.
- **Delete** — a confirm‑delete form for removing a recall from the portal (by
  language, jurisdiction, and recall ID).

## Permissions

Assign these on **People → Permissions** (`/admin/people/permissions`):

- **Administer psa_oecd_publishing** — for the administrators who manage the settings
  (API key, host, field mapping).
- **Use psa_oecd_publishing** — for the editors who publish, search, and delete
  recalls.

## Publishing in the background

Publishing is queued, so it can be drained on **cron** (`drush queue:run`) rather than
in a page request. The module also provides **Drush commands** for headless or scheduled
publishing runs — list them with `drush list | grep oecd`.
