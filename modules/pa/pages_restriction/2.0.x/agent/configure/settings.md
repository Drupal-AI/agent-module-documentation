<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Pages Restriction

## Where

Admin form: **`/admin/config/development/pages-restriction/settings`**
(route `pages_restriction.settings`, permission **`administer site configuration`**).
All values are stored in the config object **`pages_restriction.settings`**. The module ships
**no config schema**, and its `config/install` only sets `keep_parameters: 1` and
`bypass_role: []` — the `pages_restriction` key is created when you first save the form.

## Settings

| Key | Type | Meaning |
|---|---|---|
| `pages_restriction` | string (textarea) | One mapping per line, `restricted-path|target-path`. When a visitor hits *restricted-path*, they are redirected to *target-path*. |
| `keep_parameters` | bool (`1`/`0`) | If on, the current request's query parameters are appended to the redirect target (`Url::fromUserInput($target, ['query' => …])`). |
| `bypass_role` | array | Role ids whose (logged-in) users skip all restrictions. |

### Format of `pages_restriction`

```
contact/thank-you|contact/send-your-message
newsletter/success|newsletter/subscribe
```

The left side is the page to protect; the right side is where a disallowed visitor is sent.
Paths are matched against the **current path's alias** (lower-cased).

## Read / write via drush

```bash
# Read the whole config object.
drush cget pages_restriction.settings

# Set the restriction mappings (one line; use \n for multiple).
drush cset pages_restriction.settings pages_restriction 'contact/thank-you|contact/send-your-message' -y

# Toggle keep-parameters.
drush cset pages_restriction.settings keep_parameters 1 -y
```

Set `bypass_role` (a list) via `php:eval` since it is structured:

```php
$c = \Drupal::configFactory()->getEditable('pages_restriction.settings');
$c->set('bypass_role', ['administrator' => 'administrator'])->save();
```

## How enforcement works (summary)

A kernel `REQUEST` subscriber checks each request: logged-in users with a `bypass_role` are let
through; otherwise if the current alias equals a restricted path (and there is no session
bypass for it) the user is redirected to the target. See
[api/services.md](../api/services.md) for the subscriber and the session-bypass service.
