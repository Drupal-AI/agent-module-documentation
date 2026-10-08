# Configuration

Language Switcher Menu is configured on one small settings form, plus two
permissions. This page walks through both, then shows how to theme the links.

## Open the settings form

1. Log in as a user with the **configure language_switcher_menu** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Language Switcher Menu**, or
   navigate directly to `/admin/config/regional/language_switcher_menu`.

The form has three fields.

### Language type

Choose which of Drupal's **language types** the switch links should act on. The
options come from your site's configured language types — typically **Interface**
(`language_interface`), and also **Content** and **URL** where those have been made
configurable. Interface language is the usual choice. This field is required.

### Parent

Choose where in your menus the links appear. The options list every menu and menu
item on the site in the form *menu → item*:

- Pick a specific menu item to nest the language links **beneath** it (for example
  under an existing "Language" entry).
- Pick a menu itself (the root option for that menu) to place the links at the
  **top level** of that menu.
- Pick **Disabled** (the empty option) to switch the feature off without
  uninstalling — the module then produces no links. Re‑select a parent to bring
  them back.

The module's own links are filtered out of this list so you can't nest them inside
themselves.

### Weight

The menu **weight** of the *first* language link. Each additional language link is
given the next weight up (+1), so they stay in order. Use this to position the group
relative to your other menu items — lower weights sort earlier.

Click **Save configuration**. The form rebuilds the menu tree automatically so your
changes appear right away.

> The links only actually generate when the site is multilingual **and** both a
> language type and a parent are set. If you don't see them, confirm you have two or
> more languages configured and that the parent is not set to *Disabled*.

## Permissions

The module adds two permissions under **People → Permissions**:

- **configure language_switcher_menu** — who may open and save the settings form
  above. Grant it to administrators.
- **view language_switcher_menu links** — who actually *sees* the generated links.
  This one is essential: due to a Drupal core issue the links are hidden by default,
  and the module's built‑in workaround only reveals them to roles that hold this
  permission. Grant it to **Anonymous** and **Authenticated** (or whichever roles
  should switch languages) or the menu will look empty.

> Behind the scenes the visibility workaround overrides a core menu service. If
> another module on your site also overrides that same service, the two can
> conflict — something to keep in mind when debugging missing or duplicated links.

## Theming the links

The language links are ordinary menu items, so they render through your theme's
`menu.html.twig`. If you want to style them differently from normal links, you can
recognize them in Twig by their plugin id prefix
`language_switcher_menu.language_switcher_link:` and read the language object from
the link's options — for example to output a `lang` attribute and a short
abbreviation like "EN" or "FR". You can also alter the links programmatically from a
custom module using core's standard `hook_language_switch_links_alter()`.
