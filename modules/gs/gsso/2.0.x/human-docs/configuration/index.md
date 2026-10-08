# Configuration

## Open the settings form

1. Log in as a user with the **Administer group** permission.
2. Go to **`/admin/group/sso`**.

## Fields on the form

- **SSO type** — choose the protocol. Currently this must be **SAML**; other
  values are under development and cause the mapping hook to do nothing. Stored as
  `sso_type`.
- **Update user claims when they change** — when enabled, Group SSO only
  re‑synchronises a user's roles and memberships if their claims actually changed
  since last login, which avoids unnecessary writes on every request. Stored as
  `claims_changes`.
- **SSO group attribute** — the machine name of the IdP attribute that carries the
  group information. Stored as `sso_group_attribute`.
- **SSO role attribute** — the machine name of the IdP attribute that carries the
  role information. Stored as `sso_role_attribute`. (If you set this to the same
  name as the group attribute, only the group attribute is used.)
- **Separator** — how to split a multi‑value claim: choose end‑of‑line (`eol`) or
  supply a literal separator string. Stored as `sso_separator`.
- **The claim matrix** — the heart of the configuration. It maps each string that
  can appear in the SSO attribute to the Drupal roles and to the Groups (and group
  roles) it should grant. Think of it as a grid: rows are the claim values that
  give access to a given Group, columns are the roles within it. Stored as
  `sso_claims`.
- **Debug** — turn on verbose logging (on the `gsso` log channel) to trace exactly
  how each attribute value was mapped to roles and groups. Useful while you are
  tuning the matrix; turn it off in production.

## What happens on each login

When a user signs in through SimpleSAMLphp, Group SSO:

1. reads and joins the configured attributes into a claims string;
2. stores that string against the user (in its own `gsso_claims` table);
3. **removes every one of the user's roles and Group memberships**; then
4. **re‑adds** only the roles, groups, and group roles the matrix maps for the
   current claims.

## The one thing to get right

Because step 3 wipes the slate clean whenever claims change, your matrix must
cover **every** role and group a user is supposed to keep. Anything the mapping
does not re‑add is removed until the next login restores it (if it ever does).
Build and test the matrix carefully — with **Debug** on and a test account —
before rolling it out, so you do not accidentally strip access from real users.
