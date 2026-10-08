# Configure — settings.php only

simplei has **no** admin UI, config entity, or config object. You configure it by adding a line to
`settings.php` (or `settings.local.php`). Read at runtime with
`\Drupal\Core\Site\Settings::get('simple_environment_indicator')`.

## `$settings['simple_environment_indicator']`

A single string, parsed by `IndicatorParser::parse()` into `[foreground, background, label]`.
Formats:

| Example | Result |
|---|---|
| `'DodgerBlue Local'` | background = the color, foreground = white (`#ffffff`), label = `Local`. |
| `'#1E90FF DEV'` | hex background, white text, label `DEV`. |
| `'Black/Cyan Local'` | `foreground/background` pair (split on `/`), label `Local`. |
| `'#333333/#DDBB00 DEV'` | hex fg/bg pair, label `DEV`. |
| `'@production'` | predefined color by environment name (see below). |
| `'@prod#access'` | predefined **accessible** (darker, higher-contrast) color. |

Empty/unset → no indicator rendered.

### `@<environment>` predefined colors (matched on the first two letters)

| First 2 letters (examples) | Normal bg | `#access` bg |
|---|---|---|
| `pr`, `li` (production, prod, prd, live) | `FireBrick` | `#8b0000` |
| `st`, `te` (staging, stage, stg, test) | `GoldenRod` | `#59590d` |
| `de` (development, dev) | `#0057ad` | `#005b94` |
| anything else (local, lando, ddev, …) | `DodgerBlue` | `#4a0080` |

Foreground is always white for `@` indicators; the label shown is the text after `@` (before
`#access`).

## `$settings['simple_environment_anonymous']`

Show an indicator to **anonymous** users too (normally it only shows for users who can access the
toolbar/navigation):

- `TRUE` → injects a default `<style>` banner (`body:after { content: "[<env>]"; … }`) using the
  parsed colors.
- a **string** → used verbatim as the CSS for the anonymous banner (full control).

Typically you would not enable this on production.

## Rendering prerequisites

The logged-in indicator needs either core **`navigation`** (top bar) or classic **`toolbar`**
enabled, and the user must have the corresponding access permission. With `navigation` active the
TopBarItem plugin renders it; otherwise the toolbar JS library does.
