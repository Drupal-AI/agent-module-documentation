# Configuration

All of CleanTalk's options live on a single settings form, stored in one
configuration object (`cleantalk.settings`). This page walks through it in the
order you'll usually work.

## Open the settings form

1. Log in as a user with the **Changing CleanTalk settings** permission (see
   [Permissions](#permissions) below).
2. Go to **Configuration → Content authoring → Antispam by CleanTalk → Settings**
   (`/admin/config/cleantalk/cleantalk_settings_form`).

## The one required setting: the Access key

- **Access key** — your CleanTalk Access key from a cleantalk.org account. This
  is the only required value; nothing checks spam without it. When you save, the
  form validates the key against the CleanTalk API and caches your account
  status. Remember that both this validation and every live spam check need
  outbound network access to the CleanTalk API.

## Which forms are protected

Tick the forms you want CleanTalk to check. The defaults protect the most common
targets:

- **Comments** *(on by default)* — comment submissions.
- **User registration** *(on by default)* — new account signups.
- **Webforms** *(on by default)* — Webform submissions.
- **Contact forms** *(on by default)* — core Contact forms (site-wide and
  personal).
- **Search form** *(on by default)* — the search form.
- **Forum topics** *(off by default)* — forum topic posts.
- **Added content** *(off by default)* — newly added node content.
- **Custom forms (CCF)** *(off by default)* — custom contact forms built by other
  modules.
- **External forms** *(off by default)* — forms whose action posts off-site,
  with an optional buffer-capture companion setting.
- **Comment automoderation** *(off by default)* — with a "minimum approved
  comments" threshold (default 3) before a commenter is treated as trusted.

## SpamFireWall and bot detection

The SpamFireWall (SFW) blocks known spam IPs and bots at the request level,
before the page renders:

- **SpamFireWall** *(on by default)* — the core request-level blocklist.
- **Anti-Crawler** *(off by default)* — stops aggressive crawlers.
- **Anti-Flood** *(off by default)* — rate-limits rapid repeated requests from
  one IP, with a configurable request limit (default 20).
- **JavaScript bot detector** *(on by default)* — catches automated browsers.
- **Set anti-spam cookies** *(on by default)*, with an **alternative
  (session-based) cookie mechanism** option *(off by default)* for sites where
  cookies are problematic.

## Exclusions and miscellaneous

- **URL exclusions** — a newline list of paths to skip; tick the regexp option to
  treat them as regular expressions.
- **Field exclusions** — form fields that should never be sent to the API (again
  with an optional regexp toggle) — useful for sensitive fields.
- **Role exclusions** — user roles that are exempt from spam checks (for example
  trusted staff).
- **Search noindex** *(off by default)* — adds a `noindex` meta tag to
  search-result pages to keep them out of search engines.
- **CleanTalk backlink** *(off by default)* — shows a small CleanTalk link.
- **Use Drupal HTTP API** *(off by default)* — routes API calls through Drupal's
  HTTP client instead of raw cURL, handy on locked-down hosting.
- **Debug logging** *(off by default)* — turn on to troubleshoot why a
  submission was allowed or blocked.

Click **Save configuration** when done.

## Retroactive spam cleanup

Beyond the settings form, the module adds two tools under
`/admin/config/cleantalk/` for cleaning up spam that already exists:

- **Check spam users** — scans existing accounts and lets you delete spam users.
- **Check spam comments** — finds and removes existing spam comments.

Both call the CleanTalk API. Note these two screens are gated by the core
**Administer site configuration** permission — *not* by the module's own
permission — so an editor who can change CleanTalk settings still can't run the
bulk cleanup unless they also have site-configuration access.

## Permissions

The module defines one permission, set at **People → Permissions**
(`/admin/people/permissions`):

- **Changing CleanTalk settings** (`change cleantalk settings`) — controls access
  to the settings form and the module's admin menu page. It is marked as a
  security-sensitive ("restrict access") permission, so grant it only to trusted
  roles.

```bash
drush role:perm:add administrator 'change cleantalk settings' -y
```

As noted above, the retroactive scan tools require the core **Administer site
configuration** permission instead.
