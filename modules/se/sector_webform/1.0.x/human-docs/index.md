# Sector Webform — manual setup guide

**Sector Webform** (`sector_webform`) is a default-content add-on for the **Sector 10**
distribution. Its job is to bring the powerful **Webform** module onto a Sector site
together with ready-made forms and the roles needed to manage them, so a fresh Sector
build has working webforms out of the box instead of a blank Webform install.

When you enable it, it pulls in the **Webform** module (its dependency) and ships
Sector-compatible roles — **Webform Manager** and **Webform Submission Manager** — so
the right people can build forms and review submissions from day one. The webforms it
provides are ordinary Webform configuration and content; they are governed entirely by
Webform's own access system, and Sector Webform itself plays no access-control role.

There is nothing to configure in this module. Everything it offers appears the moment
it is enabled: the default forms and the two roles are simply there. From that point
on you manage the forms through Webform's normal admin screens, not through any Sector
Webform settings page (it has none).

This guide is written for a **human** installing and enabling the module through
Composer and the admin UI. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module to get the default Sector webforms and roles.

## How to use it

After enabling the module, go to the standard **Webform** administration area
(**Structure → Webforms**, `/admin/structure/webform`) to see and edit the forms it
provided and to review submissions. Assign the **Webform Manager** and **Webform
Submission Manager** roles to the appropriate users under **People → Roles**. All
form building, permissions, and submission handling happen through Webform's own UI.
