# Configuration

All of Password Core Validator's rules live on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/people/pcv`** (route `pcv.settings.form`).

## The rules

Each rule can be turned on independently, and most pair an **enable** switch with a
value and a **customizable error message** shown when a password fails it:

- **Minimum length** — enable the length check and set the **minimum number of
  characters** a password must have.
- **Require a lowercase letter** — the password must contain at least one `a–z`
  character.
- **Require an uppercase letter** — the password must contain at least one `A–Z`
  character.
- **Require a number** — the password must contain at least one digit `0–9`.
- **Require punctuation** — the password must contain at least one non-alphanumeric
  (special) character.
- **Custom messages** — each rule has its own error message field, so you can word
  the guidance in your site's voice.
- **Success message** — optionally show a confirmation message when a password
  passes all the enabled rules.

As users type, matching hints are pushed into Drupal's core JavaScript password
**strength meter**, so people get live feedback rather than only an error on submit.

## Exempt roles

- **Exempt roles** — choose any roles that should **skip** the password rules. Users
  who hold an exempted role are not subject to the checks.

Use this deliberately: exempting a role genuinely turns the enforcement off for
those users. A common pattern is to enforce strong passwords for everyone *except* a
narrow, tightly controlled role — or, conversely, to enforce especially strict rules
only for high-privilege roles by exempting lower-risk ones.

## Where the rules apply

Because the checks attach to the core password element, they apply wherever that
element is used — **user registration**, the **account edit** form, and
**admin-created accounts**. There is nothing else to wire up.

## Save

Click **Save configuration**. The new rules take effect immediately on the next
password change or account creation.
