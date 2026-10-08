# Configuration

Extend Help Maintainers works out of the box — everything on this page is
**optional**. The settings let you decide **which sources** maintainer data is
fetched from, and **which source wins** when the same maintainer appears in more
than one. If you never open this form, the module still gathers and displays
maintainers using its defaults.

## Open the settings form

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → System → Extend Help Maintainers**, or navigate directly
   to `/admin/config/system/extend-help-maintainers`.

## Fetcher plugins

The form lists the available **fetcher plugins** — the sources maintainer data can
come from. For each one you can:

- **Enable or disable** the fetcher. Disable a source you don't want consulted (for
  example, turn off the Drupal.org fetcher if you prefer to rely only on what's
  declared in each module's `.info.yml`, or to avoid the network lookup).

The fetchers that ship with the module are:

- **Info YAML Fetcher** — reads maintainers declared in a module's own `.info.yml`
  file (under `extra.extend_help_maintainers.maintainers`). This is treated as the
  most authoritative source by default.
- **Drupal.org Fetcher** — retrieves maintainers from the module's Drupal.org
  project page. Useful for modules that don't declare their own maintainers, but it
  performs a network lookup (results are cached, 24 hours by default).

If custom fetcher plugins have been added in code, they appear in this list too.

## Priorities

Because more than one source can name the same maintainer, each source has a
**priority**. When maintainers are merged, the higher-priority source's version of
a duplicate takes precedence — so its name, avatar, and profile link are the ones
shown. Adjust a source's priority here to change which one wins. By default the Info
YAML source outranks the Drupal.org source.

## Save

Click **Save configuration**. Your changes take effect on the next render of a
module help page; because results are cached for 24 hours, you may want to clear
caches if you want to see a change immediately.
