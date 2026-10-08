# samlauth_group — manual setup guide

**samlauth_group** (`samlauth_group`) extends the SAML Authentication
(`samlauth`) module so that a user's **Drupal Group memberships and roles** are
set from the attributes their identity provider (IdP) sends at SAML login. When
someone signs in, the group and role information in their SAML assertion is used
to add them to the right groups from the Group module — and, optionally, to give
them a role within each of those groups.

This solves the provisioning problem in organisations that already manage group
structure centrally: rather than adding people to Drupal groups by hand, you map
an IdP attribute (say a team, department or entitlement) to a group membership,
and the mapping keeps memberships aligned with the directory on every login. A
user can be made a member of a single group or of every group of a given type.

The module works once you configure the mappings. Enabling it alone does nothing
visible; you set the attribute‑to‑membership mappings on the SAML Authentication
configuration page (see below). It depends on both the **Group** module and the
**samlauth** module, and it has no submodules. Note that its release branches
track the Group module's major version — the 3.x branch here works with Group 3.

A word on trust, because this module grants access from IdP‑supplied data. The
whole arrangement is only as safe as the SAML assertion behind it, so
**`samlauth` must be configured to validate the IdP's assertion signature** — 
otherwise attributes could be forged. Only trust a genuine IdP, and design the
mappings carefully: a mapping to a privileged group role hands that privilege to
anyone the IdP places in that group. Prefer least privilege and review your
mappings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Group and samlauth.
2. [Configuration](configuration/index.md) — where to set the
   attribute‑to‑group/role mappings.

## Where it lives in the admin menu

samlauth_group does not add a separate settings page. Instead, once installed you
configure it from the **SAML Authentication** module's own configuration page,
using the **Group / Membership** tab to set your attribute → group membership (and
optional group role) mappings.
