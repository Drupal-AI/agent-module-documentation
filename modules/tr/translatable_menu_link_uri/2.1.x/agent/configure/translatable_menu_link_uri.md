# Configure per-language menu link URLs

This module has **no admin settings form** (`configure` is null in the info file). "Configuring"
it means enabling translation for menu links and using the extra field it adds. It ships enabled
behavior via hooks only.

## What it adds

- A translatable, revisionable base field `link_override` (a `link` field, label
  "Translatable External Link Override") on the `menu_link_content` entity — added in
  `hook_entity_base_field_info()`, made form-configurable in
  `hook_entity_base_field_info_alter()`.
- A form alter on `menu_link_content_form`: the core **`link`** field is shown **only on the
  default language**; the **`link_override`** field is shown **only when editing a translation**.
- A `preprocess_menu` / `preprocess_menu_levels` hook that runs the
  `translatable_menu_link_uri.link_processor` service to substitute the current translation's
  `link_override` value into each rendered menu item's URL. If the override is empty, the
  original link is used.

The override is for **external / off-site URLs only** — the field description explicitly warns
not to use it for internal Drupal links.

## Dependencies (required to work)

Declared in `translatable_menu_link_uri.info.yml`:

- `drupal:menu_link_content` — the entity whose link becomes translatable.
- `drupal:content_translation` — provides the translation UI/workflow. Without it there are no
  translations, so `link_override` never applies.

## Setup — making a menu link's destination translatable

1. Enable the module and its deps:
   `drush en translatable_menu_link_uri -y` (pulls in `menu_link_content` + `content_translation`).
2. Have more than one language installed (`language` / `Interface translation` enabled and a
   second language added under **Admin → Configuration → Regional and language → Languages**).
3. Turn on content translation for menu links: **Admin → Configuration → Regional and language →
   Content language and translation**, enable translation for **Custom menu link**
   (`menu_link_content`). Ensure the `link_override` field is set translatable there if listed.

## Translating a menu link's destination

1. Edit a menu link in its **default language** (**Admin → Structure → Menus → your menu → Edit
   link**). Set the normal **Link** field here — only this field is visible on the default form.
2. Add/edit a **Translation** of that menu link (the "Translate" tab). On the translation form
   the core Link field is hidden and the **Translatable External Link Override** field is shown.
   Enter the language-specific external URL there.
3. Save. When the menu renders in that language, the link processor swaps in the override URL;
   other languages keep their own override or fall back to the default link.

## Token support (optional)

If the **Token** module is enabled, external override URLs are passed through
`token.replace()` at render time and the field's description gains a link to the available
tokens (`/admin/help/token`). No extra configuration is needed beyond enabling Token.

## Menu Item Extras

A separate `preprocess_menu_levels` hook processes nested/child links produced by the Menu Item
Extras module, so overrides apply in those menus too. No configuration required.
