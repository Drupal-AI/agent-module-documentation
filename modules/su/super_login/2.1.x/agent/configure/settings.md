# Super Login settings

Config object: **`super_login.settings`**. Every value is nested under a top-level
`super_login` key, so the dotted path is `super_login.super_login.<key>` in raw config and
`super_login.<key>` when you already target the `super_login.settings` object.

UI: *Configuration → People → Super Login Settings* — route `super_login.settings`, path
`/admin/config/people/super_login/settings`, permission **administer site configuration**.

## Keys

Text strings (`type: label`):

| Key | Default | Purpose |
|---|---|---|
| `login_text` | `Log In` | title of the username/email field on the login form |
| `login_title` | `Username or e-mail address` | text shown above the login form |
| `forgot_pw_text` | `Forgot password?` | "forgot password" link text (→ user.pass) |
| `new_account_text` | `Create new account` | "create account" link text (→ user.register) |
| `password_reset_title` | `Password Reset` | title above the password-reset form |
| `back_link` | `Go back to the login page.` | back-to-login link on reset/register pages |
| `capslock_msg` | `Caps Lock is on` | caps-lock warning text |
| `login_placeholder` | (unset) | placeholder inside the username field |
| `pass_placeholder` | (unset) | placeholder inside the password field |
| `login_button_text` | (unset → core default) | login submit button label |
| `reg_button_text` | (unset → core default) | registration submit button label |

Toggles (`type: boolean`) and Login Type (`type: integer`):

| Key | Default | Purpose |
|---|---|---|
| `login_type` | `0` | **0** = username or email, **1** = username only, **2** = email only |
| `capslock` | `true` | show the caps-lock warning |
| `css` | `true` | attach the module's stylesheet (`super_login/super_login_css`) |
| `messages` | `true` | move status messages outside the form (passed to JS as `show_messages`) |
| `placeholder` | `true` | apply the placeholder strings above |
| `autofocus` | `false` | autofocus the username field |

(`button_theme` is written by the form but has no UI element; leave as-is.)

## Read / write with drush

```bash
# read the whole object
drush cget super_login.settings

# read one value (note the nested super_login key)
drush cget super_login.settings super_login.login_type   # 0 | 1 | 2

# email-only login
drush cset super_login.settings super_login.login_type 2 -y

# turn the caps-lock warning off
drush cset super_login.settings super_login.capslock 0 -y
```

Or in PHP: `\Drupal::configFactory()->getEditable('super_login.settings')->set('super_login.login_type', 2)->save();`
and read with `\Drupal::config('super_login.settings')->get('super_login.login_type')`.
