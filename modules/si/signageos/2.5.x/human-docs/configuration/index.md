# Configuration

signageOS needs to be told how to reach your signageOS account before it can do
anything, so configuration is not optional — start with the connection settings.

## Connection settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Digital Signage Framework → signageOS**,
   or navigate directly to
   `/admin/config/services/digital_signage_framework/signageos`.
3. Enter your **signageOS API connection details** (the credentials bitegra
   Solutions provides for your account). These are stored in the module's
   configuration.
4. Save the form.

With valid credentials in place, the module's event subscriber can push
provisioning and content to signageOS whenever your Digital Signage Framework
content and schedules change.

## Register and manage devices

Devices themselves are registered and scheduled through the **Digital Signage
Framework**, not through this module — signageOS is only the backend connector.
Add your screens as Digital Signage Framework devices, assign content and
schedules there, and the signageOS integration keeps the real screens in sync.

## Power actions

To send a command such as a reboot to a connected device:

1. Make sure the user has the dedicated **Execute signageos power action**
   permission. This is separate from the general site-configuration permission,
   so you can let operators reboot screens without giving them full configuration
   access. Grant it at **People → Permissions**.
2. Go to **Content → Digital signage devices → signageOS power action**
   (`/admin/content/digital-signage-device/sos-power-action`).
3. Choose the device and the power/reboot action, then submit. The command is sent
   through signageOS to the physical device.

Both of these screens are permission-gated; the module exposes no anonymous or
public endpoints.
