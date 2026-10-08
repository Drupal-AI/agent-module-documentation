# Easepick — manual setup guide

**Easepick** (`easepick`) brings the
[easepick](https://easepick.com/) JavaScript date picker into Drupal forms.
Easepick is a tiny, modern, dependency‑free date and date‑range picker — it renders
its calendar inside a Shadow DOM and supports its own plugin system — and this
module is the glue that lets you attach that interface to a Drupal form element in
place of the default browser date widget.

The appeal is a lightweight, good‑looking picker with no heavy libraries behind it.
If you want a friendlier calendar UI than the native input on a particular form,
Easepick gives you one without pulling in jQuery UI or a large date framework.

This is a **developer‑oriented** module: at this stage it has **no admin settings
form**. You turn the easepick behaviour on for a form by adding a small flag to the
element in code — there's nothing to click through in the admin UI. It works on
Drupal 9.4, 10, and 11 and depends only on core. It affects only how date inputs are
rendered and has no content‑ or access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
enable the picker per form element in code, as shown below.

## How to use it

Attach the easepick behaviour to a form element by adding an `easepick` value flag
in your form array (for example from a custom form or a `hook_form_alter()`):

```php
// Give easepick features to this form element.
$form['easepick'] = [
  '#type' => 'value',
  '#value' => TRUE,
];
```

With the flag in place, easepick enhances the relevant date input on that form.
Because there are no site‑wide settings yet, any per‑picker behaviour comes from
easepick's own options and plugins — see the
[easepick documentation](https://easepick.com/) for what's available.
