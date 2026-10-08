# signageOS — manual setup guide

**signageOS** (`signageos`) connects Drupal's Digital Signage Framework to the
[signageOS](https://www.drupal.org/project/signageos) device-management platform,
so content and schedules you manage in Drupal drive real screens — Samsung, LG,
Philips, BrightSign, NEC, Panasonic, Sharp, BenQ, Android and more — through
signageOS. It is a connector: the Digital Signage Framework owns the device
entities and scheduling, and this module is the backend that talks to signageOS.

Once installed it does two visible things. It adds a **connection settings form**
where you enter your signageOS API credentials, and it adds a **power-action form**
from which you can send commands such as reboot to your devices. Behind the scenes
an event subscriber listens to Digital Signage Framework events and pushes
provisioning and content to signageOS as your Drupal content changes, keeping the
screens in sync.

The module needs configuration before it does anything useful — you must enter
your signageOS credentials on the settings form first. It depends on the
**Digital Signage Framework** module (`digital_signage_framework`) and has no
submodules. The integration is developed by bitegra Solutions, an official
signageOS partner; you contact them for account details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Digital Signage Framework.
2. [Configuration](configuration/index.md) — enter your signageOS credentials and
   send power actions to devices.

## Where it lives in the admin menu

Both of the module's screens sit under the Digital Signage Framework's area:

- **Connection settings:** *Configuration → Web services → Digital Signage
  Framework → signageOS*
  (`/admin/config/services/digital_signage_framework/signageos`), which requires
  the *Administer site configuration* permission.
- **Power actions:** *Content → Digital signage devices → signageOS power action*
  (`/admin/content/digital-signage-device/sos-power-action`), which requires the
  dedicated *Execute signageos power action* permission.

Both screens are permission-gated — there are no anonymous or public endpoints.
