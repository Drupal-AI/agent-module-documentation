# Configuration

Before this form is useful you need three things ready: an ORCID application
(Client ID and Client Secret), the Client Secret stored as a **Key**, and a
plain‑text field on the **User** entity to hold the iD. See
[Installation](../installation/index.md) for those steps.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → People → Link an ORCID settings**, or navigate directly
   to `/admin/config/people/link-orcid`.

## Settings, field by field

- **ORCID API Client ID** — enter the Client ID from the application you created
  in the ORCID Developer Portal.
- **Client Secret key** — select the **Key** entity that holds your ORCID Client
  Secret. The module reads the secret from the Key at runtime and never stores the
  raw value in its own configuration.
- **User field** — choose the plain‑text field on the User entity where the
  verified ORCID iD should be saved. Once selected, that field becomes disabled
  for manual editing and is only ever set through the Link ORCID button.
- **Sandbox** — toggle this on to test against ORCID's sandbox environment rather
  than the live ORCID API. Turn it off for production.

Click **Save configuration** when done.

## Grant the permission

Users can only link their own ORCID if they have the **Link own ORCID**
permission. Grant it to the appropriate roles at **People → Permissions**
(`/admin/people/permissions`) — for example the Authenticated user role. The
configuration form includes a helpful message and link for setting this up.

## What the user sees

With everything configured, a user opens their **own** user edit form and finds a
**Link ORCID** button next to the configured field. Clicking it starts the ORCID
OAuth flow; after authorising, they are redirected back to the profile edit page
with a success (or error) message, and the verified iD is stored. Users can unlink
their ORCID later from the same place.
