<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline Formatter Field adds a boolean field whose display renders admin-authored HTML or Twig, edited in a bundled Ace code editor, with submodules that extend the same idea to whole entity displays and to Views.

---

Install and enable the module as usual (`ddev drush en inline_formatter_field`); it depends on the core **Field**, **Editor** and **Filter** modules and, on install, creates a text editor and filter format called **IFF Ace Editor** (`iff_ace_editor`). Add an **Inline Formatter** field to a bundle just like any other field — on the content form it appears as a single checkbox, and its stored value is only that boolean. The actual markup lives in **Manage display**: click the field's gear and enter any HTML or **Twig** into the *HTML or Twig Format* text area (authored in the Ace editor). When the checkbox is on, that template renders wherever the field is placed. Templates can read the host entity through a variable named after its entity type (`{{ node.field_price.value }}`, `{{ media.name.value }}`) and the viewer as `{{ current_user }}`, and Drupal tokens such as `[node:title]` also work when the **Token** module is installed (it adds a token browser to the editor). Global editor defaults — the Ace source URL/CDN, default theme and mode, and extra options — are set at **admin/config/inline_formatter_field/settings** (permission *edit inline formatter field settings*), while authoring templates requires *edit inline formatter field formats*; both are restricted-access permissions meant for trusted roles. The **Inline Formatter Display** submodule replaces an entire entity view display with such a template (a checkbox on Manage display, no field needed), and the **Inline Formatter Views Field** submodule adds a *Global: Inline Formatter* field to Views as a richer replacement for core "Custom text". Formatting note: the field formatter is also offered for the core **boolean** field type, and multiple inline formatter fields can coexist on one bundle for several independent "displays".

---

- Render a formatted block of HTML on a node only when an editor ticks a box.
- Combine several fields into one styled line with Twig, e.g. a price from amount + currency.
- Build a byline from an author reference and a date without a template override.
- Add static marketing HTML to a content type's display without touching the theme.
- Conditionally show a call-to-action based on `current_user` roles.
- Render a field a second time, in a different format, elsewhere on the page.
- Override a whole entity view display with the Inline Formatter Display submodule.
- Make a per-bundle "Twig template in the browser" without adding template files.
- Add a computed-looking summary line to a teaser using entity fields.
- Insert a rendered block or another entity via Twig Tweak's `drupal_block`/`drupal_entity`.
- Add a custom HTML/Twig column to a View with the Views Field submodule.
- Replace core "Custom text" in Views with editor-controlled markup.
- Use `[node:*]` tokens to drop entity values into a template with the Token module.
- Force a template to always render by defaulting the checkbox on and disabling the widget.
- Provide multiple selectable "displays" on one entity via several inline formatter fields.
- Attach the formatter to an existing core boolean field to render markup when it is true.
- Switch the authoring editor from Ace to CKEditor 5 by changing the default editor setting.
- Pick an Ace theme/mode (default Twig mode) and per-user editor preferences.
- Add extra Twig variables from a custom module via the context-alter hooks.
- Personalize output by checking permissions with `{% if current_user.hasPermission(...) %}`.
- Show a field only when another field has a value using Twig `{% if %}`.
- Localize output by exposing the current language through a context-alter hook.
