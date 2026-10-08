# Configuration

Configuring Module Permissions is a two‑part job: **curate the list** of modules you
are willing to delegate, and **grant the delegated permission** to the role that
should manage them. Both should be done only by a fully trusted top‑level
administrator.

## 1. Curate the managed module list

With the **Module Permissions UI** (`module_permissions_ui`) submodule enabled, open
its administration screen and choose which modules belong to the **managed subset**.
This is the allow/deny list: only modules on it can be enabled, disabled, or have
their permissions managed by the delegated role. Everything you leave off the list
stays under the exclusive control of full administrators.

Choose this subset deliberately. It is shared by every role you delegate to, so it
should contain only modules you are comfortable letting a less‑privileged operator
switch on and off.

## 2. Grant the delegated management permission

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the delegated module‑management permission provided by Module Permissions to
   the role that should manage the curated subset.
3. Save permissions.

Users in that role can now enable/disable the managed modules and manage those
modules' permissions — but nothing outside the list.

## Important trust and privilege‑escalation caveats

These points come straight from the module's own documentation and are the reason it
should be configured carefully:

- **Dependencies can pull in unmanaged modules.** If a managed module depends on a
  module that is *not* on the list, enabling the managed one will also enable its
  dependency — after Drupal's standard confirmation page. For example, if *Feeds* is
  managed but *Job Scheduler* is not, enabling Feeds will also enable Job Scheduler.
  Choose your subset with dependencies in mind.
- **Managing permissions can reach higher‑privileged users.** Once a user can manage
  a module's permissions, they can grant or revoke those permissions for **any**
  role, including roles with more access than their own. This is a real
  privilege‑escalation vector, so the delegated permission must go **only to trusted
  roles**.
- **Whoever controls the list controls the guardrails.** The ability to edit the
  managed list, and the delegated management permission itself, should be granted
  **only to your most trusted operators**. Anyone who can change the list can change
  what the delegated role is allowed to do.

## No external credentials

Module Permissions stores its managed list in Drupal configuration and enforces
access through Drupal's permission system. There are no API keys, tokens, or external
services involved, so there is nothing to store in an environment variable or Key
entity.
