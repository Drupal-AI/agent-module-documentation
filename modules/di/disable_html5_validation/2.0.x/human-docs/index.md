# Disable HTML5 validation — manual setup guide

**Disable HTML5 validation** (`disable_html5_validation`) turns off the browser's
built-in HTML5 client-side form validation across your whole site. Those native
pop-up bubbles — "Please fill out this field", the email-format warning, `pattern`
and `maxlength` complaints — stop appearing, and every form instead reaches Drupal's
own server-side validation, which shows consistent, themeable Drupal messages.

It does this in the simplest possible way: it adds the standard `novalidate`
attribute to every `<form>` on the site, which is the official signal telling a
browser to skip native constraint checking on submit. Nothing about your stored data
or Drupal's server-side validation changes — only the browser's pre-submit behaviour.
The effect is global and unconditional: admin forms, node edit forms, the login and
registration forms, Views exposed filters, Webform, Contact, and any custom form all
receive it. There is no allow/deny list.

The module works the moment you enable it — there is no settings form, no configure
route, no permissions, and no configuration of any kind. It has no dependencies and
no submodules. To restore validation everywhere, simply uninstall it; it stores no
configuration, so nothing is left behind.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including how to re-enable validation
on a single form — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no admin page or settings form. Enabling the module is the entire
setup.

## How to use it

There is nothing to do beyond enabling the module — from that point every form on the
site is rendered with `novalidate` and browser validation is off. To confirm it, view
the page source of any form and look for `novalidate` on the `<form>` tag.

Because it is all-or-nothing, there is no per-form control built in. If you need to
*keep* HTML5 validation on one specific form, that requires a small custom module of
your own that removes the attribute again for that form — the reliable way to do it
(using an `#after_build` callback so module ordering does not matter) is documented in
the [`agent/` mechanism docs](../agent/mechanism.md#excluding-a-single-form-re-enable-html5-validation).
