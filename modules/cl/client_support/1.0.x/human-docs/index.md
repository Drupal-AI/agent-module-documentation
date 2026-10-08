# Client Support — manual setup guide

**Client Support** (`client_support`) gives the people who use your site a built-in way to reach
support. The base module is deliberately small: when enabled and configured it adds a **Support**
item to the admin toolbar, and clicking it **redirects** the user to whatever support destination
you've chosen. It does not, on its own, show a form or send any email — it's a dispatcher that
hands off to a *support integration plugin*.

You choose which destination is active on the module's settings form. Out of the box the base
module ships **no** integration plugins, so the Support tab stays hidden until either you enable the
companion submodule or a developer adds a custom plugin. The bundled submodule,
**Client Support - Contact Form** (`client_support_contact_form`), is the ready-made option: it
points the Support tab at a core **Contact Form** ("Support Form") that it installs for you,
complete with severity, issue-URL and file-attachment fields. Submissions from that form are
emailed by Drupal core's Contact module to the recipient address you configure on the form.

That combination — base module plus the Contact Form submodule — makes a lightweight support
channel well suited to client portals, membership sites, or any site where editors need a direct
line to whoever maintains it.

> **What the form does and doesn't capture.** Core's Contact form pre-fills a logged-in
> submitter's name and email. The "Issue URLs" field on the Support Form is a normal, required
> field the submitter fills in themselves — the module does **not** automatically record the page
> they were on when they clicked Support.

Two permissions control the base module: **`access client support`** (who can see and use the
Support tab) and **`administer client support`** (who can configure which plugin is active).
Because support requests can contain personal data — names, email addresses, and whatever a
submitter writes or attaches — restrict the administration permission to your actual support staff.
It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module (and the
   Contact Form submodule), and grant the permissions.
2. [Configuration](configuration/index.md) — choose the active plugin and set the recipient email
   address.

## Where it lives in the admin menu

Once enabled and configured, a **Support** tab appears in the admin toolbar for anyone with the
`access client support` permission; clicking it redirects to the configured destination. The
module's own settings live at **Configuration → Client Support** (`/admin/config/client-support`) —
see [Configuration](configuration/index.md).
