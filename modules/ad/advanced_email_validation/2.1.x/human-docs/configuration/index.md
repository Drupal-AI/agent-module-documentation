# Configuration

## Open the settings form

1. Log in as a user with the **Administer advanced email validation**
   permission.
2. Go to **Configuration → People → Advanced Email Validation**, or navigate
   directly to `/admin/config/people/advanced-email-validation`.

Settings are stored in the `advanced_email_validation.settings` configuration
object.

## Rules

Turn on any combination of the four checks. Each one is independent — you can run
just MX lookup, or stack MX + disposable + banned, and so on.

- **MX lookup** (`mx_lookup`) — the address's domain must have valid MX records,
  i.e. it must be able to receive mail. Rejects made‑up or undeliverable domains
  and helps cut bounce rates.
- **Disposable** (`disposable`) — reject throwaway / temporary email providers.
- **Free** (`free`) — reject free consumer providers such as Gmail and Yahoo.
  Useful when you only want corporate addresses.
- **Banned** (`banned`) — reject domains on your own banned list (see below).

## Domain lists

Each of the disposable, free, and banned rules has an editable domain list:

- **Disposable domains** and **Free domains** — the library already ships a
  bundled list of well‑known domains. The list you enter here is *added* to that
  bundled list by default.
- **Banned domains** — always your own list; there is no bundled banned list.

### Use only my list

For the disposable and free rules there is a **local list only** switch
(`local_list_only.disposable` / `local_list_only.free`). Turn it on to ignore the
library's bundled list and match against *only* the domains you entered. Leave it
off to combine your list with the bundled one. (The banned rule is always
your‑list‑only.)

## When validation runs

The **Validate account on** options decide when the account checks apply:

- **Created** (`validate_account_on.created`) — validate the email on **new**
  account registration.
- **Updated** (`validate_account_on.updated`) — validate when an existing
  account's email is **changed**.

If neither is ticked, account emails are not validated automatically (you can
still call the validator from code or use the Webform handler). After changing
these options, run `drush cr` so the field‑level checks are re‑applied.

## Error messages

Each rule has its own message shown when an address is rejected:

- **Basic** — a basic RFC / not‑a‑valid‑address failure.
- **MX lookup**, **Disposable**, **Free**, **Banned** — one message per rule.

These messages are stored in configuration and are **translatable** through
core's **Configuration Translation** module — so on a multilingual site you can
give each language its own wording. Edit them per language under the config
translation UI for this settings form.

## Applying the rules to a Webform (optional)

If the **Webform** module is installed, you can reuse these rules on any form:

1. Edit the webform and go to **Settings → Emails / Handlers → Add handler**.
2. Add the **Advanced Email Webform Validator** handler.
3. Choose which email / email‑confirm elements it should validate.
4. Optionally tick **Override site defaults** to give this one form its own
   stricter (or looser) rules, domain lists, and messages instead of the global
   settings above.

## Save

Click **Save configuration**. Account validation takes effect on the next
registration or email change (after a cache clear if you changed the "validate
account on" options).
