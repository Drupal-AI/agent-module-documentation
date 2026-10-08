<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sheephole helper connects Drupal's Project Browser to a locally-running Sheephole desktop application (a Java helper) so a site owner can install contrib modules via composer without using the command line.
---
The module attaches a small library to the Project Browser page and exposes two controller routes that talk to the helper app on `http://127.0.0.1:41295`. `isOnline` (`/sheephole-helper/is-online`) pings the app and — importantly — first checks that the request's client IP is `127.0.0.1`/`localhost`, returning 500 otherwise. `installModule` (`/sheephole-helper/install-module`) forwards a request-supplied `machine_name` to the helper's `/install-module` endpoint. The actual composer install happens inside the external Java app (which uses SSH credentials the user configured), not in Drupal.

The module is intended as a setup-time convenience: operators can restrict these routes or only run the module transiently during installation.

Typical setup: install Java 17, run the Sheephole app and create an SSH profile, use the app's Setup to install this module + Project Browser, then use Project Browser's download button.
---
- Install contrib modules from Project Browser without a terminal.
- Detect whether the Sheephole desktop app is running.
- Forward a chosen module machine name to the local helper.
- Trigger a composer-based install over SSH via the app.
- Add a download button to the Project Browser UI.
- Let non-technical site owners install modules securely.
- Keep composer as the install method (no zip uploads).
- Restrict the helper routes after setup (recommended).
- Check helper connectivity before showing the install button.
- Keep composer as the sole install path.
- Enable Project Browser installs for non-technical owners.
- Restrict or remove the helper routes after setup.
- Bound install actions to a loopback-only helper.
- Enforce a client-IP check on the online probe.
- Avoid uploading module zips manually.
