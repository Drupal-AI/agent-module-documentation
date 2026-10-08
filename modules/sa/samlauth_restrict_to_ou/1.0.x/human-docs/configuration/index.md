# Configuration

The configuration form lives at **`/admin/config/people/saml-restrict`** and is
protected by the module's own restricted permission. This form *is* your access
policy, so treat it accordingly.

## The settings, field by field

- **Restrict Login to OUs** — the master toggle. Turn it on to begin enforcing
  the restriction; turn it off to disable enforcement without losing the rest of
  your settings. Leave it off while you are still setting things up so you do not
  lock yourself out.
- **SAML Attribute Name** — the name of the attribute that carries the OU data.
  In most Active Directory setups this is `dn` (the Distinguished Name). The
  module parses the OU values out of the DN for you, so a value like
  `CN=user,OU=Marketing,OU=Users,...` yields the OUs it contains.
- **Allowed OUs** — the OU names that are permitted to log in, entered **one per
  line** (for example `Staff`, `Faculty`, `Marketing`). Matching is
  **case‑insensitive** so it stays reliable across directory updates. Do **not**
  include the `ou=` prefix — just the OU name.
- **Strict Mode** — controls AND vs OR logic. Left unchecked, a user needs to
  belong to **any one** of the listed OUs (OR). Checked, a user must belong to
  **every** listed OU (AND) to gain access.
- **Access Denied Message** — the exact message shown to users who are turned
  away. Basic HTML markup is supported so you can make the message clear and
  visible.

## Things to get right

- **OU names come from your directory.** If someone renames an OU there, your
  list stops matching and users can be locked out. Decide who watches for
  directory changes.
- **A user may have several OU values or a nested path.** Choose your allowed
  entries carefully, and remember Strict Mode changes whether one match is enough
  or all must match.
- **The check happens at login.** Make sure a user who moves to a different OU
  loses access on their next sign‑in, rather than keeping a still‑usable account
  from before — otherwise the restriction becomes a one‑time filter instead of an
  ongoing control.
