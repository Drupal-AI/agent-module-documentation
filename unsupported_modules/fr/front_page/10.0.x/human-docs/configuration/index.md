# Configuration

Everything Front Page does is stored in a single configuration object,
`front_page.settings`. There are two forms, both gated by the **Administer front
page** permission (`administer front page`).

## Role‑based redirects

Go to **Configuration → System → Front Page → Settings**
(`/admin/config/system/front/settings`).

### Enabled

The **master switch**. When it is off, no redirects happen at all — but your
per‑role configuration is preserved, so you can turn the whole feature on and off
without losing your setup.

### Disable for administrators

When ticked, users with the `administrator` role are never redirected, even if the
"authenticated" role override would otherwise apply to them. This keeps admins on
the normal front page while everyone else is routed.

### Per‑role sections

The form builds one collapsible section for every role on the site. For each role
you can set:

- **Enabled** — whether this role's redirect is active.
- **Path** — where members of this role are sent when they hit the front page. It
  must start with `/` and be a valid, accessible internal path (for example
  `/user/login` or `/dashboard`); the form validates this.
- **Weight** — used to break ties. A user often has several roles at once (for
  example *authenticated* plus a custom role). When more than one of their role
  overrides is enabled, the one with the **lowest weight wins**. Give the redirect
  you want to take priority the smaller number.

A common setup: send **anonymous** users to `/user/login` (weight 0) and
**authenticated** users to `/dashboard` (weight 10).

### When the redirect does *not* run

The redirect is deliberately skipped for CLI/Drush requests, during installation,
and in maintenance mode, so it never interferes with those. It only ever fires on
the true front page.

## The Home‑link rewrite

Go to **Configuration → System → Front Page → Home links**
(`/admin/config/system/front/home-links`).

This is a **separate feature** from the role redirects. Set a **Home link path**
here and the module rewrites every link that points at `<front>` — the theme's
Home link, menu Home links, and anything built from `Url::fromRoute('<front>')` —
to point at your chosen path instead. Store it without a leading slash (for
example `node/1`); the module adds the slash. Leave it empty to keep the default
behaviour where `<front>` resolves to `/`.

## Save

Click **Save configuration** on either form. Redirects take effect on the next
front‑page request; the Home‑link rewrite affects links rendered from then on.
