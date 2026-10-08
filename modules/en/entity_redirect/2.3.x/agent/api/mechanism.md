<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Entity Redirect fires

All logic is procedural in `entity_redirect.module` (form alter + submit handlers). No service
or plugin.

## 1. Bundle form: expose the settings

`entity_redirect_form_alter()` detects when the form's entity is a
`ConfigEntityBundleBase` (a content type, media type, vocabulary, etc.) and builds the
"Redirect after Entity Operations" fieldset under `$form['workflow']`, with a details element
per action (`add`, `edit`, `delete`, `anonymous`). An `#entity_builders` callback
(`entity_redirect_bundle_builder`) saves the values to
`third_party_settings.entity_redirect.redirect`. The **External URL** option/field is only
added when the current user has `set external entity redirects`.

## 2. Entity add/edit form: attach the submit handler

For a `ContentEntityBase` form whose bundle has `entity_redirect.redirect` set, the same
`hook_form_alter` adds a hidden `http_referer` field (for the `previous_page` option) and
appends `entity_redirect_new` (new entities) or `entity_redirect_submit` (existing) to the
submit handlers.

## 3. Submit: choose and set the redirect

`entity_redirect_submit()` loads the bundle's redirect settings and picks the applicable
action:

- anonymous user **and** `anonymous.active` → use the `anonymous` settings;
- delete form → `delete` settings (if active);
- new entity → `add` settings (if active);
- otherwise → `edit` settings (if active).

If the chosen action is inactive, it does nothing. When a non-`default` destination is chosen
it removes the `destination` query parameter, then sets the redirect via
`$form_state->setRedirect(...)` / `setRedirectUrl(...)`:

- `add_form`/`edit_form` → resolve the entity type's add/edit route.
- `created` → `entity.<type>.canonical`.
- `url` → `Url::fromUri('internal:' . $settings['url'])`.
- `previous_page` → the referrer path (parsed from the hidden `http_referer`).
- `layout_builder` → `<entity canonical>/layout`.
- `external` → a `TrustedRedirectResponse` to the external URL.

## Notes for agents

- The redirect is applied at **form submit** time only; programmatic entity saves are
  unaffected.
- `active` must be TRUE for the action or nothing happens.
- To verify a bundle is configured, read
  `<bundle_config>.third_party_settings.entity_redirect.redirect.<action>`.
