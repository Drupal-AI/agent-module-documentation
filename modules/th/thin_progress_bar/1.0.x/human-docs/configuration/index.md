# Configuration

Thin Progress Bar works out of the box — everything here is **optional tuning**. If
you never open the settings, the bar still behaves sensibly on its defaults.

## Open the settings

The module's options live on the appearance settings page:

1. Go to **Appearance → Settings** (`/admin/appearance/settings`).
2. Find the Thin Progress Bar options.

## What you can adjust

- **Threshold (sensitivity)** — how long a page load must take before the bar
  appears at all. The default is **800ms**, and you can set it anywhere from
  **100ms to 5000ms**. A lower value shows the bar more readily; a higher value
  keeps it hidden unless a load is really slow.
- **Color** — the color of the bar, so you can match it to your theme.
- **Thickness** — choose **1px** or **2px** for a minimal, unobtrusive line.
- **Animation speed** — how quickly the bar animates as it fills.
- **Page loads / AJAX toggles** — enable or disable the bar independently for
  normal page loads and for AJAX operations, so you can, for example, show it only
  during AJAX or only during full page loads.

## Save

Save the settings page. Changes take effect immediately — reload the site and
trigger a slow load to see the new behavior.
