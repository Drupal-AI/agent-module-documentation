# Formdazzle! — manual setup guide

**Formdazzle!** (`formdazzle`) is a front-end developer's helper that makes
**form theming** in Drupal far easier. Out of the box, Drupal gives you only
broad Twig template suggestions for form elements — for example
`input--textfield.html.twig`, which would style *every* text field on the whole
site the same way. Formdazzle adds much more specific suggestions that include
the **form ID** and the **element name**, so you can style one field on one form
with its own dedicated template.

For instance, once Formdazzle is enabled you can create a template named
`input--textfield--webform-contact--first-name.html.twig` to restyle *only* the
First name field on *only* the Contact webform, leaving every other text field
untouched. The same granularity applies to selects, checkboxes, buttons,
fieldsets, labels, and form-element wrappers.

The module adds no settings and produces no output of its own — it purely
enriches the list of theme suggestions Drupal offers. It also does a few thoughtful
extras: it simplifies awkward machine form IDs (webforms become `webform_<id>`,
Views exposed forms fold in the View name and display, numeric commerce form IDs
are tidied up), and when Twig debug is on it reveals the suggestions for the
top-level form template that core normally hides.

This guide is written for a **human** working in a theme. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Formdazzle has no admin pages and nothing to configure. It works the
moment you enable it. Everything you do with it happens in your theme's
`templates/` directory.

## How to use it

**Step 1 — Turn on Twig debug so you can see the suggestions.** In your
`sites/default/services.yml` (or a development services file), set:

```yaml
parameters:
  twig.config:
    debug: true
```

then clear the cache (`drush cr`). With debug on, Drupal prints the available
template suggestions as HTML comments in the page source.

**Step 2 — Find the suggestion you want.** View the source of a page containing
your form and look for a comment such as:

```html
<!-- * input--textfield--webform-contact--first-name.html.twig -->
```

Formdazzle's suggestions follow the pattern
`<theme-hook>--<form-id>--<element-name>` (underscores in machine names become
dashes in the file name). The most specific suggestion is listed, along with less
specific fallbacks.

**Step 3 — Create the template.** Copy the relevant core template (for a text
field, `core/modules/system/templates/input.html.twig`) into your theme's
`templates/` directory and rename it to match the suggestion, for example
`input--textfield--webform-contact--first-name.html.twig`. Edit its markup, then
clear the cache (`drush cr`). That single field now renders through your
template; nothing else is affected.

The same approach works for `select--…`, `form-element--…`,
`form-element-label--…`, `fieldset--…`, and button templates like
`input--submit--…`. Labels and form-element wrappers get matching suggestions
too, so you can target them the same way.
