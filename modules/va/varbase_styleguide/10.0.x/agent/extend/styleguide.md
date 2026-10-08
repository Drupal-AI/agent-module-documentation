<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Varbase Styleguide extends the style guide

All behaviour is in `varbase_styleguide.module` (procedural — no `src/`, no OOP hook class).
Three hooks plus an install recipe.

## `hook_styleguide_alter(&$items)`

The main hook. Runs when the Styleguide module builds its page. It does two things:

1. **Swaps the preview image.** Writes the bundled `images/flag-earth.jpg` to
   `public://flag-earth.jpg` (via `file.repository` `writeData`, `FileExists::Replace`) and,
   for any item whose `content['#uri']` is `public://styleguide-preview.jpg`, repoints it to
   `public://flag-earth.jpg`.
2. **Adds a Varbase group.** Registers `$items['varbase_bootstrap_atoms']` with
   `group => 'Varbase'`, `title => t('Bootstrap elements')`, and a big block of static
   Bootstrap 5 markup rendered through an `inline_template` element
   (`'{{ bootstrap_elements|raw }}'`). The markup is hardcoded (no user input) and covers
   navbars, buttons, typography, blockquotes, tables, forms, navs/tabs/pills, breadcrumbs,
   pagination, alerts, badges, progress bars and list groups.

To add your own examples in a downstream module, implement the same hook and add another
`$items['my_key'] = ['group' => '…', 'title' => t('…'), 'content' => [...]];` entry.

## `hook_page_attachments(&$page)`

Attaches the CSS library `varbase_styleguide/general-styles` on any route whose name matches
`/^styleguide./` (i.e. the style guide pages). The library is defined in
`varbase_styleguide.libraries.yml` and loads
`css/theme/varbase-styleguide-general-styles.theme.css`.

## `hook_help($route_name, $route_match)`

Standard help text on the module's help page. No behaviour.

## Install recipe

`hook_install()` runs the bundled recipe at `recipes/default` (via
`Recipe::createFromDirectory` + `RecipeRunner::processRecipe`). That recipe
(`recipes/default/recipe.yml`, type `install`) installs the `vmi` (View Modes Inventory)
module. `varbase_styleguide_update_90001()` is a no-op left in place from the 9.x branch.

## What it does NOT provide

No routes, controllers, forms, config entities, config schema, permissions, plugin types or
Drush commands. It only contributes content to the Styleguide module's existing page and
attaches CSS. Viewing the page requires the Styleguide module's `access styleguide`
permission.
