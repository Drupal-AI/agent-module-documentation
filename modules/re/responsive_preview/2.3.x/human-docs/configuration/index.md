# Configuration

Responsive Preview works the moment you enable it — it ships with four ready‑made
devices. Configuration is about tailoring that device list to your project: which
devices appear, in what order, and at what dimensions.

## Open the device list

1. Log in as a user with the **Administer responsive preview** permission.
2. Go to **Configuration → User interface → Responsive preview**
   (`/admin/config/user-interface/responsive-preview`).

You'll see the device collection with an **Add Device** action link. Each device
is a config entity, so your changes export cleanly and can be reused across
sites.

## The default devices

| Device | Width × Height | dppx | Orientation |
|--------|----------------|------|-------------|
| Phone | 1170 × 2532 | 3 | portrait |
| Tablet Portrait | 1640 × 2360 | 2 | portrait |
| Tablet Landscape | 2360 × 1640 | 2 | landscape |
| Desktop | 1920 × 1080 | 1 | landscape |

## Add or edit a device

From the list, click **Add Device** (or **Edit** on an existing one). The form
has these fields:

- **Label** — the human name shown in the toolbar's device list.
- **Machine name** — the internal id (auto‑generated from the label).
- **Show device in list** — the on/off toggle. Only devices with this enabled
  appear in the toolbar, so untick it to hide a device you never use without
  deleting it.
- **Width** and **Height** — the device's viewport dimensions in pixels. Both are
  required and must be at least 1.
- **Dots per pixel** — the pixel density. Use `1` for a classic screen and `2` or
  `3` to simulate a high‑DPI ("retina") display. Required.
- **Default orientation** — `portrait` or `landscape`, the orientation the
  preview opens in.

There is also a **weight** on each device that controls its position in the list
(lower numbers appear first); reorder the list to put your most‑used devices at
the top.

Save, and the device immediately appears (or disappears) in the toolbar control.

## Managing devices from Drush

There are no module‑specific Drush commands, but the devices are plain config, so
core config commands work:

```bash
drush config:get responsive_preview.device.phone
drush config:set responsive_preview.device.phone status 0 -y   # hide Phone
```

You can also add a custom device by importing a
`responsive_preview.device.{id}.yml` file that matches the fields above.

## Permissions recap

- **Access responsive preview** — use the toolbar tab, the "Responsive preview
  controls" block, and (with the submodule) the Navigation top‑bar item.
- **Administer responsive preview** — manage the device config entities described
  on this page (this is what protects the add/edit/delete screens).

Neither permission is marked security‑restricted. A typical setup gives editors
only *access responsive preview* and site builders both.
