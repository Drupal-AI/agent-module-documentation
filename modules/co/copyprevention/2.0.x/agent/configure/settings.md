# Configure Copy Prevention

Form `CopypreventionSettingsForm` at `/admin/config/user-interface/copyprevention`
(route `copyprevention.settings_form`). Single config object `copyprevention.settings`.

## Config keys

| Key | Shape | Options / notes |
|---|---|---|
| `copyprevention_body` | checkboxes map | Keys `selectstart` (disable text selection), `copy` (disable clipboard copy), `contextmenu` (disable right-click). Selected → value = the key string; unselected → `0`. Applied as `on<key>="return false"` on `<body>`. |
| `copyprevention_images` | checkboxes map | Keys `contextmenu` (disable right-click on `<img>`), `transparentgif` (overlay a transparent GIF on hover). |
| `copyprevention_images_min_dimension` | integer | Minimum image width/height (px) to activate the overlay. Select options: 10,20,30,50,100,150,200,300,500. Default 150. |
| `copyprevention_images_search` | checkboxes map | Keys `httpheader` (`X-Robots-Tag: noimageindex` header), `pagehead` (`<meta name="robots" content="noimageindex">`), `robotstxt` (image `Disallow` rules in robots.txt — **requires the RobotsTxt module**). |

Note: the shipped install config also carries a legacy typo'd key
`copyprevention_images_min_dimention` (unused by the code — the real one is `..._dimension`).

## How each is applied

- `copyprevention_body` → `hook_preprocess_html()` sets `$vars['attributes']['on'.$value]='return false'`
  for each enabled body option (only for users without `bypass copy prevention`).
- `copyprevention_images` + `..._min_dimension` → passed to `drupalSettings.copyprevention` and the
  `copyprevention/copyprevention` library (`js/copyprevention.js`) which binds handlers / builds the
  overlay client-side.
- `copyprevention_images_search` → `hook_page_attachments()` adds the HTTP header (`httpheader`) and
  the head meta tag (`pagehead`); `hook_robotstxt()` returns the image Disallow lines (`robotstxt`).
  The image-search options apply regardless of the `bypass` permission.

## Set with drush

```bash
# Disable the right-click context menu site-wide (body option):
drush php:eval '
  \Drupal::configFactory()->getEditable("copyprevention.settings")
    ->set("copyprevention_body", ["selectstart" => 0, "copy" => 0, "contextmenu" => "contextmenu"])
    ->save();'

# Hide images from search engines via the head meta tag:
drush php:eval '
  \Drupal::configFactory()->getEditable("copyprevention.settings")
    ->set("copyprevention_images_search", ["httpheader" => 0, "pagehead" => "pagehead", "robotstxt" => 0])
    ->save();'

drush cget copyprevention.settings   # read current values
```

Read back: `\Drupal::config('copyprevention.settings')->get('copyprevention_body')`
(enabled options are those with a truthy value). `array_filter()` is what the module uses to drop
the unchecked `0` entries.
