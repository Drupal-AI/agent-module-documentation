# Configuration

Registration Role has one small settings form.

## Open the settings form

1. Log in as a user with the **Administer registration roles** permission.
2. Go to **People → Registration Role** (`/admin/people/registration-role`), or use the
   **Registration Role** tab on the main *People* screen.

## The fields

- **Roles to Assign** — checkboxes for every role on the site except *authenticated*
  (which every logged-in user already has, so it is not offered). Tick the role or roles
  that every new account should receive. To stop assigning anything, untick them all.
  Required.

  > **Take care which roles you tick.** The form offers *all* roles, including
  > administrator-like ones. As the form itself warns, be sure the role does not grant
  > privileges you would not want handed out automatically to anyone who registers.

- **Registration mode** — radio buttons:
  - **User self registration** — roles are granted only when an *anonymous* visitor
    registers themselves.
  - **Both user self registration and user creation by admin** — roles are *also* granted
    when a logged-in user, or a Drush/CLI script, creates the account. Because the module
    reacts to every new user being saved, this mode also covers accounts created by
    migrations and feeds, so pick it deliberately.

  Required.

Click **Save configuration**. Only the ticked roles are stored.

## Good to know

- Roles are added **only when an account is new**. Editing an existing user never
  re-applies them, and a role removed by hand is not put back.
- Under Drush the current user is anonymous but the request is a CLI request, so a
  Drush-created account only receives the roles when the mode is set to *admin*.
- The setting can hold several roles at once, so a single registration can grant multiple
  roles.
- The configuration is exportable, so you can deploy the same registration rules across
  environments.
