# Configuration

Alertbox has a central settings form, and the alerts themselves are custom block
content you create and place.

## Open the settings form

1. Log in as a user with the **Administer alertbox** permission.
2. Go to **Structure → Alertbox** (`/admin/structure/alertbox`).

Use this form to configure the alertbox appearance and behavior centrally.

## Create an alertbox

Alerts are built on core custom block content. Create an alertbox block with your
message and, where offered, choose its type from the option-based settings the
module provides.

## Place the alertbox

Place the alertbox block into a theme region using **Structure → Block layout**,
exactly as you would any other block. Because it uses the standard block system,
you can reuse block **visibility** settings (pages, roles, content types) to
control where the alert appears.

## Modal display (optional)

If you enabled the **`alertbox_modal`** submodule, an alert can be shown in a
modal dialog instead of as an inline banner — use it when the announcement should
interrupt the visitor rather than sit quietly in a region.

## Permissions

Alertbox adds a single administrative permission, **Administer alertbox**, on
**People → Permissions** (`/admin/people/permissions`). Grant it only to trusted
roles that should manage alert configuration.
