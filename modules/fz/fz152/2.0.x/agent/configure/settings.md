<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FZ152 — configuration

All UI is under `/admin/config/system/fz152`, permission `administer fz152`. Three settings forms
plus a public privacy-policy page. No Drush; edit config directly or via the forms.

## Config objects

### `fz152.settings` (route `fz152.settings`, form `Fz152Settings`)
- `enable` (bool) — master switch; when FALSE no checkbox is injected anywhere.
- `is_checkbox` (bool) — TRUE = required checkbox; FALSE = plain informational `item` (`#markup`).
- `checkbox_title` … `checkbox_title_10` (text, HTML allowed) — the ten selectable consent labels.
  Default `checkbox_title`/`_2` are Russian consent sentences containing a `<a href="/privacy-policy">`
  link. A form line referencing number 2–10 uses the matching `checkbox_title_N`; anything else uses
  `checkbox_title`.

### `fz152.forms` (route `fz152.forms`, form `Fz152SettingsForms`)
- `forms` (text) — newline-separated list of forms to attach the checkbox to. **Line format:**
  `form_id|weight|checkbox_title_number`. `weight` and the label number are optional. `*` in the
  form id is a wildcard (compiled to `.*`). Example:
  ```
  user_register_form|100|1
  webform_submission_contact_*|110|2
  ```

### `fz152.privacy_policy_page` (route `fz152.page_settings`, form `Fz152SettingsPage`)
- `enable` (bool) — publish the policy page or not.
- `title` (string, translatable) — page title.
- `path` (string, translatable) — URL path, default `/privacy-policy`.
- `text` (text_format) — policy body; rendered as `#type => processed_text` with its stored format
  (default `basic_html`). Ships a complete Russian 152-FZ policy.

The page route is `fz152.privacy_policy_page` (permission `access content`). `Fz152RouteSubscriber`
rewrites the route path from `path`, or **removes the route** if `enable` is FALSE.

## How injection works (`fz152.module`)

`hook_form_alter` builds a newline pattern string from `Fz152Service::getForms()` (plus contact forms
when `fz152_contact` is on), then `Fz152Service::formIdMatches($form_id, $patterns)` regex-matches the
current form. On a match it adds `$form['fz152_agreement']` — a `checkbox` (`#required`, HTML5
`required` attr, `#element_validate => ['fz152_agreement_element_validate']`) or an `item`. Webforms
are handled specially (element inserted before `actions` in `$form['elements']`).
`fz152_agreement_element_validate` sets a form error until the box is checked.

## `Fz152Service` (service `fz152.service`)

- `getForms(): array` — parses `fz152.forms:forms` into `[['form_id','weight','checkbox_title'], …]`.
- `formIdMatches($form_id, $patterns): array` — `preg_match` of `$form_id` against the compiled
  newline/`*` pattern; returns the matches array (empty = no match).

## Config translation

`fz152.config_translation.yml` groups `fz152.settings`, `fz152.privacy_policy_page`, and `fz152.forms`
under one translation form (`base_route_name: fz152.settings`). Defaults ship with `langcode: ru`.
