# Static Setting Contexts — manual setup guide

**Static Setting Contexts** (`static_setting_contexts`) is a developer-focused
bridge that turns values defined through the `owenbush/static-settings` PHP library
into a Drupal **Condition plugin**. In plain terms: you define a setting in code —
typically something resolved from your environment or deployment state, like "site
mode = prod / staging / dev" — and this module lets you use that value as a
visibility condition anywhere Drupal's Condition system is used, most commonly for
**block visibility** or Layout Builder section visibility.

The appeal is that these settings are resolved in **PHP, not the database**. That
makes them fast (no config or storage lookup), keeps your environment logic in code
review as enums rather than editorial config, and gives you contexts that are
consistent across every request in an environment. Typical uses are feature flags,
A/B or rollout toggles, per-tier or per-tenant modes, and hiding experimental UI
behind a code-defined switch.

Under the hood the module defines a plugin type (`static_setting_contexts`): each
"static setting" is a PHP `enum` whose cases are the possible values, placed in your
module's `src/Plugin/StaticSettings/` directory. It ships one Condition plugin,
**Static Settings**, which renders a checkbox group per defined setting and, when
evaluated, compares the live value against your selection (multiple settings are
combined with AND, and negation is supported).

Because this is a code-level tool, there is **no admin UI, no permissions, and no
Drush commands** to configure — you define settings in code, and one important
setup detail is that Composer's autoloader must be aware of your
`Plugin/StaticSettings` namespace (see below). Everything else you do through
Drupal's normal condition/visibility UI.

This guide is written for a **human** (here, a developer). If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside the
   `owenbush/static-settings` library, then enable the module.

## Where it lives in the admin menu

Nowhere directly — the module adds no admin pages. Once you have defined at least
one static setting in code, a **Static Settings** condition appears in the standard
condition/visibility UI (for example on a block's *Visibility* settings).

## How to use it

### 1. Define a static setting (an enum plugin)

Create `src/Plugin/StaticSettings/SiteMode.php` in your module. It is a backed PHP
`enum` implementing the static-settings package's `BaseStaticSettingInterface`,
annotated with this module's `#[StaticSettings]` attribute:

```php
namespace Drupal\my_module\Plugin\StaticSettings;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\static_setting_contexts\Attribute\StaticSettings;
use StaticSettings\BaseStaticSettingInterface;

#[StaticSettings(
  id: 'site_mode',
  label: new TranslatableMarkup('Site Mode'),
  description: new TranslatableMarkup('Current environment mode.'),
)]
enum SiteMode: string implements BaseStaticSettingInterface {
  case Prod = 'prod';
  case Staging = 'staging';
  case Dev = 'dev';
}
```

The enum's cases become the condition's checkbox options. See the
`owenbush/static-settings` documentation for how a setting's live value is actually
resolved from your environment or deployment state.

### 2. Make the namespace autoloadable (required)

The static-settings library resolves settings through its own mechanism, which
needs your namespace to be autoloadable. Add a PSR-4 entry to your project's or
module's `composer.json`:

```json
"autoload": {
  "psr-4": {
    "Drupal\\my_module\\Plugin\\StaticSettings\\": "web/modules/custom/my_module/src/Plugin/StaticSettings"
  }
}
```

Then run `composer dump-autoload`. Skipping this step is the most common reason a
setting does not appear.

### 3. Use it as a condition

Once at least one setting exists, the **Static Settings** condition shows up
wherever core Conditions are used — for example under a block's **Visibility**
settings. It renders one checkbox group per defined setting; tick the values that
should allow the block to show. At evaluation time the module reads the live value
and checks whether it is among your selected values. You can combine several
settings (they are ANDed together) and negate the condition (show *unless* the
setting has a given value).
