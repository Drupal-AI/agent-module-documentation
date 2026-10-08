<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring private-by-default element types

## The form
Route `webform_private_elements.config` at `/admin/structure/webform/config/private` (permission **administer webform**), a **Private** local task under Webform config. `ConfigForm` lists every Webform element plugin (`plugin.manager.webform.element`) as a checkbox labelled `<id> - <label>`. Checked ids are saved (via `array_filter`) into config `webform_private_elements.settings:private`.

Default install marks private: `address`, `email`, `tel`, `webform_address`, `webform_contact`, `webform_email_confirm`, `webform_email_multiple`, `webform_name`.

## What it changes
- `hook_webform_element_default_properties_alter()`: when an element whose `id` is in the list gets its default properties, `private` is set TRUE — so newly added elements of that type start private.
- `hook_webform_element_configuration_form_alter()`: sets `default_properties['private'] = FALSE` so Webform stores the `private` value only when it is explicitly TRUE (avoids persisting a redundant default).

## Important: this module does not enforce privacy
It only toggles the *default* of Webform's own `private` property. Editors can still uncheck **Private** on an individual element. The actual access behaviour of a private element — who can see its value in the submission view, exports/downloads, tokens, and REST — is implemented and enforced by **Webform core**, not by this module. If you need to verify a private value is protected in a given channel, audit Webform core's private-property handling / submission access permissions, not this module.

## Agent notes
- Set programmatically: `\Drupal::configFactory()->getEditable('webform_private_elements.settings')->set('private', ['email'=>'email'])->save();`
- Existing elements are unaffected until re-saved; the alter only fires when default properties are built.
