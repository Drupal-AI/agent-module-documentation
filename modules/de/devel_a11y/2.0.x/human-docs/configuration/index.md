# Configuration

Devel Accessibility works the moment it is enabled — all three aids default to
**on**. The settings form simply lets you switch each one off if it is noisy or
getting in your way.

## Open the settings form

1. Log in as a user with Devel's **Access developer information**
   (`access devel information`) permission.
2. Go to **Configuration → Development → Devel → Accessibility**, or navigate
   directly to `/admin/config/development/devel/a11y`.

The settings are stored in the `devel_a11y.settings` configuration object, so you
can also read and change them with `drush cget`/`drush cset` and export them as
config.

## The three aids

Each aid is a simple on/off toggle.

- **Log announcements** *(on by default)* — writes every `Drupal.announce()` call
  to the browser console. `Drupal.announce()` is how Drupal tells a screen reader
  that something changed (for example, "3 results found" after an AJAX update).
  With this on, you can watch those messages fire in the console and confirm they
  happen once — not on every keystroke — and at the right moment. Corresponds to
  the `aural.announce.log` setting.

- **Log tabbing manager activity** *(on by default)* — writes tabbing-manager
  events to the console. The tabbing manager is what constrains keyboard focus to
  part of the page when a modal or off-canvas dialog opens. Logging it helps you
  see when it engages and releases. Corresponds to
  `keyboard.tabbingmanager.log`.

- **Visualize the tabbing constraint** *(on by default)* — draws the current
  tabbing constraint directly on the page, so you can *see* which region has
  keyboard focus trapped. This is the quickest way to diagnose a focus trap that
  never releases or a dialog that fails to constrain tabbing. Corresponds to
  `keyboard.tabbingmanager.visualize`.

## Save

Click **Save configuration**. Changes take effect on the next page load. Because
the announcement log is console-only, there is no server-side record — open your
browser's developer console to see the output.

### Doing it from the command line

```bash
drush cget devel_a11y.settings
drush cset devel_a11y.settings keyboard.tabbingmanager.visualize false -y
```
