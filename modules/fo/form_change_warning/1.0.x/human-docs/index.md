# Form change warning — manual setup guide

**Form change warning** (`form_change_warning`) shows a **"You have unsaved
changes" warning** at the top of a form as soon as any input on it has been
modified. It's a small but reassuring editorial‑UX safeguard: it helps content
editors notice when they've made edits, so they're less likely to navigate away
and lose their work.

The module is deliberately lightweight — it's a front‑end enhancement with no
content or access role of its own. It provides a JavaScript library, and you turn
the warning on for a form by **attaching that library** to the form. There is no
settings form to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You enable the warning per
form by attaching its library, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. It's used from code, by attaching its
library to the form(s) you want to protect.

## How to use it

The module exposes a library, `form_change_warning/form_change_warning`. Attach it
to any form you want the warning on — typically from a small custom module using
`hook_form_alter()`:

```php
/**
 * Implements hook_form_alter().
 */
function YOURMODULE_form_alter(&$form, \Drupal\Core\Form\FormStateInterface $form_state, $form_id) {
  $form['#attached']['library'][] = 'form_change_warning/form_change_warning';
}
```

Narrow the `hook_form_alter()` to the specific `$form_id`(s) you care about (or
use a form‑id‑specific alter hook) so the warning only appears where you want it.
Once the library is attached, changing any input on that form shows the
unsaved‑changes warning at the top.

> If you'd rather not write code, the similar
> [Confirm Leave](https://www.drupal.org/project/confirm_leave) module offers a
> comparable "unsaved changes" prompt with its own configuration.
