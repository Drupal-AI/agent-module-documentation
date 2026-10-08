# Build a webform

A webform is a config entity `webform.webform.<id>` (`config/install`-exportable). Elements are
stored as a nested YAML tree under the `elements` key, each keyed by machine name with an
`#type` (a WebformElement plugin) and `#`-prefixed properties (mirroring Drupal Form API).

## UI
`/admin/structure/webform` → **Add webform** → then **Build** tab.
- The drag-and-drop element builder is provided by the **webform_ui** submodule (install it to
  add elements via forms instead of raw YAML).
- **Source (YAML)** tab (`edit webform source` permission) edits the `elements` tree directly.
- **Settings** tab: form open/close dates, submission limits, confirmation message/URL, draft
  saving, wizard/pages behavior, CSS/JS assets, third-party settings.

The webform collection at `/admin/structure/webform` (here with the example forms installed):
![Webforms list](../../../../../../../screenshots/webform/6.3.x/webform-list.png)

The **Build → Elements** tab (webform_ui): each row is an element with its Title, machine Key,
`#type`, Required flag, and drag handle; Add element / Add page / Add layout above, Save/Reset below:
![Webform build elements](../../../../../../../screenshots/webform/6.3.x/build-elements.png)

The **Settings** tab (General shown) — title, description, page/path, and the categories of
behavior listed above down the form:
![Webform form settings](../../../../../../../screenshots/webform/6.3.x/form-settings.png)

## Elements (YAML)
```yaml
elements:
  name:
    '#type': textfield
    '#title': 'Your name'
    '#required': true
  email:
    '#type': email
    '#title': 'Email'
  wants_call:
    '#type': checkbox
    '#title': 'Call me back'
  phone:
    '#type': tel
    '#title': 'Phone'
    '#states':                 # conditional logic
      visible:
        ':input[name="wants_call"]': { checked: true }
```
- Many element types: textfield, email, tel, select, checkboxes, radios, date, datetime,
  managed_file, webform_address, webform_name, signature, likert, computed_twig,
  webform_wizard_page (multistep), webform_section, container, fieldset, and composites.
- `#states` (visible/invisible/required/enabled/disabled…) implement conditional logic against
  other inputs — no code needed.
- Reusable option lists are `webform_options` config entities (`/admin/structure/webform/options`),
  referenced by `'#options': my_list`.

## Where data goes
Each submit creates a `webform_submission` entity (see [handlers.md](handlers.md) for routing and
export). Review at `/admin/structure/webform/manage/<id>/results/submissions`.
