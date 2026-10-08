# Configuration

Domain Theme Switch is a single form. Everything happens at **Configuration → Domain →
Domain Theme Switch** (`/admin/config/domain/domain_theme_switch/config`), which
requires the **Administer domains** permission.

## The per-domain form

The form shows one fieldset per domain you have defined. For each domain:

- **Enable theme override** — a checkbox. Leave it unchecked and the domain simply
  uses the site-wide default theme. Tick it to give the domain its own themes.
- **Site theme for domain** — the front-end theme for this domain, chosen from your
  installed themes. It defaults to whatever the domain currently uses, or the
  site-wide default if none is set yet.
- **Admin theme for domain** — the administration theme for this domain, again from
  your installed themes.

The two theme selects stay hidden until you tick the override checkbox. Only
**installed** themes appear in the lists, so install a theme before you try to assign
it (see [Installation](../installation/index.md)).

Set the themes you want across your domains and click **Save configuration**. To send
a domain back to the site default, just uncheck its override and save.

> If you have no domains defined yet, the form shows only a "Zero domain records found"
> message and no submit button — create your domains under Domain Access first.

## Where the choices are stored

In the 3.x version the module keeps **nothing of its own**. Your choices are written as
per-domain overrides of core's `system.theme`, into the configuration collection that
the Domain Configuration module manages. Domain Configuration's standard override
service then applies the right theme when a request comes in for that domain — there is
no separate theme negotiator. A practical consequence: a theme override only takes
effect when its domain is the **active** domain for the request.

## A subtlety worth knowing

Domain Configuration 3.x stores overrides as a *difference* from the site baseline.
If you happen to pick exactly the same themes the main site already uses, the stored
override row ends up empty — but it still counts as "override enabled." The module
treats the mere existence of the override row as the on/off switch (not its contents),
which is why unchecking the box **deletes** the row rather than blanking it. You do not
need to do anything special here; it just explains why an "enabled" domain might show
an empty override in configuration.

## Upgrading from 2.x

If you previously used the 2.x version, running `drush updatedb` after upgrading will:

1. Migrate the old per-domain theme settings into the new override format, then remove
   the old settings object.
2. Revoke the obsolete `domain administration theme` permission that 2.x defined, which
   silences the "non-existent permissions assigned to the role" warning.

Both steps are safe to re-run.
