# Server Beacon — manual setup guide

**Server Beacon** (`server_beacon`) transmits reports about your server's status
to a designated reporting station (provided by the companion Report Station
project). Those stations collect the information so you can monitor the health of
an environment — and be told when updates are available — across a fleet of sites
from one place.

Each report can include useful operational details: your PHP, web-server, and
Linux versions, a PHP Composer audit when Composer is available, and Drupal module
update information (via core's Update Manager). The reporting system is extensible,
so plugins can be added to supply other kinds of server status information. You
build and manage these reports in the Drupal admin UI, then point them at the
receiving station.

The module requires some configuration before it does anything: you set up one or
more reports and make sure their transmitter protocols line up with the receiving
station's configuration. Credentials for talking to the station are handled
through the **Key** module, which is a required dependency — a good thing, since
it keeps secrets out of plain configuration. Server Beacon runs on Drupal 10.2 and
11.

A note on what leaves your site: by design, this module sends server and site
status/health data to an external station over HTTPS, and that data can include
operational and infrastructure details. Send it only to a station you trust, and
keep the station credentials in the Key module rather than anywhere they might be
exposed. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Key module.
2. [Configuration](configuration/index.md) — build your reports and match their
   protocols to the receiving station.

## Where it lives in the admin menu

Build and manage server reports at
**`/admin/config/services/server-beacon`**, or follow the **Server Beacon
Reports** link on the admin web-services page (Configuration → Web services).
