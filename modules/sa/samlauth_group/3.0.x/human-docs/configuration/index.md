# Configuration

samlauth_group has no settings page of its own. It adds a **Group / Membership**
tab to the **SAML Authentication** (`samlauth`) module's configuration page, and
that tab is where all the work happens.

## Set the mappings

1. Enable both this module and `samlauth`, and make sure the Group module is set
   up with the group types you want to assign people to.
2. Open the **SAML Authentication** configuration page and switch to the
   **Group / Membership** tab.
3. Map your SAML attributes to group memberships. For each mapping you decide:
   - which **SAML attribute** value indicates membership;
   - whether the user becomes a member of a **single group** or of **all groups
     of a given type**;
   - optionally, a **group role** to grant the user within that group.

Once saved, the mappings are applied on each SAML login: the user's IdP
attributes are read and their Drupal group memberships and group roles are
synced to match.

## Get the mappings right

Because membership and roles are granted from attributes the IdP sends, the
safety of the whole setup rests on a few things:

- **The assertion must be trustworthy.** Configure `samlauth` to validate the
  IdP's assertion signature so attributes cannot be forged, and only connect a
  trusted IdP.
- **Avoid over‑permissive mappings.** A mapping that grants a privileged group
  role gives that privilege to everyone the IdP places in the corresponding
  group. Prefer least privilege.
- **Review periodically.** Directory structures change; revisit your mappings so
  they still reflect who should be in which group.
