# Configuration

Multiple Email Addresses has one small settings form plus two permissions. The
defaults are sensible, so most sites only need to grant the permissions and
maybe tweak the confirmation email wording.

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`):

- **Administer multiple emails** — a *restricted* permission that grants access
  to the settings form described below. Give it to administrators only.
- **Use multiple emails** — lets a user open the **E‑mail Addresses** tab on
  their own account and add, confirm, resend, set‑primary, and remove addresses.
  Grant it to whichever authenticated roles should have the feature.

## Open the settings form

1. Log in as a user with **Administer multiple emails**.
2. Go to **Configuration → People → Multiple E‑mail Settings**, or navigate
   directly to `/admin/config/people/multiple-email`.

## What you can configure

The options are documented inline on the form itself; the main ones are:

- **Confirmation email content** — the **subject** and **body** of the message
  sent when a user adds a new address. Both support tokens, so you can insert the
  confirmation link, the site name, the user's name, and similar values. If your
  site is multilingual, the confirmation email can be localized per language.
- **Confirmation code expiry** — how many **days** an unconfirmed address stays
  valid before it expires. After this window the pending address (and its code)
  is no longer usable and the person must add it again.
- **Account‑form email field behavior** — whether the core email address field is
  **hidden** on the user account edit page. By default the module hides it,
  because with this module installed the account's email is chosen from the
  confirmed addresses on the E‑mail Addresses tab rather than typed directly on
  the edit form. Leave it hidden unless you have a specific reason to expose it.

Click **Save configuration** when you are done.

## How the confirmation flow behaves

You do not configure these directly, but it helps to know what the settings
drive:

- Adding an address emails a **secure random code** (generated with PHP's
  cryptographic `Randomizer`) and a confirmation link. The user must be **logged
  in** to confirm.
- Users can **resend** or **cancel** a pending confirmation, **set** any
  confirmed address as primary, and **remove** a secondary address — each from
  the E‑mail Addresses tab, and each action is access‑checked so people can only
  touch their own addresses.
- A registered address is **reserved**: it cannot be used to seed a brand‑new
  account elsewhere on the site.
