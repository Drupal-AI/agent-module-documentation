# Configuration

Alternative Login ID & Display Name is controlled from a single settings form
(route `alt_login.admin`).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Open the module's settings form. If you don't see a direct link, go to the
   **Extend** page (`/admin/modules`), find **Alternative Login ID & Display
   Name** in the list, and use its **Configure** / settings link.

## What you can set

The form provides options for the two things the module does:

- **Login identifier** — allow users to log in with an alternative value such as
  their **email address**, in addition to (or instead of) the username. This
  changes only how the account is *found* at login; the password check is
  unchanged.
- **Displayed username** — choose which value is shown as a user's name around the
  site.

## Good practice when allowing email login

- Make sure the alternative identifier (for example email) is **unique** across
  accounts, so a login value always maps to exactly one user.
- Keep login, registration, and password-reset messages **neutral** so they don't
  confirm whether a given email is registered.

## Save

Click **Save configuration**. The new login and display-name behaviour applies
immediately — test by logging in with the alternative identifier you enabled.
