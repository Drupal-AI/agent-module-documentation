# Configuration

All of Password Eye's configuration is a single list of **form IDs**. The eye
icon is added to every form whose ID you list, and to no others.

## Open the settings form

1. Log in as a user in the **administrator** role (the form is restricted to that
   role).
2. Go to **Configuration → System → Password Eye Settings**, or navigate directly
   to `/admin/config/system/pssword_eye-settings` (the path segment is misspelled
   `pssword` in the module — this is the correct URL).

## The one field

The form has a single textarea, labelled **"Enter the form id here."** Type one
or more Drupal form IDs, separated by commas. For example:

```
user_login_form,user_register_form
```

- The default value (set when the module is installed) is `user_login_form`, so
  the login form is covered until you change it.
- Add `user_register_form` to let people verify their chosen password while
  registering.
- Add any custom, checkout, or "change password" form's ID to cover it too.
- **Clearing the box entirely disables the feature everywhere** — no form gets the
  eye icon.

Click **Save configuration** to apply.

## Finding a form's ID

If you are not sure of a form's ID, inspect the rendered page and look at the
`<form>` tag. Drupal writes the HTML `id` with dashes (for example
`user-register-form`), but here you enter the underscore version
(`user_register_form`).

## What happens on the front end

For each form you list, the module adds a CSS class to the form and loads its
small stylesheet and script. The script inserts a clickable eye icon after every
password input in that form; clicking it toggles the field between hidden and
plain text and swaps the open/closed eye icon. The icon is styled with the CSS
classes `shwpd`, `eye-open`, and `eye-close`, so your theme can restyle it if you
want a different look. No custom JavaScript of your own is needed.
