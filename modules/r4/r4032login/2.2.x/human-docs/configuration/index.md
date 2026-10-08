# Configuration

All of the module's behavior lives in the `r4032login.settings` config object and
is edited across **three tabbed forms** at **Configuration → System → Redirect 403
to User Login** (`/admin/config/system/r4032login/settings`). You need the
**Administer r4032login** permission. The settings export and deploy as
configuration like anything else.

## General settings

The main tab (`/admin/config/system/r4032login/settings`) covers behavior that
applies regardless of who is visiting:

- **Redirect HTTP status code** *(default: 307)* — the status used for the
  redirect. **307** (Temporary Redirect) is the safe default; **302** and **301**
  can be cached by browsers and proxies, which is usually not what you want for an
  access‑based redirect.
- **Add `noindex` header** *(off by default)* — adds an `X-Robots-Tag: noindex`
  header to the redirect response so search engines don't index it.
- **Pages to skip** (`match_noredirect_pages`) — a list of path patterns, one per
  line, that should *not* be redirected (supports the `*` wildcard and `<front>`).
  For example, list `/admin/*` to keep the standard access‑denied page in the
  admin area.
- **Negate the page list** — when off, the redirect is skipped for the listed
  paths; when on, the redirect happens *only* for the listed paths.

## Anonymous users

This tab (`/admin/config/system/r4032login/settings/anonymous`) controls what
happens to logged‑out visitors:

- **Login path** *(default: `/user/login`)* — where anonymous users are sent on a
  403. Include the leading slash. It may be an external URL, for a CAS/SSO login
  route.
- **Redirect to destination** *(on by default)* — append the originally requested
  page so the user is returned there after logging in.
- **Destination parameter override** *(default: empty)* — the query‑parameter name
  used to carry the return path. Leave it blank to use Drupal's standard
  `destination`; set it to match an external login system such as CAS, Shibboleth,
  or OAuth.
- **Display access‑denied message** *(on by default)* — show a message on the login
  page explaining why the visitor was redirected.
- **Message text** *(default: "Access denied. You must log in to view this
  page.")* — the message shown to anonymous users.
- **Message type** *(default: error)* — the style of that message: **error**,
  **warning**, or **status**.

## Authenticated users

This tab (`/admin/config/system/r4032login/settings/authenticated`) controls what
happens to users who are already logged in but still lack access:

- **Redirect authenticated users to** *(default: empty)* — a page to send a
  logged‑in user who hits a 403. `<front>` is allowed. Leave it blank to show the
  standard access‑denied page.
- **Throw a 404 for authenticated users** *(off by default)* — instead of
  redirecting, return a 404 Not Found, hiding that the resource exists. This
  overrides the redirect option above.
- **Display access‑denied message** *(on by default)* — show a message to
  authenticated users on their landing page.
- **Message text** *(default: "Access denied. Check with your site administrator if
  you need assistance.")* — the message shown to authenticated users.
- **Message type** *(default: error)* — **error**, **warning**, or **status**.

To avoid redirect loops, the module automatically strips the destination when
redirecting authenticated users.

## Editing from the command line

Every setting can also be read or written with Drush, which is handy for
deployment scripts:

```bash
drush cset r4032login.settings default_redirect_code 302
```
