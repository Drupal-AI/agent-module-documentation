# Configuration

Simple Environment Indicator has no admin form. Everything is configured by
adding one or two lines to `settings.php` (or, better, the per‑environment
`settings.local.php`). This keeps the configuration with each environment so it
deploys correctly.

## The main setting

```php
$settings['simple_environment_indicator'] = '<string>';
```

The string tells the module both the **color** and the **label** to show. If the
setting is empty or missing, no indicator is rendered. There are several formats
you can use.

### A color plus a label

Give a CSS color name or hex value, a space, then the label text:

- `'DodgerBlue Local'` — a "Local" badge on a DodgerBlue background, white text.
- `'#1E90FF DEV'` — a "DEV" badge on the given hex background, white text.

The text becomes the label; the color becomes the background, with white text.

### A foreground/background color pair plus a label

Put two colors separated by a slash to control both the text and background
colors:

- `'Black/Cyan Local'` — black text on a cyan background, labeled "Local".
- `'#333333/#DDBB00 DEV'` — the given hex text and background colors, labeled
  "DEV".

### A predefined environment color with `@`

The easiest option: write `@` followed by your environment name, and the module
picks a sensible color for you based on the **first two letters** of the name.
The label shown is the name you typed after the `@`.

| Environment name starts with… | Color used |
|---|---|
| `pr` or `li` (production, prod, live) | FireBrick red |
| `st` or `te` (staging, stage, test) | GoldenRod |
| `de` (development, dev) | blue |
| anything else (local, lando, ddev, …) | DodgerBlue |

So `'@production'` gives a red "production" badge and `'@staging'` a GoldenRod
"staging" badge, with no need to choose colors yourself.

### Higher‑contrast (accessible) colors with `#access`

Append `#access` to an `@` value to switch to a darker, higher‑contrast palette
that is friendlier for accessibility:

- `'@prod#access'` — the accessible production color. The label is still the text
  between `@` and `#access` (here "prod").

## Showing the indicator to anonymous visitors

By default the badge only appears for users who can see the toolbar or navigation
(that is, logged‑in users with the right permission). To also show it to
**anonymous** visitors — useful for making a non‑production tier obvious to
everyone — add:

```php
$settings['simple_environment_anonymous'] = TRUE;
```

Set to `TRUE`, the module injects a default banner using the colors it parsed
from your main indicator setting. Alternatively, set it to a **CSS string** to
supply your own banner styling verbatim for full control.

You would typically leave this off on production.

## Applying changes

Edit the appropriate `settings.php`/`settings.local.php` for the environment and
reload a page — the indicator updates immediately, since it is read straight from
settings at runtime. Set a different value in each environment's settings so
every tier gets its own color and label.
