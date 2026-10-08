<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Database embeds Adminer inside the Drupal back-office so administrators can browse and manage the site database from /admin/admin-db.

---

Install the module; on install it copies assets/adminer.php.dist to assets/adminer_<token>.php and stores the token in state. Access /admin/admin-db (permission: administer database, restrict access: true). The page renders an iframe pointing at assets/adminer_with_plugins.php. SECURITY: the Adminer PHP is served as a static file under the module assets directory, outside Drupal's access control — treat exposure as critical (see agent notes).

---

- Manage the Drupal database via embedded Adminer.
- Expose the tool at /admin/admin-db.
- Gate the Drupal route behind 'administer database' (restrict access).
- Copy a tokenised Adminer file on install.
- Render Adminer inside an iframe.
- Prefill server/username/db from the connection.
- Use an Adminer plugin loader with a frames plugin.
- WARNING: the Adminer PHP is directly web-accessible as a static asset.
- WARNING: adminer_with_plugins.php includes a cookie-controlled file path (LFI).
- Disable clickjacking protection for the iframe (X-Frame-Options removed).
- Allow full SQL query execution for permitted users.
- Provide database maintenance/optimisation access.
- Store the Adminer token in Drupal state.
- Delete the tokenised file on uninstall.
- Only grant the permission to fully trusted admins.
- Consider blocking direct access to the assets directory.
- Serve as an operations/DBA convenience tool.
- Note the strong warning in the module README.
