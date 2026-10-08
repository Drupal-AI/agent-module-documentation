# Configuration

The one required setting is your Clarity **project ID**. Without it, the module
injects nothing. The visibility settings are optional refinements on top.

## Open the settings form

1. Log in as a user with the **Administer microsoft clarity** permission.
2. Go to **Configuration → Web services → Microsoft Clarity**, or navigate
   directly to `/admin/config/services/microsoft_clarity`.

## Clarity ID

- **Clarity ID** (`account`, **required**) — paste the project ID from your
  Microsoft Clarity dashboard. It must be strictly alphanumeric (letters and
  digits only, up to 20 characters); the form rejects anything else. To turn
  tracking off site-wide later, simply clear this field and save.

## Tracking Options → Pages

This controls which URLs get the tag. Pick a mode and fill the textarea (one
path per line, using `*` as a wildcard and `<front>` for the front page; each
path must begin with `/`):

- **Every page except the listed pages** *(default)* — track everywhere, but
  skip the paths you list. A common list is `/admin`, `/admin/*`, `/user/*`.
- **The listed pages only** — track *only* the paths you list, e.g. `/blog` and
  `/blog/*`.

Paths are matched case-insensitively against both the URL alias and the internal
system path, so either form works.

## Tracking Options → Roles

This controls which users get the tag, by role:

- **Add to the selected roles only** — track only users who have one of the
  ticked roles (for example, tick only *Anonymous user* to track visitors but
  not logged-in staff).
- **Add to every role except the selected ones** — track everyone except the
  ticked roles (for example, exclude editors and administrators to avoid
  polluting your data with staff sessions).

If you select no roles, everyone is tracked.

## How the two filters combine

The tag is emitted only when **all** of these are true: a project ID is set,
**and** the current path passes the page filter, **and** the current user passes
the role filter. That lets you express rules like "track anonymous users on
every page except admin paths." If any check fails, no script is added.

Click **Save configuration** to store the settings. They live in the
`ms_clarity.settings` config object, so they export and deploy like any other
Drupal configuration.
