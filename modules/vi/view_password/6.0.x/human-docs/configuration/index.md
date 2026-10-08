# Configuration

## Open the settings form

1. Log in as a user with the **Administer view password** permission.
2. Go to **Configuration → System → View Password Settings**, or navigate directly
   to `/admin/config/system/view-password-settings`.

Everything you set here is stored in the `view_password.settings` configuration
object, so it exports and deploys with `drush config:export`.

## Choose which forms get the toggle

The main field is **"Enter the form id(s) here."** — a textarea that takes a
**comma‑separated list of form IDs**. Each form ID you list will get the eye toggle
next to its password field. The default is:

```
user_login_form
```

Add more forms by separating IDs with commas, for example:

```
user_login_form,user_register_form,user_pass_reset
```

> **Important:** put **no spaces** between the IDs — only commas. The form validates
> this and rejects any entry containing whitespace with the message *"The form ids
> should contain values separated by commas only."* To find a form's ID, inspect the
> form's markup for its `id` attribute (Drupal renders it on the `<form>` element,
> e.g. `user-login-form` → the form ID is `user_login_form`).

Behind the scenes the module tags each matching form with a `pwd-see` CSS class,
which scopes its JavaScript so only the forms you listed are affected — every other
form on the site is left untouched.

## Optional — custom button classes

The **"Enter the form class here."** textarea lets you add extra, space‑separated
CSS classes to the toggle `<button>`. Leave it blank to use the default styling; fill
it in if you want to hook the button into your theme's own CSS. This is purely
cosmetic.

## Optional — custom eye icons

Two text fields let you replace the built‑in open/closed eye SVGs with your own:

- **Path to the exposed‑password icon** — the "eye open" icon shown while the
  password is visible.
- **Path to the hidden‑password icon** — the "eye closed" icon shown while the
  password is masked.

Enter a **root‑relative path that starts with a leading slash** (for example
`/themes/custom/mytheme/images/eye-open.svg`). If a path doesn't start with `/`, the
form rejects it. Leave either field blank to keep the module's default icon.

## Save

Click **Save configuration**. Reload one of the forms you listed and you'll see the
eye toggle next to its password field — click it to reveal or hide the text you
typed.
