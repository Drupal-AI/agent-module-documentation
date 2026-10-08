<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Serves the IAB `ads.txt` file dynamically from Drupal configuration instead of a static file on disk, letting site owners edit authorised ad sellers through the admin UI.

---
Publishers use `/ads.txt` to declare which ad networks may sell their inventory; editing it normally means filesystem access. Virtual Ads.txt stores the file body in `virtual_adstxt.settings` config, edited through a simple textarea form at `/admin/config/adstxt` (`AdminAdstxtForm`), and a controller (`AdstxtController::show`) responds at `/ads.txt` with the stored text and a `text/plain` content type. This makes managing ads.txt a normal editorial task and keeps it in exportable config.

The public `/ads.txt` route is read-only and gated by `access content` (appropriate, since ads.txt is intended to be public). The edit form is gated by an `administer virtual_adstxt settings` permission; note the module ships no `permissions.yml` defining that permission, so it is not grantable through the UI and the form is effectively restricted to user 1 (fail-closed, not writable by low-privilege users). Setup is: enable the module, ensure the admin has access to the edit form, paste your ads.txt content, and remove any static `ads.txt` from the docroot so the route resolves.
---
- Serve `/ads.txt` from Drupal config instead of a static file.
- Edit ads.txt content through the admin UI.
- Declare authorised ad sellers/resellers for the site.
- Update ads.txt without filesystem/SFTP access.
- Keep ads.txt in exportable site configuration.
- Return ads.txt as `text/plain` at the standard path.
- Manage advertising authorisations editorially.
- Roll ads.txt changes through config deployment.
- Restrict ads.txt editing to a privileged permission.
- Expose the public ads.txt to crawlers and ad networks.
- Replace a hand-maintained static ads.txt file.
- Centralise ads.txt for multi-environment sites via config.
- Add or remove authorised resellers from the admin UI.
- Serve ads.txt at the IAB-standard `/ads.txt` path.
- Version ads.txt changes through config export/import.
- Restrict ads.txt editing to a privileged admin permission.
- Update ad authorisations without a deployment for content.
- Keep programmatic-advertising declarations editorially managed.
