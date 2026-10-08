# Configure Colorbox

![Colorbox settings form](../../../../../../../screenshots/colorbox/2.2.x/settings.png)

Single config object `colorbox.settings` (schema `config_object`). UI at
`/admin/config/media/colorbox` (route `colorbox.admin_settings`, form
`Drupal\colorbox\Form\ColorboxSettingsForm`, permission `administer site configuration`).

## Key settings (`config/install/colorbox.settings.yml`)
```yaml
custom:
  style: 'default'            # default | plain | stockholmsyndrome | none (theme it yourself)
  activate: 0                 # 0 = automatic on Colorbox-formatted fields
  transition_type: 'elastic'  # elastic | fade | none
  transition_speed: 350
  opacity: 0.85
  text_current: '{current} of {total}'
  text_previous: '« Prev'
  text_next: 'Next »'
  text_close: 'Close'
  maxwidth: '98%'
  maxheight: '98%'
  initialwidth: '300'
  initialheight: '250'
  overlayclose: true
  returnfocus: true
  fixed: true
  scrolling: true
  slideshow:
    slideshow: 0              # 1 = enable slideshow
    auto: true
    speed: 2500
    text_start: 'start slideshow'
    text_stop: 'stop slideshow'
advanced:
  unique_token: 1            # unique gallery token per page
  mobile_detect: 1          # disable Colorbox on small screens
  mobile_device_width: '480px'
  caption_trim: 0
  caption_trim_length: 75
  compression_type: 'minified'  # minified | source (dev build)
```

- Choosing `style: none` loads no Colorbox theme CSS/JS — style it in your own theme.
- Read/write in code via `\Drupal::config('colorbox.settings')` /
  `\Drupal::configFactory()->getEditable('colorbox.settings')`, or `drush config:set`.
- The `colorbox.activation_check` service decides per-request whether assets attach
  (respects the `activate` mode and admin-path exclusions).
