# Configuration

All of Domain 301 Redirect's behavior is set on one form. This page walks through it field
by field, then covers the two permissions.

## Who can configure it

Two permissions ship with the module, both marked as restricted (security-sensitive):

- **Administer domain 301 redirect** (`administer domain 301 redirect`) — lets a user open
  the settings form, set the main domain, toggle redirection on or off, and edit the page
  list. Grant this only to trusted administrators.
- **Bypass domain 301 redirect** (`bypass domain 301 redirect`) — a user with this permission
  is **never** redirected. This is handy for staff or editors who need to reach the site on a
  non-canonical domain (for example a staging hostname) while everyone else is redirected to
  the main domain. Because bypass is evaluated per request and the redirect is cached with the
  user-permissions context, bypass and non-bypass users get correctly separated cached
  responses.

Set both at **People → Permissions**.

## Open the settings form

1. Log in as a user with the **Administer domain 301 redirect** permission.
2. Go to **Configuration → Search and metadata → Domain 301 Redirect**, or navigate directly
   to `/admin/config/search/domain-301-redirect`.

## The settings

### Main domain

The canonical hostname you want everything redirected to — for example
`https://www.example.com`. Include the scheme (`https://` or `http://`); if you leave the
scheme off, it's treated as `http://`. You may include a port too (for example a staging site
on `:8443`). No redirect happens at all while this field is empty, whatever the enable toggle
says.

Because both the host *and* the scheme are compared, this field also drives scheme
canonicalization — set it to an `https://` address and `http://` visitors are redirected to
the secure version.

### Enabled

The master on/off switch for redirection. When you tick this and save, the module first
verifies the domain (see below) before turning redirection on.

### Applicability (include vs. exclude)

Choose how the page list below is interpreted:

- **Exclude listed pages** *(default)* — redirect **everywhere except** the paths you list.
  Use this to keep certain endpoints (an API, a health check, an admin section) reachable on
  any domain while everything else is canonicalized.
- **Include only listed pages** — redirect **only** on the paths you list, and leave the rest
  of the site alone.

### Pages

A list of paths, one per line, that the applicability setting acts on. Wildcards with `*` are
supported (for example `/admin/*` or `/api/*`), and you can use `<front>` for the front page.
Paths are matched against the current request's **path alias**, so aliased URLs match as
you'd expect.

## Save and the domain verification check

When you save with **Enabled** ticked, the module runs a safety check before switching
redirection on: it makes a request to the domain you entered
(`<your-domain>/domain-301-redirect-check`) with a secret token, and only proceeds if that
request comes back successfully. The token is an HMAC based on this site's hash salt and
private key, so the check effectively confirms that the domain you typed resolves back to
*this same Drupal site* — protecting you from redirecting your traffic to the wrong place.

If the domain isn't a valid URL, or the check request doesn't succeed (it retries a few times
before giving up), saving fails with a form error and redirection stays off. This is normal if
the DNS for the new domain hasn't propagated yet, or the domain isn't yet pointed at this
site — fix that, then enable again.

## Setting it from Drush

You can set the values without the form (though this skips the domain-verification check, so
make sure the domain is correct):

```bash
drush cset domain_301_redirect.settings domain 'https://www.example.com' -y
drush cset domain_301_redirect.settings enabled 1 -y
```
