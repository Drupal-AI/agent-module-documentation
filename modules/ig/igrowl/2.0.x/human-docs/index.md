# iGrowl — manual setup guide

**iGrowl** (`igrowl`) makes the [iGrowl](http://catc.github.io/iGrowl)
JavaScript notification library available to a Drupal site and adds a Drupal Ajax
command so your server-side code can pop animated "growl"-style toast
notifications in the browser. It is aimed at **developers and themers** — it has no
admin UI and stores no configuration. You wire it into your own module or theme
code.

A typical use is giving feedback after an Ajax action: on a Drupal Commerce site,
for example, a small animated toast can confirm "added to cart", "removed from
cart", or "billing info updated" without a full page reload.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and place the
   third‑party JavaScript libraries it needs.

There is **no configuration page** for this module — it has no settings form.
Everything is done from code, described in "How to use it" below.

## Where it lives in the admin menu

iGrowl adds no admin page and no permissions. After installing the JavaScript
libraries, the **Reports → Status report** (`/admin/reports/status`) page will
confirm that both the iGrowl and animate.css libraries were detected. Beyond that
check, you work entirely in your own module or theme.

## How to use it

Two paths are available.

**1. Straight from JavaScript.** In a custom theme or module, call the library
directly with whatever options you want:

```javascript
$.iGrowl({
  message: "Your message here",
});
```

**2. From a server-side Ajax response.** The module defines a `GrowlCommand` Ajax
command you can return from a controller or a form's `#ajax` callback:

```php
use Drupal\igrowl\Ajax\GrowlCommand;
use Drupal\Core\Ajax\AjaxResponse;

$options = GrowlCommand::defaultOptions();
$options['title'] = 'Excellent!';
$options['message'] = 'We have added your item to the order!';
$options['type'] = 'success';
$options['icon'] = 'feather-circle-check';

$response = new AjaxResponse();
$response->addCommand(new GrowlCommand($options));
return $response;
```

`GrowlCommand::defaultOptions()` returns an overridable array of iGrowl options —
`title`, `message`, `type`, `icon`, and more.

You also need to attach the libraries where the notifications will fire, often in
`hook_preprocess_page()`:

```php
$variables['#attached']['library'][] = 'igrowl/command';
$variables['#attached']['library'][] = 'igrowl/icons.feather';
```

The second library is the icon set. Four are available:
`icons.feather`, `icons.lineicons`, `icons.steadysets`, and `icons.vicons`. You can
preview every animation and icon on the
[iGrowl demo page](http://catc.github.io/iGrowl).

> **Security note.** Notification content comes from the code that dispatches the
> command, so it is your responsibility not to pass untrusted or unescaped markup
> into a notification's title or message.
