<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Toggle adds a "Bootstrap Toggle" field widget for core boolean fields that renders the checkbox as a sliding on/off switch (via the minhur/bootstrap-toggle JS library), plus a matching read-only formatter that shows the same switch on display.

---

The module is a thin bridge between Drupal's boolean field type and the third-party Bootstrap Toggle JavaScript library. It registers a field widget (`bootstrap_toggle_switch`) and a field formatter of the same id, both restricted to the core `boolean` field type. The widget's `formElement()` builds an ordinary `#type => checkbox` and tags it with `data-toggle="toggle"` plus a set of `data-*` attributes (`data-on`, `data-off`, `data-size`, `data-onstyle`, `data-offstyle`, and optional numeric `data-height`/`data-width`) derived from the per-form-display settings; the bundled `js/bootstrap_toggle_reattach.js` behavior then calls `$('input[data-toggle="toggle"]').bootstrapToggle()` to convert those checkboxes into switches. The library itself is attached only when a form actually contains a toggle: the widget sets a `attached_toggle` flag on the form state, and `hook_form_alter()` reads that flag to attach the `bootstrap_toggle/bootstrap_toggle` library. That library declares its JS/CSS at `/libraries/bootstrap_toggle/...`, so the actual library (minhur/bootstrap-toggle 2.2.2, MIT) must be installed under the site's libraries directory — it is not shipped with the module, and `hook_requirements()` raises an error until it is found. Settings are exposed on Manage form display (and, for the formatter, Manage display): show/hide the field label, custom On/Off text, size (large/normal/small/mini), On and Off Bootstrap contextual colours (primary/success/info/warning/danger/default), and optional height/width overrides. The formatter simply reuses the widget internally, renders the same checkbox `disabled` with a `checked` attribute reflecting the stored value, and thereby shows a non-interactive switch on entity display. The module also ships a `form-element-label--toggle` template and theme-suggestion hooks so the label markup fits Bootstrap; correct appearance still depends on a Bootstrap-based theme being active where the form/display renders. Requires core `^8.9 || ^9 || ^10 || ^11`; version 2.1.1.

---

- Render a node's "Published"/"Promoted" boolean field as an on/off switch on the edit form.
- Show a custom `field_active` boolean as a Bootstrap Toggle in a content type's form.
- Give a user-profile "Receive newsletter" boolean field a switch instead of a checkbox.
- Display a boolean field as a read-only switch on the node's full view using the matching formatter.
- Label the two states with domain words ("Yes"/"No", "Live"/"Draft", "Enabled"/"Disabled").
- Colour the On state green (success) and Off state grey (default) for a status field.
- Use the danger/warning contextual colours to flag a risky boolean (e.g. "Maintenance mode").
- Pick a size (large/normal/small/mini) to fit the switch into a dense admin form.
- Hide the redundant field label so only the switch and its On/Off text show.
- Match the site's Bootstrap theme so switches look native on add/edit pages.
- Improve mobile form usability by replacing tiny checkboxes with larger touch targets.
- Present a subscription opt-in boolean as a modern toggle.
- Show a visibility/feature flag as a switch in a settings-style content form.
- Configure per-form-display so the same field looks different in different form modes.
- Override switch width/height for a boolean with long custom On/Off labels.
- Render a "Featured" flag as a coloured switch on a landing-page content type.
- Give an editorial "Ready for review" boolean an unmistakable on/off affordance.
- Use the read-only formatter to show boolean state as a switch in a teaser or table-less view.
- Replace a checkbox on a Webform-adjacent content-entity form field (boolean fields only).
- Standardise all boolean toggles across content types to one Bootstrap look.
- Combine with a Bootstrap admin theme to make the entire edit UI consistent.
- Show a two-state choice where the control itself communicates the current setting.
- Configure custom On/Off text to make an ambiguous boolean self-explanatory.
- Apply distinct On vs Off styles so the current state is obvious at a glance.
