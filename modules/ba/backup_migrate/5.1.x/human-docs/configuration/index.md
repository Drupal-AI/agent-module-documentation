# Configuration

Everything lives under **Configuration → Development → Backup and Migrate**
(`/admin/config/development/backup_migrate`). This page walks you through taking a
backup right away, then explains the settings profiles, schedules, and saved
backups / restore workflow you will use to run backups routinely.

## Run a Quick Backup

The fastest way to get a backup is the **Quick Backup** form, which is the default
view on the **Backup** tab.

1. Go to **Configuration → Development → Backup and Migrate**
   (`/admin/config/development/backup_migrate`). You land on the **Backup** tab,
   **Quick Backup** sub-tab.
2. Choose a **Backup Source** — *what* to back up. The built-in options are:
    - **Default Drupal Database** — the site's main database. This is the default
      and the most common choice before a risky update.
    - **Entire Site** — the database plus all files, in one archive.
    - **Public Files** / **Private Files** — a files directory only.
   (A generic MySQL database source and a custom files-directory source are also
   available once configured.)
3. Choose a **Backup Destination** — *where* the archive goes. The built-in options
   are:
    - **Download** — stream the archive straight to your browser as a download.
    - **Private Files** — store it in the private files directory, so it is not
      web-accessible. This is the safest place for backups.
    - **Public Files** — store it in the public files directory.
    - A custom server **directory** destination, if you have configured one.
4. Optionally tick **Add a note to the backup** to attach a short description
   (handy for remembering why you took it — for example "before module update").
5. Click **Back up now**. If you chose **Download**, your browser saves the archive;
   otherwise it is written to the destination and appears under **Saved Backups**.

![The Quick Backup form with a Backup Source and Backup Destination selected](../images/quick-backup.png)

The neighbouring **Advanced Backup** sub-tab offers the same operation with more
options exposed (such as choosing a settings profile) in a single form.

## Settings profiles

The **Settings** tab holds reusable **settings profiles** — named bundles of backup
options you can apply to a Quick Backup or a schedule so every backup comes out
consistent. A profile controls things like:

- **Compression** — gzip or zip the archive to save disk space.
- **Table exclusions** — leave volatile tables (for example cache and session
  tables) out of a database dump so backups are smaller and cleaner.
- **File naming** — how the resulting archive is named.
- **Encryption** — encrypt the archive, available only when the optional
  `defuse/php-encryption` library is installed.

Create a profile once and reuse it, rather than re-picking the same options every
time. The **Settings** tab is also where you manage the **sources** and
**destinations** themselves — for example adding a custom server directory as a new
destination, or a second database as a new source.

## Schedules — automated backups

The **Schedules** tab sets up **recurring, unattended backups** that run under
Drupal's **cron**. A schedule ties together three things: a **source** (what to back
up), a **destination** (where to send it), and a **period** (how often — for
example daily or weekly). The module ships with a ready-made **daily schedule** you
can adapt.

Each schedule also keeps a **rolling number of copies**: you tell it how many of
the latest backups to retain, and when a new one is written the oldest is deleted
automatically, so backups never fill the disk indefinitely. A typical setup is a
nightly database backup to the private files directory, keeping the last handful of
copies. Because schedules fire on cron, make sure cron is running on your site (or
call it from your deploy pipeline).

## Saved Backups and Restore

The **Saved Backups** tab lists every backup already stored in a destination. From
here you can **download** an archive, **restore** it, or delete old copies you no
longer need.

To restore, use the **Restore** tab. Restoring reads a backup file back into the
site — either one already listed under Saved Backups, or a file you upload from your
computer — and loads it over the current database or files. This is how you **roll
back** after a bad deployment or content mistake, or **clone** production data down
into a staging or local environment.

> **Restoring overwrites live data.** A database restore replaces the current
> database with the contents of the archive. Take a fresh backup first, and only
> grant the restore permission to trusted users.

## Who can do what

Backup and Migrate gates each action behind its own permission (all are
access-restricted — grant them carefully). You can, for example, let an editor
download backups without letting them restore the site:

- **Perform backup** — take a backup of any available source.
- **Access backup files** — view and download previously created backups.
- **Restore from backup** — restore the site's database from a backup file.
- **Administer backup and migrate** — edit profiles, schedules, sources, and
  destinations.

Set these at **People → Permissions** (`/admin/people/permissions`).
