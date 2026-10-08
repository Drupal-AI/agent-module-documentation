# Link an ORCID — manual setup guide

**Link an ORCID** (`link_orcid`) lets a user confidently save a *verified* ORCID
iD to a field on their user account, authenticated through the ORCID API. Rather
than typing an ORCID that could be wrong or spoofed, the user clicks a **Link
ORCID** button on their profile, authenticates with ORCID over a secure OAuth
flow, and the iD that comes back — genuinely theirs — is stored automatically.

It is designed for academic and research sites where an ORCID needs to be
trustworthy. You choose an existing plain‑text field on the User entity to hold
the iD; that field is then disabled for manual editing and can only be set through
the Link ORCID button. Users can link and later unlink their own ORCID from their
profile.

The module never stores your ORCID client secret in plain configuration — it uses
the **Key** module to hold the secret securely (an environment‑backed key is a
good fit). It depends on core **User** and **Field** plus the contrib **Key**
module, and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Key dependency, and register an ORCID application.
2. [Configuration](configuration/index.md) — enter your ORCID Client ID, pick the
   Key holding the secret, choose the storage field, and grant the permission.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Link an ORCID settings**
(`/admin/config/people/link-orcid`). The **Link own ORCID** permission is granted
at **People → Permissions**. Users then link their ORCID from their own user edit
form.

## How to use it

1. In the [ORCID Developer Portal](https://orcid.org/developer-tools), create an
   application to obtain a **Client ID** and **Client Secret**, and set its
   Redirect URI to `https://your.site.com/link-orcid/callback`.
2. Store the Client Secret as a **Key** (see [Installation](installation/index.md)).
3. Create a plain‑text field on the **User** entity to hold the ORCID iD.
4. Fill in the [Configuration](configuration/index.md) form and grant the **Link
   own ORCID** permission to the roles that should be able to link.
5. A user then opens their own profile edit form and clicks **Link ORCID** next to
   the configured field; after authorising with ORCID they are returned to the
   profile with the verified iD saved.
