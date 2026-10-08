# Place & configure the Add to Home Screen block

The module provides the `pwa_add_to_home_screen` block plugin. Configure it per instance.

## Via the UI

Go to *Structure → Block layout* (`/admin/structure/block`), click **Place block** in the desired
region, choose **PWA Add to Home Screen**, then set:

- **Introduction text** (`intro_text`) — rich text shown above the button.
- **Button text** (`button_text`) — the install button label (default "Install app").

## Via config / code

```php
use Drupal\block\Entity\Block;

Block::create([
  'id' => 'pwa_install',
  'plugin' => 'pwa_add_to_home_screen',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'settings' => [
    'id' => 'pwa_add_to_home_screen',
    'label' => 'Install our app',
    'label_display' => '0',
    'button_text' => 'Get the app',
    'intro_text' => ['value' => 'Install this site as an app.', 'format' => 'basic_html'],
  ],
])->save();
```

Read a placed block's button text:

```bash
drush cget block.block.pwa_install settings.button_text
```

The block's `build()` attaches `pwa_a2hs/pwa_a2hs_prompt` and exposes `button_text` at
`drupalSettings.pwaA2hs.pwaA2hsPrompt.button_text`; the JS wires the click to the browser install
prompt. The default value (when unset) is `Install app` (`defaultConfiguration()`).
