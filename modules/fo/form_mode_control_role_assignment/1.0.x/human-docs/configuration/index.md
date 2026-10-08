# Configuration

All configuration happens on a single mapping form. Before you start, make sure
you have created the **user form modes** you want to use (via Form Mode Control)
— the mapping form simply lists whatever user form modes exist.

## Open the mapping form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → People → Form mode role mapping**
   (`/admin/config/people/form-mode-role-mapping`).

## Map each form mode to a role

The form lists **every user form mode** on the site. For each one, pick the role
to assign:

- **Choose a role** from the selector next to a form mode, and anyone who
  registers through that mode will be granted that role automatically.
- **Leave it on "‑ No Role ‑"** to make that form mode grant nothing (the
  default). This is what you want for the standard registration form and any
  mode that should stay role‑free.

Save the form. The choices are stored as a `form_mode_id → role` mapping in the
module's configuration.

## How the role gets applied

When someone visits a registration form with `?display=<form_mode>` in the URL
and a mapping exists for that mode:

1. The roles checkboxes are **hidden** on the form and the mapped role is
   **pre‑selected** and locked.
2. When the account is saved, the module **adds the mapped role** to the new
   user.
3. The role is also applied on the user‑registration event, so the assignment is
   enforced consistently.

To actually route people to a specific mode, link them to
`/user/register?display=<form_mode>`.

## Before opening self‑registration

- **Map roles appropriate for self‑registered users.**
- **Keep approval on for sensitive roles.** If any mapped role grants meaningful
  access, keep Drupal's **"Visitors can register but administrator approval is
  required"** account setting enabled.
