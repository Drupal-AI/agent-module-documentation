Simple Environment Indicator (simplei) shows a small colored environment label (Local/DEV/Staging/Production) in Drupal's Toolbar or core Navigation top bar, configured entirely from a single `$settings` line in `settings.php` — no database config, forms, or permissions.

---

You set `$settings['simple_environment_indicator']` in `settings.local.php`/`settings.php` to a short string; the `IndicatorParser` service turns it into a foreground color, background color, and environment label. Accepted formats: a CSS color name or hex plus a label (`'DodgerBlue Local'`, `'#1E90FF DEV'`), a foreground/background pair (`'Black/Cyan Local'`, `'#333333/#DDBB00 DEV'`), or `@<environment>` to use a predefined color where the first two letters of the name are matched — `pr`/`li` (production/live) → FireBrick, `st`/`te` (staging/test) → GoldenRod, `de` (development) → a blue, anything else → DodgerBlue; appending `#access` (`'@prod#access'`) switches to a higher-contrast dark palette. Rendering adapts to the environment: when core `navigation` is active for the user, an `EnvironmentIndicator` **TopBarItem plugin** (`simplei_environment_indicator`) draws the label in the navigation top bar; otherwise, if `toolbar` is enabled, `hook_page_attachments()` injects the indicator into the toolbar via `drupalSettings` + the `simplei/simplei` JS library (the module avoids showing it twice). Setting `$settings['simple_environment_anonymous'] = TRUE` (or a custom CSS string) also shows an indicator to anonymous users via an injected `<style>` block. The module is deliberately tiny: three classes, no config entity, no settings form.

---

- Show a red "Production" badge in the toolbar so editors know they are on live.
- Mark a staging site with a distinct GoldenRod indicator to prevent mistakes.
- Label a local dev environment (e.g. "Local", "DDEV") with a blue indicator.
- Use `@production` to get a sensible predefined color without choosing hex values.
- Use `@prod#access` for a higher-contrast, more accessible production color.
- Set a custom foreground/background pair like `Black/Cyan Local` for brand colors.
- Use a hex background with white text via `#1E90FF DEV`.
- Differentiate multiple environments (dev/stage/prod) each with its own color and label.
- Display the indicator in core Navigation's top bar (Drupal 11 navigation module).
- Fall back to Drupal's classic Toolbar indicator when navigation is not used.
- Show an environment banner to anonymous visitors on non-production tiers.
- Provide a fully custom CSS banner for anonymous users via a CSS string setting.
- Keep environment configuration in settings.php so it deploys per-environment automatically.
- Avoid database/config overhead by driving the indicator purely from settings.
- Reduce "which environment am I on?" errors for content teams.
- Work alongside the Gin admin theme's toolbar styling.
- Programmatically compute an environment's colors with the IndicatorParser service.
- Give test/QA environments an unmistakable visual marker.
- Prevent accidental edits on production by making the environment obvious at a glance.
- Standardize environment colors across many sites using the `@name` shorthand.
- Add an indicator without granting or managing any permissions.
- Ship a lightweight alternative to the heavier Environment Indicator module.
