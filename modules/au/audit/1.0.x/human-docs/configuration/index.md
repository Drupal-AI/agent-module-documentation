# Configuration

Audit reads the site and produces reports; the configuration is mostly about
**who may run and read audits** and **which sub-audits are active**.

## Open the settings form

1. Log in as an administrator.
2. Go to the **Extend** (module list) page and follow Audit's **Configure** link,
   which opens its settings form (route `audit.settings`).

The settings form is where you adjust the framework's options. Which options
appear depends on the sub-audits you have enabled.

## Grant the permissions

Audit provides its own permissions. Because audit output can expose sensitive
configuration and weaknesses, grant these **only to trusted administrator roles**
on **People → Permissions**. Do not expose audit reports to general or anonymous
users.

## Run the audits

You can run audits two ways:

- **From the UI** — open the relevant audit report (Audit's reports appear under
  the site's **Reports** area) and run it there.
- **From Drush** — Audit provides its own Drush commands, so you can run audits
  from the command line (handy in CI or on a schedule). List them with
  `drush list --filter=audit` and run the one you need.

If you enabled **`audit_all`**, you can trigger the full aggregated run rather than
each dimension separately.

## Handle the output as sensitive

The security and status dimensions in particular can reveal how the site is
configured and where it is weak. Keep exported reports out of public or shared
locations, and share them only with people who need them.
