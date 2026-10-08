# Configuration

Everything is set on a single form with two tables: one for where each role goes
after **login**, and one for after **logout**.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Login and Logout Redirect per role**, or
   navigate directly to `/admin/people/login-and-logout-redirect-per-role`.

## The Login redirect and Logout redirect tables

Each table lists your roles (the anonymous role is excluded), and each row has
three controls:

- **Redirect URL** — where to send a user with this role. Leave it **empty** to
  give that role no special redirect (Drupal's default behavior applies). See the
  accepted formats below.
- **Allow destination** — when ticked, if the request already has a
  `?destination=` (for example a deep link the user followed to reach the login
  form), that existing destination wins and this role's URL is *not* forced.
  Leave it unticked to always send the role to its Redirect URL.
- **Weight** — priority. Drag rows to reorder them; a row higher in the list
  (lower weight) takes precedence.

Fill in the **Login redirect** table for post-login landing pages and the
**Logout redirect** table for post-logout pages, then **Save configuration**.

## Accepted Redirect URL formats

A non-empty Redirect URL must be one of:

- **`<front>`** — the site front page.
- An **internal path** beginning with `/`, `?`, or `#` — for example
  `/admin/content`, `?tab=reports`, or `#section`.
- A **token** beginning with `[` — for example `/user/[current-user:uid]/edit`.
  This requires the Token module.

External URLs are rejected, and the form validates that the path exists and is
accessible.

## How role priority is resolved

A user often has several roles. On login or logout the module sorts that table's
rows by weight (top of the list first) and uses the **first role the user
actually has whose Redirect URL is not empty**. Everything else is skipped. So:

- Put your most specific roles (Manager, Editor) **above** broad ones
  (Authenticated user) so they win.
- Give a role an empty Redirect URL to make the module "fall through" to the next
  matching role.
- If no row matches, the user keeps Drupal's default login/logout behavior.

## Example: editors to the content list, everyone else to the front page

1. In **Login redirect**, set the *Content editor* row's Redirect URL to
   `/admin/content` and drag it to the top.
2. Set the *Authenticated user* row's Redirect URL to `<front>` and leave it
   below.
3. In **Logout redirect**, set the *Authenticated user* row to `<front>`.
4. Save. Editors now land on the content list after login, while other logged-in
   users go to the front page; everyone returns to the front page on logout.

## Flows the module leaves alone

Login redirects are deliberately suppressed on password-reset routes, the
two-factor (TFA) entry step while a reset token is present, and the Commerce
checkout form, so those flows are never hijacked. Logout is not restricted this
way.

## Deploying the configuration

All of this lives in one exportable configuration object, so it moves between
environments with the rest of your configuration. Note there is **no default
configuration** shipped — until you save the form the object does not exist,
which simply means "no redirects configured".
