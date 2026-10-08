<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure URL restrictions

Form at **`/admin/config/search/path/url-restriction-by-role`** (route
`url_restriction_by_role.config.form`, permission `admin url restriction by role settings`). Form class
`src/Form/UrlRestrictionByRoleSettingsForm.php`; config object `url_restriction_by_role.settings`.

## The form

A table of URL rows plus two message options:

| Field | Meaning |
|---|---|
| **URL** | Path pattern to restrict, e.g. `/node/add` or `/members/*`. A **validator rejects any URL containing a dot** (`.`). |
| **Enabled** | Per-row toggle; disabled rows are ignored by the subscriber. |
| **Allowed Roles** | Multi-select of role IDs allowed to access the URL. |
| **Error Message** | Text shown when access is denied and "use custom error message" is on. |
| **Use custom error message?** | If checked, denied users get a raw 403 with the message; if not, the site 403 page is used. |

## Config structure

```yaml
# url_restriction_by_role.settings
urls:
  '/members/*':
    enabled: true
    role:            # role IDs allowed to view (multi-value)
      - member
      - administrator
  '/node/add':
    enabled: true
    role:
      - editor
error_message: 'You do not have access to this page'
use_custom_error_message: false
```

Set via drush (no schema ships, so this is raw config):

```bash
ddev drush cset url_restriction_by_role.settings urls.'/members/*'.enabled 1 -y
# roles must be set as a sequence — easier via the form or a config import.
```

## How matching & denial work (`onRequest`)

- Runs on every request (`KernelEvents::REQUEST`, default priority). For each enabled configured URL it
  tests **both** the current internal path and its path alias with `path.matcher::matchPath()`, so `*`
  wildcards are supported (`/members/*`).
- Denial (for the normal multi-value roles case): a user who has **none** of the allowed roles is
  blocked. Allowed-role holders pass.
- Denied response: custom message → a `Response` with HTTP 403 and the (possibly default) message;
  otherwise a redirect to `system.site` `page.403`, falling back to `/system/403`.

## Behavioural limits to know

- **Allow-list, not default-deny**: only listed + enabled paths are restricted. Anything not listed is
  fully accessible — restricting a section requires a pattern that covers all its paths.
- **String matching is case- and normalisation-sensitive**: `matchPath` compares the raw path/alias
  against the pattern; alternate casing, encodings, or query variations that resolve to the same route
  may not match a rule. Prefer wildcard prefixes and verify each rule.
- **URLs with a dot cannot be configured** (validator), so file-like paths can't be restricted here.
- **Anonymous + Internal Page Cache**: because the check is a request subscriber, a page served from
  core's Internal Page Cache short-circuits before it runs, so restrictions targeting the anonymous role
  are not applied on a cache hit. Restrict for anonymous with care.
