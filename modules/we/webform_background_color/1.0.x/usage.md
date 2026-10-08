<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Background Color adds a background-color picker to selected webforms and applies the chosen color to the rendered form via a small CSS/JS library.
---
An admin config form (`/admin/config/webform/background-color`, `administer site configuration`) lists all webforms and lets you enable the feature for one or many (with a single/multiple selection-mode toggle), storing the selection in `webform_background_color.settings`. For each enabled webform, a form alter on the Webform settings form adds a "Background Color Settings" fieldset with a native HTML `color` element; the chosen value is saved as a webform third-party setting (`webform_background_color.background_color`).

At render time `hook_preprocess_webform` checks whether the webform is enabled, reads its stored color (default `#ffffff`), attaches the `webform_background_color/webform_background_color` library and passes the color through `drupalSettings` so the accompanying JavaScript applies it to the form's background. There are no external calls, tokens or user-input persistence beyond the admin-set color value.

Setup: enable the module, go to the config form and select the webforms that should support a background color, then edit each selected webform's Settings tab to pick its color. The color renders on the front-end wherever that webform is displayed.

---

- Add a background-color picker to selected webforms
- Choose which webforms support a background color
- Toggle single vs multiple webform selection mode
- Pick a per-webform background color on its Settings tab
- Apply the chosen color to the rendered form on the front end
- Store the color as a webform third-party setting
- Default the background to white when none is chosen
- Attach the color to the page via drupalSettings and a JS library
- Configure enabled webforms at /admin/config/webform/background-color
- Restrict configuration to administer site configuration
- Brand a specific webform with a distinct background
- Highlight a call-to-action form with a colored background
- Enable the color feature for many webforms at once
- Limit the color feature to a single webform
- Change a webform's background without editing theme CSS
- Preview the color using the native HTML color input
