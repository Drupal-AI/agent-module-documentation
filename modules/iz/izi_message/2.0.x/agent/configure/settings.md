# Configure Izi Message

All settings live in the single config object **`izi_message.settings`** and are
exposed to the iziToast JS as `drupalSettings.iziMessage` (see
[../theme/messages.md](../theme/messages.md)). Each key maps directly to an
[iziToast](https://izitoast.marcelodolza.com) option.

- Route: `izi_message.settings` → `/admin/config/development/izi_message/settings`
- Form: `\Drupal\izi_message\Form\IziMessageSettingsForm` (`ConfigFormBase`, form id `izi_message_settings`)
- Permission: `administer site configuration` (core)
- Menu link: `izi_message.settings` under `system.admin_config_development`

The form groups the keys into `details` sections (Basic / Setting size /
Setting animations / Close settings / Other settings) but every value is stored
flat in the one config object.

## Config keys (`izi_message.settings`)

| Key | Schema type | Install default | Form widget | Notes |
|-----|-------------|-----------------|-------------|-------|
| `position` | string | `topRight` | select | One of `bottomRight`, `bottomLeft`, `topRight`, `topLeft`, `topCenter`, `bottomCenter`, `center` |
| `theme` | string | `light` | select | `light` or `dark` |
| `maxWidth` | integer | `500` | number | Max toast width in px |
| `timeout` | integer | `5000` | number (step 10, 0–99999) | ms before auto-close; `0` = no auto-close |
| `titleSize` | string | `''` | number (0–180) | Title font size (px); empty = library default |
| `messageSize` | string | `''` | number (0–255) | Message font size (px); empty = library default |
| `drag` | boolean | `true` | checkbox | Drag-to-dismiss |
| `close` | boolean | `true` | checkbox | Show the "x" close button |
| `closeOnEscape` | boolean | `false` | checkbox | Close on Esc key |
| `closeOnClick` | boolean | `false` | checkbox | Close when the toast is clicked |
| `rtl` | boolean | `false` | checkbox | Right-to-left layout |
| `displayMode` | boolean* | `0` | number (0–2) | iziToast displayMode: `0` normal, `1`/`once`, `2`/`replace`. *Schema declares boolean but the form/install use an int 0–2.* |
| `pauseOnHover` | boolean | `true` | checkbox | Pause timeout while hovered |
| `resetOnHover` | boolean | `false` | checkbox | Reset timeout while hovered |
| `progressBar` | boolean | `true` | checkbox | Show timeout progress bar |
| `overlay` | boolean | `false` | checkbox | Show a page overlay behind the toast |
| `overlayClose` | boolean | `false` | checkbox | Close on overlay click |
| `animateInside` | boolean | `true` | checkbox | Animate title/message inside the toast |
| `transitionIn` | string | `fadeInUp` | select | Open animation (see below) |
| `transitionOut` | string | `fadeOut` | select | Close animation (see below) |
| `transitionInMobile` | string | `fadeInUp` | select | Open animation, mobile |
| `transitionOutMobile` | string | `fadeOutDown` | select | Close animation, mobile |

Transition-in options (`getInAnimationOptions`): `bounceInLeft`, `bounceInRight`,
`bounceInUp`, `bounceInDown`, `fadeIn`, `fadeInDown`, `fadeInUp`, `fadeInLeft`,
`fadeInRight`, `flipInX`.
Transition-out options (`getOutAnimationOptions`): `fadeOut`, `fadeOutDown`,
`fadeOutUp`, `fadeOutLeft`, `fadeOutRight`, `flipOutX`.

Two form quirks in `buildForm` (values still save correctly, but the shown
default is wrong): the `resetOnHover` field's `#default_value` reads
`pauseOnHover`, and `overlayClose`'s reads `overlay`. `submitForm` writes each
key from its own `$form_state->getValue(...)`, so a save persists the intended
values.

## Set via drush

```bash
# Single key
drush config:set izi_message.settings position bottomRight -y
drush config:set izi_message.settings timeout 8000 -y

# Inspect current values
drush config:get izi_message.settings
```

## Set via PHP

```php
\Drupal::configFactory()
  ->getEditable('izi_message.settings')
  ->set('position', 'bottomLeft')
  ->set('timeout', 0)          // never auto-close
  ->set('theme', 'dark')
  ->save();
```

Config schema: `config/schema/izi_massage.schema.yml` (`type: config_object`,
label "Izi message settings"). Install defaults: `config/install/izi_message.settings.yml`.
