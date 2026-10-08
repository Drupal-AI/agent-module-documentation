# Behat javascript — agent index

**Testing-only** module (do not install in production). Captures browser JS errors during Behat/Mink
`@javascript` (Selenium2) scenarios and fails the step when unignored errors occur. Requires
`drupal/drupal-extension`. Provides a config schema; no permissions of its own, no Drush, no plugins.

- **The `ignored_errors` setting form, route, config key** → [configure/settings.md](configure/settings.md)
- **The Behat subcontext: how errors are captured, filtered, and how scenarios fail; tags** →
  [api/behat-context.md](api/behat-context.md)

Key facts:
- `hook_page_attachments` attaches library `behat_javascript/errors` (`assets/js/window_errors.js`) to
  every page; it registers `window.onerror` → pushes into global `window.jsErrors`.
- Subcontext `BehatJavascriptContext` (`behat_javascript.behat.inc`) reads `window.jsErrors` after each step.
- Config: `behat_javascript.settings:ignored_errors` — newline-separated regex patterns.
