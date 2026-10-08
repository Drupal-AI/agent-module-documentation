<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config & the popup entity

## Install
`drush en annoying_popup -y`. No dependencies beyond core. Manage popups at
`/admin/config/system/annoying_popup` (route `entity.annoying_popup.collection`, the `configure` link).
All routes require the restricted permission **`administer annoying popups`**
(`annoying_popup.permissions.yml`).

## Entity
`annoying_popup` is a `ConfigEntityType` (`src/Entity/AnnoyingPopup.php`, extends `ConfigEntityBase`),
`config_prefix: annoying_popup`, `admin_permission: administer site configuration`. Handlers: list builder
`AnnoyingPopupListBuilder`, forms `add`/`edit` → `AnnoyingPopupForm`, `delete` → `AnnoyingPopupDeleteForm`.

`config_export` / stored keys (schema in `config/schema/annoying_popup.schema.yml`,
type `annoying_popup.annoying_popup.*`):
- `id` (string, machine name), `label` (string).
- `enabled` (bool) — disabled popups are skipped entirely.
- `content` — mapping `{ value: text, format: string }`. This is a **text-format** field; `format` is the
  chosen text format (its filters are applied at render time — see `api/rendering.md`).
- `action_button` — mapping `{ title, url, open_in_new_window: bool }`.
- `dismiss_button` — mapping `{ title }`.
- `visibility` — mapping:
  - `request_path` `{ pages: text, negate: bool }` — path patterns (one per line, `*` wildcard, `<front>`);
    `negate` false = show only on listed pages, true = hide on listed pages.
  - `languages` `{ langcodes: sequence<string>, negate: bool }` — language selection with the same
    show/hide negation.

Accessors on the entity: `getContent()/setContent()`, `getEnabled()/setEnabled()`,
`getActionButton()/setActionButton()`, `getDismissButton()/setDismissButton()`,
`getVisibility()/setVisibility()`, and `getCacheTag()` (returns `annoying_popup:<id>`).

## Add/edit form (`AnnoyingPopupForm`)
Fields: `label` (required), `id` (machine_name), `enabled` (checkbox), `content` (`#type => 'text_format'`),
`action_button` (url + title + open_in_new_window; url/title become required for each other via `#states`),
`dismiss_button` (title, required, default "Dismiss"), and the visibility fieldsets (pages textarea + negate
radios; language checkboxes + negate radios). `validateForm()` validates a non-empty action-button URL with
`UrlHelper::isValid()` (absolute when it starts with `http(s)://`). `save()` writes the entity and invalidates
the popup's cache tag; on save the messenger reports created/updated.

## Delete
`AnnoyingPopupDeleteForm` extends `EntityConfirmFormBase` — a standard confirm form
(`/admin/config/system/annoying_popup/{id}/delete`) that deletes the entity and redirects to the collection.

## Example config export
```yaml
# annoying_popup.annoying_popup.promo.yml
id: promo
label: 'Spring promo'
enabled: true
content:
  value: '<p>Spring sale — 20% off!</p>'
  format: basic_html
action_button:
  title: 'Shop now'
  url: '/sale'
  open_in_new_window: false
dismiss_button:
  title: 'No thanks'
visibility:
  request_path:
    pages: "<front>\n/blog/*"
    negate: false
  languages:
    langcodes: {  }
    negate: false
```
