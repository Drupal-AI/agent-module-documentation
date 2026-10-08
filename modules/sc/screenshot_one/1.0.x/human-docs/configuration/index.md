# Configuration

## 1. Add your ScreenshotOne API keys

1. Sign in to your **ScreenshotOne** account and copy your **API key** and **secret
   key**.
2. In Drupal, go to `/admin/config/screenshot-one/settings` (you need the
   *Administer site configuration* permission).
3. Enter the API and secret keys and save. The keys are handled via the **Key**
   module, so they are stored securely rather than in plain configuration.

That is all Screenshot One itself needs. The page is fetched by ScreenshotOne's
servers, not by your Drupal site.

## 2. Set up the AI Automator (link → image)

To have screenshots generated automatically, use the **AI Automator** submodule of
the AI module together with Screenshot One's automator types. Following the
module's own walkthrough:

1. Install and enable the **AI module** (and its AI Automator submodule).
2. Make sure Screenshot One is installed and your API keys are saved (step 1 above).
3. On an entity or content type, create a **link** field (the URL to screenshot).
4. On the same entity, create either an **Image** field or a **Media Image** field
   (where the screenshot will land).
5. On that image or media field, enable the **AI Automator** checkbox and configure
   it to use the Screenshot One automator, pointing it at your link field.
6. Create an entity of that type, fill in a link, and save — the screenshot is
   captured and the image field is populated automatically.

## Screenshot options

When capturing (either through the automator or when another module calls the
service directly), Screenshot One can:

- **Remove cookie banners** automatically on the target page.
- Capture the **full page**, not just the area above the fold — or, alternatively,
  capture the **exact width and height** you set.
- Apply options such as a **delay** before capture, output **format** (e.g. JPG),
  **image quality**, and a CSS **selector** to capture just one element.

## For developers: calling the service directly

Any module can use the screenshot service directly, for example:

```php
$screenshot_one = \Drupal::service('screenshot_one.api');

$screenshot_config = [
  'full_page' => TRUE,   // Full-page screenshot; otherwise use width/height.
  'delay' => 1,           // Wait 1 second before capturing.
  'format' => 'jpg',      // Output as JPG.
  'image_quality' => 90,  // 90% image quality.
  'selector' => '#content', // Capture only this element.
];

$binary = $screenshot_one->screenshotUrl('https://www.google.com', $screenshot_config);
// ...then create an image (or whatever you need) from the returned binary.
```
