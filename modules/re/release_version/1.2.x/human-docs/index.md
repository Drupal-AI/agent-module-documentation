# Release Version — manual setup guide

**Release Version** (`release_version`) is a small operations utility that shows
your site's **current release version right in the admin toolbar**. At a glance,
an operator can confirm that a deploy actually landed, and support staff can tell
which version a site is running when triaging an issue — no digging through files
or asking "which build are you on?"

The module reads the value it displays from a **configurable environment
variable**. That means your deploy pipeline sets the version (for example a Git
tag or build number) into an environment variable, and Release Version surfaces
whatever is there in the toolbar. It depends on core's **Toolbar** module and
runs on Drupal 8.8 through 11. (The maintainers plan a future plugin-based system
so the version could also come from Git information or a text file, but today the
source is an environment variable.)

One security note worth keeping in mind: a version string is minor
reconnaissance if it leaks to untrusted users, because it can help someone pick an
exploit. The toolbar is admin-facing, so keep the display to **authenticated
staff** — do not surface the version to anonymous visitors — and avoid putting
sensitive build detail into the version string.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no dedicated settings page** for the everyday case — the version comes
from an environment variable and the display appears in the toolbar. Setup is
described in "How to use it" below.

## How to use it

1. Have your hosting or deploy process set an **environment variable** to the
   version string you want to show (for example your Git tag or build ID). In
   DDEV you can set an environment variable with
   `ddev dotenv set .ddev/.env --release-version=<value>` (which becomes
   `RELEASE_VERSION`) and then `ddev restart`.
2. Point the module at that variable name (the module reads the value from a
   configurable environment variable — match it to the one your pipeline sets).
3. Grant the module's administration permission at **People → Permissions**
   (`/admin/people/permissions`) to the trusted roles that should manage or see
   the version, keeping it to authenticated staff.

Once configured, log in as a staff user and the current version appears in the
admin toolbar. Because the toolbar is only shown to users who can access it, the
version stays with your team rather than anonymous visitors.
