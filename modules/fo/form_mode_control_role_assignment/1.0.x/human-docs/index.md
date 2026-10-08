# Form Mode Control Role Assignment — manual setup guide

**Form Mode Control Role Assignment** (`form_mode_control_role_assignment`) lets
you automatically grant a chosen role to people who register through a particular
**user form mode**. If your site exposes more than one registration form — say a
general sign‑up and a separate "partner" or "vendor" sign‑up — this module maps
each of those registration form modes to a role, so someone who registers through
the partner form is placed in the partner role without any manual step.

It pairs with the **Form Mode Control** module, which is what exposes the
alternate user‑registration forms in the first place. Each alternate form is
reached by appending a `?display=<form_mode>` query parameter to the registration
URL; this module reads that same parameter, hides the roles checkboxes on the
form, pre‑selects the mapped role, and enforces the grant when the account is
saved.

Map roles that are appropriate for self‑registered users. If a mapped role is
sensitive, keep Drupal's "administrator approval required" registration setting
switched on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Form Mode Control).
2. [Configuration](configuration/index.md) — map each user form mode to a role.

## Where it lives in the admin menu

The mapping form is at **Configuration → People → Form mode role mapping**
(`/admin/config/people/form-mode-role-mapping`), and requires the **Administer
site configuration** permission. See [Configuration](configuration/index.md).
