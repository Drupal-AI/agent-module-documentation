<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AdSense ads.txt is a small submodule of AdSense that serves an auto-generated `/ads.txt` file (the IAB "authorized digital sellers" file) built from your Google AdSense publisher ID, so you don't have to maintain a static file.

---

The submodule adds a single public route, `adsense_adstxt.page`, at path `/ads.txt`, handled by `AdsenseAdsTxtController::display()`. On each request it reads the AdSense publisher ID via `Drupal\adsense\PublisherId::get()` (i.e. `adsense.settings:adsense_basic_id`), lets modules alter it with `hook_adsense_alter()`, and if a publisher ID is set returns a `text/plain` response containing the single line `google.com, <publisher-id>, DIRECT, f08c47fec0942fa0`. If no publisher ID is configured it returns a 404 (NotFoundHttpException). It depends on the main `adsense` module and has no configuration, permissions, blocks or schema of its own. Its `hook_requirements()` warns on the status report if a real static `ads.txt` file already exists in the Drupal root, because a physical file would be served by the web server instead of this dynamic route — you must remove the static file for the generated one to take effect.

---

- Serve a valid `/ads.txt` for Google AdSense without hand-maintaining a file.
- Automatically keep `ads.txt` in sync with the publisher ID configured in AdSense.
- Advertise your AdSense account as an authorized seller (IAB ads.txt spec) to reduce ad fraud.
- Avoid deploying a static `ads.txt` across environments — it's generated from config.
- Get the correct `google.com, ca-pub-…, DIRECT, f08c47fec0942fa0` line produced for you.
- Return a 404 for `/ads.txt` automatically when no publisher ID is set (nothing to advertise).
- Detect (via a status-report warning) when a leftover static `ads.txt` file would shadow the module.
- Change the advertised publisher ID everywhere by updating a single AdSense setting.
- Let another module tweak the emitted publisher ID via `hook_adsense_alter()`.
- Provide `ads.txt` on a multisite where each site has its own AdSense publisher ID.
- Keep `ads.txt` publicly accessible (the route grants `_access: TRUE`).
- Ensure `ads.txt` is served as `text/plain` with the exact format Google expects.
- Roll out ads.txt compliance to many sites by simply enabling the submodule.
- Pair with the main AdSense module so ad units and ads.txt share one publisher ID.
- Remove the need for a deployment step that copies a static ads.txt into the docroot.
- Verify ads.txt output in code by invoking the controller (dev-safe, no live Google call).
