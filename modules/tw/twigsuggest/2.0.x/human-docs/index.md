# Twig Template Suggester — manual setup guide

**Twig Template Suggester** (`twigsuggest`) is a themer's convenience module. It
adds the **template suggestions** that Drupal core (and many contrib modules)
leave out, so you can theme things that would otherwise need custom preprocess
code. A "suggestion" is one of the alternative template filenames Drupal will
look for when rendering something — for example, out of the box you can't easily
give every node type its own page template, but with this module enabled you can
just drop a `page--node--article.html.twig` into your theme and it works.

Once enabled, it contributes a large set of extra suggestions across **blocks**
(per region, per custom‑block bundle, per provider or menu), **pages and
html** (per node type), **users** (per user ID, per highest role, per view
mode), **fields** (per field, view mode, and bundle — and per entity‑reference
target type), **taxonomy terms**, **forms, form elements and inputs** (per form
ID, region, element ID, or type), **containers**, **menus and book trees** (per
region), and **menu local actions**. It also cleans up duplicate block
suggestions that core produces, and exposes a handy `base_path` variable to every
template so you can build root‑relative asset URLs like
`{{ base_path ~ directory }}/images/icon.svg`.

There is **no admin interface** — the module simply does its work the moment it
is enabled, and it installs itself at a high weight so its suggestions take
precedence over other modules'. To *use* a suggestion you create the matching
`.html.twig` file in your theme's `templates/` directory and rebuild caches. The
only setting is an optional Display Suite compatibility flag, described below,
which is set in configuration rather than through a form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Twig Template Suggester has no menu item, no settings page, and no
permissions. It is a pure theme‑layer module that works automatically once
enabled.

## How to use it

1. **Enable the module** (see [Installation](installation/index.md)).
2. **Find the suggestion you want.** Turn on Twig debugging (in your site's
   `sites/default/services.yml`, set `twig.config.debug: true`, then rebuild
   caches). Drupal then prints the full list of candidate template names as HTML
   comments around each element, including the new ones this module adds.
3. **Create the template.** Copy the base template into your theme's
   `templates/` directory and rename it to the suggestion you want — remembering
   that double underscores in the suggestion become `--` in the filename
   (`block__region__sidebar` → `block--region--sidebar.html.twig`). More specific
   names win over less specific ones.
4. **Rebuild caches** (`drush cr`) so Drupal picks up the new file.

A few examples of what becomes possible: a shared template for every block in a
region (`block--region--sidebar.html.twig`), a per‑node‑type page template
(`page--node--article.html.twig`), a user template keyed by role
(`user--administrator.html.twig`), a field template per view mode and bundle
(`field--article--field_x--teaser.html.twig`), a form template by form ID
(`form--user-login-form.html.twig`), and a menu template per region
(`menu--footer.html.twig`). The full catalogue of suggestions lives in the
[`agent/theming/suggestions.md`](../agent/theming/suggestions.md) reference.

### The one optional setting

The module has a single knob, `alternate_ds_suggestions`, which turns on an
optional **Display Suite** layout‑suggestion fix (rewriting DS layout names so a
`layout--onecol.html.twig`‑style override resolves). It is **off by default** and
there is no form for it. The recommended way to enable it is in your site's
`settings.php`:

```php
$config['twigsuggest.settings']['alternate_ds_suggestions'] = TRUE;
```

You only need this if you use Display Suite layouts and want to override them by
template; leave it off otherwise.

### Helper for module developers

The module also provides a small service, `twigsuggest.helper_functions`, whose
`getCurrentNode()` method resolves the current node across canonical, preview,
and revision routes. It powers the page/html per‑node‑type suggestions, and you
can call it from your own code if you need the same resolution.
