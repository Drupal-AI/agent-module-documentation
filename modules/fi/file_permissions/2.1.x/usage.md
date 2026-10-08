<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Permissions provides Drush commands for setting up local file permissions.

---

File Permissions provides Drush commands for setting up local filesystem permissions — fixing the
ownership/permissions of Drupal's public (and private) files directories and ensuring the protective
`.htaccess` files exist in them, so a deployed environment has correct, secure file permissions. It is in the
Developer Tools package.

Use it in deployment/CI or local setup to normalize file permissions. It is a developer/DevOps CLI tool that
operates on the local filesystem (chmod/chown) — run it as an appropriate user with the right privileges.
It is mildly **security-positive**: ensuring the files directories have correct ownership and the expected
`.htaccess` (which blocks direct execution/serving of certain files) is part of hardening a Drupal file
setup. It has no runtime access-control role. Run the Drush command as part of your workflow.

---

- Set local filesystem permissions via Drush.
- Fix files-directory ownership/permissions.
- Ensure .htaccess in public/private dirs.
- Normalize a deployed environment's permissions.
- Run in deployment/CI or local setup.
- Operate on the filesystem (chmod/chown).
- Run as an appropriate user.
- Harden the file setup (positive).
- Have no runtime access-control role.
- Run the Drush command.
- Fix file permissions.
- Ensure protective .htaccess.
- Set correct ownership.
- Handle file permissions.
- Normalize permissions.
- Harden files dirs.
- Configure permissions.
- Set up permissions.
- Run the tool.
- Fix filesystem permissions.
