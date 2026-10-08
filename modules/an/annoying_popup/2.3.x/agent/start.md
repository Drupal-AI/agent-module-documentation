<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annoying Popup (annoying_popup) — agent index

Shows configurable, cookie-aware popup overlays to visitors. Each popup is a **config entity** with a
rich-text body, an action button, a dismiss button, and path/language visibility rules. Popups are rendered
client-side from `drupalSettings` (jQuery); dismissal is remembered by a one-year cookie
`annoying_popup-<id>`. Version **2.3.1**. Core `^9.5 || ^10 || ^11`. Package: User interface.

## Provides
- **Config entity type** `annoying_popup` — `src/Entity/AnnoyingPopup.php` (config_prefix `annoying_popup`,
  managed at `/admin/config/system/annoying_popup`). Interface `src/AnnoyingPopupInterface.php`.
- **Service** `annoying_popup.repository` (`src/AnnoyingPopupRepository.php`) — selects popups matching the
  current path/language and builds the JS settings + cache tags.
- **Event subscriber** `annoying_popup.request_subscriber`
  (`src/EventSubscriber/AnnoyingPopupRequestSubscriber.php`) — re-sets the dismissal cookies server-side with
  a longer lifetime on each request.
- **Forms** add/edit `AnnoyingPopupForm`, delete `AnnoyingPopupDeleteForm` (`src/Form/`); list builder
  `AnnoyingPopupListBuilder` (`src/Controller/`).
- **Hook** `annoying_popup_page_attachments()` (`annoying_popup.module`) — attaches the library + settings
  when a popup matches the current page.
- **Permission** `administer annoying popups` (restricted).
- **Library** `annoying_popup/annoying_popup` (jQuery + js-cookie based JS, minimal CSS).
- **Config schema** `config/schema/annoying_popup.schema.yml`.

## Dependencies
Drupal core only (`core/drupal`, `core/jquery`). Optional integration: `eu_cookie_compliance` (defers popup
init until consent). No composer requirements beyond core.

## Routes (all require `administer annoying popups`)
- `entity.annoying_popup.collection` — `/admin/config/system/annoying_popup` (list; this is the configure
  route).
- `entity.annoying_popup.add_form` — `/admin/config/system/annoying_popup/add`.
- `entity.annoying_popup.edit_form` — `/admin/config/system/annoying_popup/{annoying_popup}`.
- `entity.annoying_popup.delete_form` — `.../{annoying_popup}/delete`.

## Solution docs
- [Config & the popup entity](config/settings.md) — entity fields, schema keys, forms, visibility rules,
  permission.
- [Rendering pipeline & cookies](api/rendering.md) — how popups are selected, injected into `drupalSettings`,
  displayed by JS, and remembered by cookies.
