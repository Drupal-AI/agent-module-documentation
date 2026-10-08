# Configuration

Float Labels has a single, simple settings form. Its main job is to let you list
the **form IDs** you want the floating-label effect applied to.

## Open the settings form

1. Log in as a user who can administer site configuration (an administrator by
   default).
2. Reach the Float Labels settings form from the module's **Configure** link on the
   **Extend** page (**Extend → Float Labels → Configure**), or from its entry under
   **Configuration**.

## Which forms to apply it to

- **Form IDs** — enter the machine IDs of the forms you want floating labels on
  (for example a contact form, a login form, or a custom webform). Only the forms
  you list here are affected, so you can adopt the pattern gradually rather than
  site-wide. This is the one field you normally need to set.

To find a form's ID, inspect the rendered form's HTML (the `<form>` element's `id`
attribute) or check the form-building code; enter that value here.

## Styling

Beyond listing form IDs, the only other work is optional **styling** for your
specific theme — the module ships the behaviour and the CSS3 transitions, and you
adjust the look with your theme's CSS if the defaults do not match your design.

## Accessibility check

After applying the effect, verify with a screen reader (or by inspecting the
markup) that each floating label is still a real `<label>` associated with its
input — not just placeholder text. The floating pattern should enhance the form,
not remove the label semantics assistive technology relies on.

## Save

Save the settings form. Load one of the forms you listed and confirm the labels
start inside the fields and float up on focus or when a value is present.
