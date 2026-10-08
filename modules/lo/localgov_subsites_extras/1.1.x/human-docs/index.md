# LocalGov Subsites Extras — manual setup guide

**LocalGov Subsites Extras** (`localgov_subsites_extras`) extends the **LocalGov
Drupal** subsites feature — self‑contained mini‑sites (microsites) within a larger
council site — by letting a subsite's page hierarchy be driven by the **menu
system**. Instead of a fixed structure, editors define a subsite's navigation and the
relationships between its pages through a menu, and the menu hierarchy then determines
how the pages nest and how navigation is generated.

It suits campaign and department microsites. When you build a subsite this way, the
module adds helpful CSS classes to the page — `subsite-extra` and
`subsite-extra--color-x` (where *x* is the colour theme chosen on the subsite's
overview page) — so a theme can give each subsite its own colour scheme. Child pages
inherit the theme from their parent. It also exposes a `subsite_homepage_link`
variable to the menu template so you can render a "home" link (the house‑style link
back to the subsite's front page) within the subsite navigation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration form** — there is no admin UI for its options. It
works with the LocalGov subsites content types and fields by default; the advanced
options (which node types count as subsites, and which field holds the colour theme)
can only be changed in exported configuration or in `settings.php`, described under
"Advanced" below.

## Where it lives in the admin menu

There is no dedicated settings screen. You use this module through the normal content
and menu tools:

- Create subsite pages at **Content → Add content**, choosing to create a menu link
  in the **subsites** menu and (on the overview page) a colour theme.
- Manage the subsite structure at **Structure → Menus → subsites**.
- Place a **menu block** for the subsites menu at **Structure → Block layout**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a **subsite overview page**. Choose a theme, and choose to create a menu link
   in the **subsites** menu. Save it — the page's `<body>` gets the `subsite-extra`
   and `subsite-extra--color-x` classes you can style against.
3. Add further pages, each with a menu link whose **Parent link** is the page it sits
   under. Child pages pick up the colour classes from their parent.
4. Place a **menu block** for the **subsites** menu (Structure → Block layout). Set
   its **Initial visibility level** to 2 and **Number of levels to display** to 1 so
   it shows the subsite's own navigation.
5. To render the subsite home link, add this to your menu template:

   ```twig
   {% if subsite_homepage_link %}
     {{ subsite_homepage_link }}
   {% endif %}
   ```

## Advanced (no UI)

By default the module works with the content types and fields provided by
`localgov_subsites`, but you can point it at any node type as a subsite homepage and
any field for the colour scheme. There is **no UI** for this; change it in your
exported `localgov_subsites_extras.settings` config (then import it), or override it
in `settings.php`:

```php
$config['localgov_subsites_extras.settings'] = [
  'subsite_types' => ['localgov_subsites_overview'],
  'theme_field' => 'localgov_subsites_theme',
];
```

One current limitation: the theme field must be a type that stores its value under a
`value` key (for example a string‑list field).

This module expects the base LocalGov subsites functionality to be present — use it as
part of a LocalGov Drupal site.
