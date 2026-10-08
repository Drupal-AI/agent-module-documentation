# Configuration

Config Suite is controlled from a single settings screen. This page explains what
that screen governs; the exact field labels may vary slightly between releases, so
read the on-screen help text as the authoritative wording for your version.

## Open the settings form

1. Log in as a user with the **Administer config suite** (`administer config suite`)
   permission.
2. Go to **Configuration → Config Suite**, or navigate directly to
   `/admin/config/config_suite/admin_settings`.

## What the screen controls

The settings screen is where you turn Config Suite's three behaviours on and tune
how they run:

- **Automatic configuration import** — when enabled, Config Suite imports
  configuration from your sync folder when an administrator loads a page, so you do
  not have to run `drush cim` after updating the sync files (for example after a
  `git pull`). There is a brief delay while an import runs; when nothing has changed
  it is fast.
- **Automatic configuration export** — when enabled, Config Suite listens for
  configuration-save events and writes the changed configuration out from the
  database to your config sync folder automatically, so you do not have to run
  `drush cex` after each change.
- **Reuse configuration between sites** — the option that lets configuration created
  on one site be imported into another site with a different UUID, avoiding the
  *"Site UUID in source storage does not match the target storage"* error.

## Save

Make your selections and click **Save configuration**. The automatic behaviours take
effect immediately for subsequent config changes and admin page loads.

## Things to weigh before turning on automation

- **Automatic export changes what a diff means.** Once every config change is
  exported for you, your version-control diff records *everything* — including
  accidental changes — not just deliberate ones. Make sure someone is reviewing the
  changes at commit time, since the "did I mean to export this?" checkpoint has
  effectively moved there.
- **Consider locking production instead.** If your goal is to stop configuration
  drifting on production, making production configuration read-only (for example with
  the `config_readonly` module) removes the problem entirely rather than automating
  around it. Config Suite's automation is most valuable where the team genuinely
  cannot lock production down.
