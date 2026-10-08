# Styles API — manual setup guide

**Styles API** (`styles_api`) is a small developer framework that lets modules and
themes register named, reusable "styles". Each style is a template (or an existing
theme hook) plus some metadata — a label, an optional category, and a preview
icon — exposed through a `Style` plugin type. Other code can then list the available
styles (for example as options in a select element) and render content through the
style the user picks. It is modelled on core's Layout Discovery, so if you have
worked with layouts the shape will feel familiar.

Think of it as the plumbing for a "styles" feature: a card-style or callout-style
library, a set of region or element treatments, or any catalogue of named visual
options that both modules and themes can contribute to. A provider (module *or*
theme) can register styles two ways — as annotated PHP plugins in
`src/Plugin/Style/`, or, with no plugin class at all, as YAML entries in a
`<provider>.themes.yml` file. A style that declares a `template` is registered with
`hook_theme()` for you automatically, so in many cases you only need to ship a Twig
file.

Styles API ships **no admin UI, no configuration, no permissions and no Drush
commands** — it is purely an API other modules and themes build on. On its own it
does nothing visible; its value shows up when another feature uses it to offer a
style picker. Consuming code gets the plugin manager service
(`plugin.manager.styles_api`) and calls methods like `getDefinitions()` or
`getStyleOptions()` to enumerate styles and render through them.

This guide is written for a **human** developer. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no admin interface. You work with Styles API from code, in a module or
theme.

**Register a style** — the simplest route is a YAML entry in your provider's
`<provider>.themes.yml` file, which needs no PHP class:

```yaml
my_callout:
  type: element
  label: 'Callout'
  category: 'Cards'
  template: my-callout
  path: templates
```

Then ship `templates/my-callout.html.twig`. Because the entry declares a
`template`, Styles API registers the theme hook for you. A style may instead point
at an existing `theme` hook you register yourself — but `template` and `theme` are
mutually exclusive, so use one or the other. The same style can be registered from a
theme's `.themes.yml`, which lets themes add or override styles that modules
provide. If a style needs behaviour or configuration, use an annotated `@Style`
plugin in `src/Plugin/Style/` extending `StyleBase` instead.

**List and render styles** — from consuming code, get the manager and enumerate:

```php
$manager = \Drupal::service('plugin.manager.styles_api');

// All style definitions, keyed by id:
$defs = $manager->getDefinitions();

// Options for a select element (id => label):
$options = $manager->getStyleOptions();

// Grouped by category (category => [id => label]):
$grouped = $manager->getStyleOptions(['group_by_category' => TRUE]);
```

You can then render content through the chosen style's template, and alter the
discovered set with `hook_styles_alter()`. After adding or changing styles, run
`drush cr` so discovery picks them up.

One gotcha worth knowing: avoid the deprecated static helpers
`Style::getStyleOptions()` / `Style::getThemeImplementations()` — they reference a
mistyped accessor and will fatal. Always go through the `plugin.manager.styles_api`
service, as shown above. The sibling
[`agent/plugins/style.md`](../agent/plugins/style.md) and
[`agent/api/manager.md`](../agent/api/manager.md) docs cover the full property list
and manager API.
