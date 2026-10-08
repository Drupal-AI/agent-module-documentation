<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Conversion Tracking (webform_ct) lets a permitted editor attach custom JavaScript to a single webform's confirmation page, typically an ad or analytics conversion-tracking snippet.

---

Install it alongside the **Webform** module (`composer require drupal/webform drupal/webform_ct`, then `drush en webform_ct`). It adds no settings page of its own; instead, on a webform's **Confirmation** settings tab (`/admin/structure/webform/manage/MY-FORM/settings/confirmation`) it adds a **"Confirmation Javascript Code"** field — a CodeMirror JavaScript editor — that appears only when the confirmation type is **Page** or **Inline** (it is not supported for None, Message, Modal, URL, or URL + message). Enter your snippet **including its own `<script>…</script>` tags**, save, and the code is stored on that webform as the third-party setting `webform_ct.confirmation_custom_javascript` and emitted on the confirmation page/message when the form is submitted. The field is only visible to users who hold the dedicated permission **"Administer Webform Confirmation JavaScripts"** (`webform_ct.administer_webform_confirmation_javascript`, marked *restrict access*), which is separate from Webform's general permissions — so you grant confirmation-JavaScript editing independently of general form administration. The same value can be set programmatically with `$webform->setThirdPartySetting('webform_ct', 'confirmation_custom_javascript', '<script>…</script>')` or in a webform's exported config under `third_party_settings.webform_ct`.

---

- Fire an ad-network conversion pixel when a webform is submitted.
- Add a Google Ads / Google Analytics conversion event on confirmation.
- Add a Meta/Facebook pixel event to a form's confirmation page.
- Add a LinkedIn or TikTok conversion snippet on submit.
- Run custom analytics tracking only on the confirmation page.
- Attach a per-webform JavaScript snippet without a whole-site tag manager.
- Set the confirmation JavaScript on the Confirmation settings tab.
- Enter the snippet with its own `<script>` tags in the CodeMirror field.
- Use it with the **Page** confirmation type.
- Use it with the **Inline** confirmation type.
- Grant the "Administer Webform Confirmation JavaScripts" permission to a trusted role.
- Keep confirmation-JavaScript editing separate from general webform administration.
- Read the stored snippet via `$webform->getThirdPartySetting('webform_ct', 'confirmation_custom_javascript')`.
- Set the snippet from code with `setThirdPartySetting()` and `$webform->save()`.
- Define the snippet in a webform's exported config under `third_party_settings.webform_ct`.
- Deploy conversion tracking as configuration across environments.
- Run `drush updatedb` after updating to apply `webform_ct_update_8001`.
- Render the README as the module help page (`/admin/help/webform_ct`).
- Enable the optional `markdown` module for nicer help-page formatting.
- Install alongside `drupal/webform` (required dependency).
- Add a different tracking snippet per webform.
- Turn tracking off for a webform by clearing the field.
