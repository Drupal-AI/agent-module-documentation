# dropdown_language — agent start

Provides a **block** ("Dropdown Language", plugin id `dropdown_language`, block category
*Dropdown Language*) that renders the site's language switch links as a core **Dropbutton
dropdown** instead of core's plain `<ul>` switcher. The block plugin is **derived per
configurable language type** (Interface / Content / URL / …), so you place one dropdown per
negotiation type. It is only shown on multilingual sites (2+ languages) and self-hides on
403/404 pages. Requires core `language` + `block` only. No permissions, no Drush, no
external libraries.

Global config UI: **Admin → Configuration → Regional and language → Dropdown Language
Switcher** — path `/admin/config/regional/dropdown-language-switcher`, route
`dropdown_language.setting`, permission `administer site configuration`.

- Global label style, fieldset decor, SEO filtering, always-show, plus per-block custom
  labels and how to place the block → [configure/dropdown_language.md](configure/dropdown_language.md)
