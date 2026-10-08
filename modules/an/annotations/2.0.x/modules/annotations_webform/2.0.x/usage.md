<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Webform makes Webforms and their submissions annotatable and shows overlay triggers during form fill.

---

Annotations Webform extends the suite to the Webform module. It provides two `#[AnnotationsTarget]` plugins: `WebformTarget` treats each webform config entity as its own annotatable target (scope key `webform__{id}`, no field-level annotations), and `WebformSubmissionTarget` shadows the generic derivative for `webform_submission` to enumerate a webform's own input elements as the annotatable field list (scope key `webform_submission__{id}`, only elements where `isInput()` is true). A `WebformFieldLabelResolver` decorates the base field-label resolver so submission-target fields show each element's `#title` instead of its machine name. Because `WebformSubmissionForm` places elements under `$form['elements'][$key]` (where the base overlay's form_alter would skip them), this module's own `form_alter` wraps each matched element in a positioning container and injects the overlay trigger. Requires `webform`, `annotations`, and `annotations_overlay`.

---

- Make each Webform an annotatable target.
- Make webform submissions annotatable per input element.
- Enumerate a webform's input elements as annotation fields.
- Resolve element `#title` labels for submission-target fields.
- Inject annotation overlay triggers into webform submission forms.
- Wrap submission elements so triggers position correctly.
- Reuse the shared overlay trigger builder.
- Skip non-input elements (containers, markup, wizard pages).
- Fall back to `#admin_title` / element key when no `#title` is set.
- Document how a specific webform should be filled in.
- Attach editorial/technical/rules notes to individual form fields.
- Support both webform config and webform_submission entity types.
- Shadow the generic target plugin for webform_submission.
- Work with the overlay's per-user type hiding and consume permissions.
- Give form-fillers in-context guidance during submission.
- Integrate cleanly without altering Webform's own behavior.
