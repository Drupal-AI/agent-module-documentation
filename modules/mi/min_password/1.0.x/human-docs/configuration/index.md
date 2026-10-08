# Configuration

Min Password adds a single setting — the minimum password length — to Drupal's
existing **Account settings** page. There is no separate configuration form for
the module.

## Open the Account settings page

1. Log in as a user with the **Administer account settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Account settings**, or navigate directly to
   `/admin/config/people/accounts`.

## The minimum password length field

On that page you'll find the field added by Min Password: the **minimum password
length** for user accounts. Enter the number of characters a password must have at
minimum. From then on, any attempt to set or change a password shorter than this
value is rejected with a validation message; passwords that already exist are not
affected.

Choosing a value:

- Longer is better. Modern guidance favors **length over complexity**, so a longer
  minimum (for example 12 or more characters) generally does more for security
  than forcing a mix of character types.
- Set it to match your organisation's password policy.
- Remember this is a *length-only* check. If you also need character-type rules,
  password history, expiry, or username-in-password checks, use the
  [Password Policy](https://www.drupal.org/project/password_policy) module instead
  — Min Password intentionally covers just the length requirement.

## Save

Click **Save configuration** at the bottom of the Account settings page. The new
minimum takes effect immediately for any subsequent password change, including on
the password reset form.
