# Configuration

Domain Role Access is configured per domain: for each domain record you choose
which roles should automatically grant access to it.

## Map roles to a domain

1. Log in as an administrator who can manage domains.
2. Go to the domain records page at **Configuration → Domain**
   (`/admin/config/domain`).
3. In a domain's list of action links, click the new **Roles** item.
4. Select the roles that should grant access to this domain and **Save**.

From then on, every user holding one of the selected roles has the same access to
that domain — and to its domain-assigned content — as if the domain were ticked on
their own profile.

## How access is combined

The access a user ends up with is the **union** of two sources:

- the domains ticked on their **user profile** (standard Domain Access), and
- the domains granted by their **roles** (this module).

The logic is **OR** — role-based access only *adds* domains; it never removes or
overrides what the profile already grants. This module introduces no new
restrictions of its own; it simply feeds extra domain values into Domain Access,
which then does the actual enforcement through its node-grants system.

## Things to keep in mind

- A role mapped to a domain grants **all** its members that domain's access, so map
  roles deliberately — a broadly held role will open the domain widely.
- Enforcement is only ever as correct as your underlying **Domain Access**
  configuration; this module changes *who* gets domain access, not *how* domain
  access is enforced.
- The mappings are configuration and can be exported and deployed with Drupal's
  config management.
