# Custom Classes — manual setup guide

**Custom Classes** (`custom_classes`) lets site builders add — or remove — CSS
classes on form elements without writing a `hook_form_alter()`. If a module renders
a button or field that lacks a unique class you want to target, you add one here;
if another module adds a class you'd rather not have, you can remove it. Classes are
matched against the current URL, the route name, or the Form ID, so you can scope
each rule precisely. The result is form markup you can style with CSS or hook into
with JavaScript, all configured through the admin UI instead of custom theme code.

Because these rules are admin‑configured and change the classes emitted on forms,
the configuration is gated by a dedicated permission,
**`administer custom_classes configuration`** — grant it only to trusted roles. One
caution from the module's own guidance: **removing** classes is a last resort.
Stripping a class another module depends on (for example the success class on
Commerce's *Add to cart* button) can trigger AJAX errors, so prefer adding classes
over removing them.

This is a form‑theming utility. It depends on core's `path_alias` module and
supports Drupal 10 and 11. Note that the 1.0.x branch is an alpha release, so test
before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Custom Classes is driven from its admin configuration, which is protected by the
**`administer custom_classes configuration`** permission (grant it only to trusted
administrators). There you define rules that add or remove classes on form
elements, each matched by URL, route name, or Form ID:

1. Log in as a user who holds the `administer custom_classes configuration`
   permission.
2. Open the module's configuration and add a rule: choose how it matches (URL,
   route name, or Form ID), then list the classes to add — or, only when
   unavoidable, the classes to remove.
3. Save, then visit the matching form and confirm the class is present in the
   rendered markup (browser dev tools make this easy) so your CSS or JavaScript can
   target it.

Keep removals to a minimum: if a form's AJAX starts failing after you strip a
class, restore it — a required class was almost certainly removed.
