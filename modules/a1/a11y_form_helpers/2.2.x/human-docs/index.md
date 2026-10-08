# A11Y: Form Helpers — manual setup guide

**A11Y: Form Helpers** (`a11y_form_helpers`) makes Drupal forms more accessible.
It bundles a few common form-accessibility fixes that many sites end up
reimplementing: it turns off inconsistent browser HTML5 validation in favour of
Drupal's own accessible messages, wires each field's error message to its input
with `aria-describedby` so screen readers announce the error in context, and lets
you assign WCAG **input-purpose** `autocomplete` attributes (like `given-name`) to
field widgets.

There are three features, each independently switchable and **all on by default**,
so the module improves accessibility the moment you enable it. It's built as a
stopgap — the maintainer notes that features may be dropped as Drupal core absorbs
them — and it requires core's **Inline Form Errors** module, which it works
alongside.

The input-purpose part is extensible: it defines an `AutocompleteAttribute` plugin
type mapping fields to WCAG 2.1 input purposes (it ships `given-name` and `name`),
and you set a field's purpose per widget from *Manage form display* — no code
required to use, and easy to extend with your own purposes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Inline Form Errors is required).

## Where it lives in the admin menu

- **Settings** — **Configuration → Content authoring → A11Y: Form Helpers**
  (`/admin/config/content/a11y_form_helpers`), gated by the **Configure
  a11y_form_helpers** permission (a security-restricted permission).

## How to use it

The module works with zero configuration — all three features default to on. To
review or adjust them:

1. Grant **Configure a11y_form_helpers** to your site-builder role and open
   **Configuration → Content authoring → A11Y: Form Helpers**.
2. Toggle any of the three features:
   - **Disable HTML5 validation** — adds `novalidate` to every form so validation
     falls to Drupal / Inline Form Errors (accessible messages) rather than
     inconsistent native browser bubbles.
   - **Readable error messages** — associates each field's error with its input via
     `aria-describedby`, so screen readers announce the error together with the
     field. (This only produces visible/associated output when the next feature —
     or your theme's own templates — renders the error markup.)
   - **Replace core templates** — repoints core's `form_element` and `fieldset`
     templates at the module's accessible copies (with variants for Claro, Classy,
     Stable, and System) so the readable-error markup renders correctly.
3. Save. Changes apply immediately (clear caches if template changes don't show).

### Assigning input purposes to fields

To meet WCAG 1.3.5 (Identify Input Purpose):

1. Go to a content type's (or form's) **Manage form display**.
2. Click the gear/settings for a text field's widget.
3. Set its **Purpose** (for example *Given name*) and update. The module applies
   the matching `autocomplete` HTML attribute to that widget, improving autofill
   and cognitive accessibility.

Out of the box the shipped purposes are `given-name` and `name` (both for string
fields). Developers can add more by writing an `AutocompleteAttribute` plugin — see
the [`agent/` plugin docs](../agent/plugins/autocomplete-attribute.md).

### Customising the templates for your theme

If you use the *Replace core templates* feature and want to tweak the markup, copy
one of the module's `form-element.html.twig` / `fieldset.html.twig` templates
(start from the `system` set, or the family matching your base theme) into your own
theme. See the [`agent/` templates docs](../agent/theming/templates.md).
