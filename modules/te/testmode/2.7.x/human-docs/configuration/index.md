# Configuration

Testmode is configured from its settings form (route
`testmode.admin_settings`). You need the **Administer site configuration**
permission to open it (an administrator by default).

The point of the form is to tell Testmode *what* to alter when a test switches
it on. In practice that means:

- **Which views to filter.** You add the machine name of each view that a test
  needs to work against. When test mode is active, those views are filtered down
  to only the content items that match the test pattern — so the test sees its
  own content and not the site's real data.
- **The content pattern.** Test content (nodes, terms, users) follows an
  agreed naming convention, for example titles that begin with `[TEST]`. This is
  what Testmode uses to tell test-created content apart from live content.

## How test mode gets switched on

You do not normally toggle test mode by hand. A Behat scenario tagged
`@testmode` puts the site into test mode for the duration of that scenario, at
which point the alterations you configured here take effect. Outside of a tagged
test, the site behaves normally.

## Save

Save the form once you have listed the views and set the pattern. Remember the
overriding rule: keep Testmode scoped to test and CI environments, because when
it is active it deliberately changes content and configuration — behaviour you
never want on a production site.
