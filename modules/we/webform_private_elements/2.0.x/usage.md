<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Private Elements lets site administrators pick which Webform element types should have Webform's built-in "private" property switched on automatically whenever such an element is added to a form.
---
Webform already ships a per-element **Private** flag: elements marked private are only shown to users who can view any submission (e.g. admins), keeping sensitive answers out of the normal submission display. This module does not add any new access logic of its own — it only sets a default. Via `hook_webform_element_default_properties_alter` it flips `$properties['private'] = TRUE` for element types listed in `webform_private_elements.settings:private`, and via `hook_webform_element_configuration_form_alter` it initializes the private default to FALSE so the value is stored only when explicitly TRUE. The admin form at `/admin/structure/webform/config/private` (route `webform_private_elements.config`, permission `administer webform`) lists all element plugins as checkboxes; the default config marks address/email/tel and several composite name/email/contact elements private.

Security note (verified in code): enforcement of the "private" behaviour lives entirely in Webform core, not here — this module contributes no submission-view, export, REST, or token access checks. Its whole job is to pre-check the core flag for the configured element types. Whether a private value is fully protected in every channel (submission view, download/export, tokens, REST) is therefore governed by Webform core's own handling of the `private` property, not by this module. The one route is admin-gated (`administer webform`) and only writes module config.
---
- Auto-mark sensitive element types as private on new webform elements
- Default email/tel/address elements to private site-wide
- Choose which element plugins are private by default
- Reduce human error of forgetting to tick "Private" per element
- Keep the private default while still allowing per-element override
- Configure private defaults at `/admin/structure/webform/config/private`
- Standardize privacy handling across many webforms
- Mark composite name/contact/email-confirm elements private
- Ensure new PII fields inherit a private default
- Rely on Webform core to hide private values from non-admin submission views
- Export the private-defaults list via config sync across environments
- Audit which element types are set private by default
- Add or remove element types from the private-by-default list
- Apply org privacy policy to webform element creation consistently
- Pair with Webform submission-access permissions for enforcement
