# Configuration

Configuration is in two places: a **global admin form** (server URL, operation
mode, sync options) and a **per‑user form** (each user's Nextcloud credentials and
mount path). You can also drive it all from **Drush**.

## Before you start

Make sure `$settings['file_private_path']` is set in `settings.php` so files can
live in the private file system, and that rclone is installed if you plan to use
Mount or Sync mode.

## 1. Global settings

1. Go to **Configuration → Web Services → Nextcloud WebDAV Mount**
   (`/admin/config/services/nextcloud-webdav-mount`). This page requires the
   **administer nextcloud shared mounts** permission.
2. Choose the **operation mode**:
   - **Mount** — real‑time FUSE mount (bare metal / privileged containers).
   - **Sync** — copy on demand or on cron (no FUSE; Docker‑safe).
   - **External** — a mount managed outside Drupal; the module only reports status.
3. For **Mount/Sync**, set the **Nextcloud server URL** (e.g.
   `https://cloud.example.com`) and the **WebDAV path** template. For **Sync**, also
   pick a sync direction and (optionally) a cron interval.
4. Save.

## 2. Per‑user settings

For Mount and Sync modes, each user provides their own credentials:

1. Open **`/user/{uid}/nextcloud`** for the user (the account owner needs
   *configure own nextcloud credentials*; an admin with *administer nextcloud user
   credentials* can edit anyone's).
2. Enter the **Nextcloud login name** and an **app password** (recommended over the
   account password), and set the **mount path** — a custom stream path (which may
   use Drupal tokens such as `[user:name]`) or, if IMCE is enabled, an IMCE profile
   folder. Optionally limit to a **remote subpath** within the Nextcloud WebDAV
   root.

In **External** mode this page shows status only — no credentials are stored in
Drupal.

## 3. Activate

- On the per‑user form, use **Mount / Unmount** (Mount mode) or **Sync now** (Sync
  mode).
- Or use Drush, for example:

  ```bash
  # Sync mode (Docker / no FUSE)
  drush nc-config --operation-mode=sync --server-url=https://cloud.example.com
  drush nc-user-config --uid=2 --username=alice --token=<app-password>
  drush nc-sync --uid=2

  # Mount mode (bare metal / FUSE)
  drush nc-mount --uid=2
  drush nc-mount-status --uid=2
  ```

For **External** mode, just ensure the out‑of‑band mount already exists at the
configured external mount path (default `private://nextcloud`).

## Security checklist

- **Keep per‑user credentials secret.** They are stored to authenticate to
  Nextcloud and must never appear in plaintext exported configuration or logs. Use
  Nextcloud **app passwords** so they can be revoked individually.
- **Choose the destination scheme deliberately.** Mounting or syncing into the
  **public** files directory would make the Nextcloud content web‑accessible. Use
  the **private** file system for anything non‑public and restrict download access.
- **Run rclone with least privilege**, and operate WebDAV over **HTTPS**.
- If credentials must live in environment configuration for automation, keep them
  out of version control — set them via `ddev dotenv set .ddev/.env --…` (never
  commit `.ddev/.env`) and reference them from your deployment tooling, rather than
  hard‑coding secrets anywhere in the repository.
