# Configuration

There is no single settings object — every redirect is its own **rule** (a
`url_redirect` config entity). You manage them all from one collection page.

## Add a redirect rule

1. Go to **Configuration → System → URL Redirect**
   (`/admin/config/system/url_redirect`).
2. Click **Add URL Redirect**.
3. Fill in the fields (below).
4. Click **Save**.

## The fields

- **Label** and machine **id** — a human name and machine name for the rule.
- **Path** — the source path to match. Use a leading slash for internal paths
  (for example `/members`), `<front>` for the home page, or a `*` wildcard for a
  whole section (for example `/reports/*`).
- **Redirect Path** — where to send the visitor. This can be an internal path,
  `<front>`, or an external URL such as `https://example.com/portal`. It is
  validated when you save.
- **Select Redirect path for** — choose the check to run:
  - **Role** — then pick one or more roles. The rule fires when the visitor has
    *any* of the selected roles.
  - **User** — then autocomplete one or more specific users. The rule fires for
    those users.
- **Negate the condition** — invert the match, so the rule applies to everyone
  *except* the selected roles/users.
- **Display Message for Redirect** — **Yes** shows a "You have been redirected
  to …" status message after redirecting; **No** is silent.
- **Status** — **Enabled** makes the rule active; **Disabled** parks it without
  deleting it. Only enabled rules are ever considered.

When saving, the form rejects a duplicate source path on a new rule and an invalid
redirect path, and Role/User mode requires you to pick at least one role or user.

## How rules behave

- Redirects are **301 (permanent)**.
- Matching is on the request path, so store source paths with a leading slash (or
  use `<front>`); wildcards use `*`.
- External destinations are allowed (they use a trusted redirect response, so they
  are not blocked by Drupal's external-redirect protection).
- Rules also fire on **403 access-denied** responses, letting you redirect users
  away from pages they cannot reach.

## Managing existing rules

The collection page lists all your rules with edit and delete links (gated by the
edit and delete permissions). To temporarily switch a rule off, edit it and set its
**Status** to Disabled rather than deleting it.

## Deploying rules

Each rule is stored as a `url_redirect.url_redirect.<id>` config entity, so your
redirects travel with a normal configuration export across environments. You can
inspect one with:

```bash
drush config:get url_redirect.url_redirect.<id>
```
