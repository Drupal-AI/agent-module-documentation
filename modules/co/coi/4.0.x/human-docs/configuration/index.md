# Configuration

COI's behavior is controlled from one settings page. It only reacts to a field when
that field carries a config-key hint (from Config Override Core Fields) **and** a
real override exists for that config value.

## Open the settings form

1. Log in as a user with the **Administer config override inspector** permission.
2. Go to **Configuration → User interface → Config Override Inspector**, or
   navigate directly to `/admin/config/user-interface/coi`.

## Override behavior

The central choice is what COI does when it finds an overridden field:

- **Disable** *(default)* — the field is disabled so it can't be edited. If
  "inject the overridden value" is on (see below), the field also shows the real
  overridden value.
- **No access** — the field is hidden from the form entirely.
- **None / indicator only** — the field stays editable; COI only adds the message
  and/or CSS classes.

## Message

- **Enable message** — turn the explanatory description under the field on or off.
- **Template** — the message text, defaulting to *"This field is overridden by
  environment specific configuration."* It runs through the token service, so you
  can include the `coi:active-value` token (the value before overrides) and the
  `coi:overridden-value` token (the value actually in effect). Install the Token
  module for a token browser here.

## Overridden value display

- **Show the overridden value** — whether COI computes and reveals the real
  overridden value (rather than a generic "overridden value" placeholder).
- **Inject as the field's value** — in *disable* mode, set the disabled field's
  displayed value to the overridden value, so admins see what is really in effect.
- **Expose secrets** — whether to also reveal values on fields marked as secret.
  Off by default, so sensitive overrides stay masked while the field is still
  flagged.

## Styling

- **Selectors** — add CSS classes to config-bound fields (`config`, plus
  `config--overridden` on overridden ones, and `config--<object>` /
  `config--<object>--<key>` classes) so you can style or target them in themes and
  tests. These are added regardless of override state.
- **Default CSS** — include COI's own default styling for the indicators.

## Seeing it in action

COI only shows something when a real override exists for a hinted field. To try it,
add an override in `settings.php`, for example:

```php
$config['system.site']['name'] = 'Overridden name';
```

Then open **Configuration → System → Basic site settings** — the **Site name**
field now carries COI's message and behavior. The set of fields that can react is
provided by Config Override Core Fields (the standard core system settings forms).

## Setting it via Drush

All options live in the `coi.settings` config object, so they travel with a normal
configuration export. You can also set them directly, for example:

```bash
# indicator-only, keep fields editable:
drush config:set coi.settings override_behavior '' -y
# hide overridden fields instead of disabling them:
drush config:set coi.settings override_behavior noaccess -y
```
