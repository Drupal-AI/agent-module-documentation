# LDAP Profile — manual setup guide

**LDAP Profile** (`ldap_profile`) extends Drupal's LDAP integration so that
directory attributes flow into **Profile** fields for users who are identified
or provisioned through LDAP. The core LDAP suite already maps the basics — a
username, an email address — from your directory onto a Drupal account. This
small add-on lets you push *additional* attributes (a department, a phone
number, a job title, whatever your directory holds) into the richer profile
fields your site defines, so a person's Drupal profile stays in step with the
authoritative record in the directory.

It is a thin layer on top of the **LDAP User** module (`ldap_user`), which is
part of the [LDAP](https://www.drupal.org/project/ldap) suite. LDAP Profile does
not talk to your directory on its own and it does not manage the LDAP
connection — it reuses the server, bind credentials, and mapping machinery the
LDAP suite already provides, and simply widens what gets mapped. It has no
access-control role of its own: it maps data, nothing more.

Because everything it does depends on a correctly configured LDAP connection,
the security notes belong to the connection itself: make sure the LDAP suite is
set to talk to your directory over **LDAPS or StartTLS** (an encrypted channel),
and that the LDAP **bind credentials** are stored as secrets rather than in
plain configuration. Directory data and the credentials used to read it are both
sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the LDAP User dependency is in place.

There is **no configuration page of its own** for this module. The
LDAP‑attribute‑to‑profile‑field mapping is set up inside the **LDAP User**
module's field‑mapping UI (part of the LDAP suite), not on a separate LDAP
Profile settings form — see "How to use it" below.

## Where it lives in the admin menu

LDAP Profile adds no admin page. You configure the attribute mapping from the
LDAP suite's settings — in the **LDAP User** module's field‑mapping / provisioning
configuration under **Configuration → People → LDAP**. That is where you connect
each directory attribute to the Drupal profile field it should populate.

## How to use it

1. Install and configure the full **LDAP** suite first — at minimum
   `ldap_servers` (your directory connection) and `ldap_user` (account
   provisioning). Confirm login and basic account provisioning from LDAP already
   work before adding profile fields.
2. Create the **profile fields** on the user entity (or your profile bundle)
   that you want to fill from the directory.
3. Enable **LDAP Profile**, then open the LDAP User field‑mapping configuration
   and map each directory attribute to the corresponding profile field.
4. Trigger a sync (a user login, or the LDAP suite's sync mechanism) and confirm
   the profile fields populate from the directory.
