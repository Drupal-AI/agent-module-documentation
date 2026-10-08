# Configuration

After Login Redirect is configured from a single settings form where you set the
destination paths.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Open the module's settings form. If you don't see a direct link, go to the
   **Extend** page (`/admin/modules`), find **After Login Redirect** in the list,
   and use its **Configure** / settings link.

## What to set

The form provides fields for the redirect destinations:

- **After-login redirect path** — the internal path a user is sent to immediately
  after logging in (for example a dashboard or a welcome page).
- **After-logout redirect path** — the internal path a user is sent to after
  logging out (for example the front page).

Enter **internal** paths (a path on your own site). Keeping the targets internal
and fixed avoids any risk of the login/logout flow redirecting to an external URL.

## Save

Click **Save configuration**. The new destinations take effect on the next login
or logout. Log out and back in to confirm you land where you expect.
