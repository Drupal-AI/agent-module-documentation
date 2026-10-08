# Configuration

DDECK PWA is configured in two places: a short settings form in the admin UI, and
a set of image files you drop into your active theme. Both matter — the form
controls labels and the navigation bar, while the images drive the icons and
splash screens.

## Open the settings form

1. Log in as a user with the **Administer DDECK PWA** (`administer ddeck pwa`)
   permission.
2. Go to **Configuration → Web services → DDECK PWA**, or navigate directly to
   `/admin/config/services/ddeck-pwa`.

## Settings, field by field

- **Apple app title** (`apple_app_title`) — the name iOS shows under the icon when
  a visitor adds your site to their home screen. If you leave it empty, the module
  falls back to the app name defined in the base PWA module's manifest, so you
  only need to set this when you want a different label specifically for iOS.
- **Enable navigation** (`enable_navigation`) — a toggle that turns the PWA bottom
  navigation bar on or off. When enabled, the module renders its navigation SDC
  component at the bottom of the page for an app-shell feel. Leave it off if your
  theme already provides its own mobile navigation.

Click **Save configuration** to store your changes. The form also links across to
the base PWA module's manifest configuration, where the underlying app name,
theme colour, and service-worker settings live.

## Supply theme icons and splash screens

The visual assets are **not** uploaded through the form — you place them as PNG
files in your active theme's `pwa/` directory, and the module injects them only
when the matching file exists:

- **Manifest icons** — provide square PNGs at the standard PWA sizes (72, 96, 128,
  144, 152, 192, 384, and 512 pixels). When present, the module swaps the base
  PWA module's icons for these theme-provided ones via `hook_pwa_manifest_alter`.
- **Apple splash screens** — provide the startup images for the iPhone and iPad
  resolutions you want to support, in both portrait and landscape orientation.
  The module emits an Apple splash-screen `<link>` for each image it finds, so
  supply as many or as few sizes as you need.

Because every asset is validated with a file-existence check before it is
referenced, missing sizes simply fall back gracefully rather than producing broken
links.

## Verify

On an iOS device (or an iPhone simulation in your browser's device tools), open
your site, use **Add to Home Screen**, and confirm the icon, the app title, and —
when launched from the home screen — the splash screen all appear as expected. If
you enabled navigation, confirm the bottom navigation bar renders on the page.
