# Configuration

Digital Signage Framework is powerful but has several moving parts, so it's worth
following the setup in order. The short version: enable a platform, set global
options, declare which content is publishable, define device types, register your
screens, build schedules, and push them out.

## Order of operations

### 1. Enable a platform integration

The framework models the entities but has no vendor transport on its own. Enable a
concrete platform module that provides a `digital_signage_platform` plugin — for
example **signageOS** for production, or a bundled example/custom platform for
demos. Without one, you can model devices but can't push to real screens.

### 2. Global settings

Go to **Configuration → Services → Digital Signage Framework**
(`/admin/config/services/digital_signage_framework`), behind the **administer
digital signage framework** permission. Two sub-tabs live here:

- **Fonts** (`/admin/config/services/digital_signage_framework/fonts`) — add and
  edit the custom web fonts used in your signage output.
- **Schedules**
  (`/admin/config/services/digital_signage_framework/schedules`) — schedule-
  generation settings (this sub-form is gated by **administer site
  configuration**).

### 3. Content settings entity

Go to **Structure → Digital signage content setting**
(`/admin/structure/digital-signage-content-setting`), behind **administer digital
signage content setting**. Here you declare **which entity bundles are publishable
to signage**.

### 4. Device types

Under **Structure**, create **Digital signage device types** (permission
**administer digital signage device types**) — hardware, orientation
(landscape/portrait), and resolution profiles.

### 5. Devices

Under **Content**, create **Devices** (permission **access digital signage device
overview**) — one entity per physical screen, each bound to a platform plugin.

## Operating the estate

Once devices and schedules exist, you manage them from the device overview under
**Content**:

- **Sync all** — `/admin/content/digital-signage-device/sync-all` (permission
  **access digital signage device overview**).
- **Push schedule** — `/admin/content/digital-signage-device/schedule-push`
  (permission **push digital signage schedule**).
- **Push config** — `/admin/content/digital-signage-device/schedule-config`
  (permission **push digital signage config**).
- **Emergency mode** — `/admin/content/digital-signage-device/emergency-mode`
  (permission **change digital signage emergency mode**) — forces an emergency
  playlist across all screens.

## Building schedules and slides

- Create a **Schedule** (playlist) of content entities for a device, in the order
  you want them shown, then push it to one or many devices.
- Design slides using **Layout Builder**, with support for fixed overlays and
  underlays, custom fonts, and QR codes. Any content entity can become a slide,
  and Views (and other content) can be embedded into computed slide content.

## Permissions overview

The framework ships granular permissions so you can separate who configures the
system from who operates it day to day:

- **administer digital signage framework** — global settings (restricted).
- **administer digital signage content setting** — manage publishable bundles.
- **administer digital signage device types** — manage device-type profiles.
- **access digital signage device overview** — see and sync devices.
- **push digital signage schedule** / **push digital signage config** — push
  content and configuration to screens.
- **change digital signage emergency mode** — toggle estate-wide emergency mode.
- **digital signage framework access preview** — preview signage output in the
  admin UI.
- **access qr code** — expose device pairing/identification codes.

## How devices fetch content

Screens render by calling the framework's HTTP API at `/api/digital_signage`. That
route is not gated by a normal user permission; instead each device authenticates
with a per-device cryptographic fingerprint sent in a request header, and the API
confirms the requested entity is actually on that device's schedule (or emergency
list) before serving it. Editors can also preview output using the preview
permission. Because this is how your screens get their content, keep your site's
hash salt secret, as it underpins that fingerprint.
