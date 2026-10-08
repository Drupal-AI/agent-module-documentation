# Configuration

This page covers the **base** module's configuration: the compliance checklist, the
Content links form, and the per‑user data page. Each submodule (fields, consent,
tasks, anonymizer, dump) has its own settings — configure those after enabling them.

## The compliance checklist

The checklist is the module's main configure page and your starting point.

1. Log in as an administrator (the checklist and the `/admin/config/gdpr` section
   use core's **Administer site configuration** permission).
2. Go to **Configuration → GDPR → Checklist**, or navigate directly to
   `/admin/config/gdpr/checklist`.

The checklist walks you through grouped items:

- **Getting Started** — acknowledge that the module does not transfer legal
  responsibility to you, and read the recommended material.
- **Policies** — confirm your cookie policy.
- **Content related suggestions** — confirm a Privacy Policy page exists, is
  published, and is linked in a menu.
- **Site feature related suggestions** — review tracking tools, social‑media
  integrations, modules that collect data, and role permissions.
- **Configuration** — enable account cancellation and data removal.
- **Beyond website management** — consult a legal adviser, enable the GDPR
  submodules, and set up breach‑notification and logging responsibilities.

Tick items off as you address them. Progress is saved by the Checklist API, and the
completion percentage appears on the site's **Status Report**, so you can use it as a
lightweight compliance indicator. The checklist also shows which recommended,
tracking, and social modules are currently enabled versus missing.

## Content links

The checklist needs to know where your key legal pages live. Record them here:

1. Go to **Configuration → GDPR → Content links**, or navigate directly to
   `/admin/config/gdpr/content-links`.
2. Enter the URL for each of the four standard pages — **Privacy policy**, **Terms
   of use**, **About us**, and **Impressum** — for **each language** on your site.

You can enter an internal path (for example `/privacy-policy`) or a full external URL
(for example a hosted PDF). These values are stored in the `gdpr.content_mapping`
configuration and read by the checklist to show whether each page is configured. On
multilingual sites, fill in every language so each is covered.

## The "All your data" user page

Each user profile gains an **All your data** tab at `/user/{user}/gdpr`. It's the
single entry point where a person can reach the data you hold about them. What it
shows depends on which submodules are enabled:

- With **GDPR Tasks** enabled, it takes the user to their data requests.
- With only **GDPR Consent** enabled, it takes them to their consent agreements.
- With neither enabled, it's just a placeholder.

## Permissions

The base module defines two permissions (grant them at **People → Permissions**):

| Permission | Controls |
|-----------|----------|
| **View gdpr data summary** | Required to see the "All your data" page at all. A holder can view *their own* page; without it, the page is forbidden (so you can disable it entirely by not granting it). |
| **Administer gdpr settings** | Lets a holder view *any* user's "All your data" page — intended for staff/compliance officers. A restricted permission. |

Note that the checklist and Content links form themselves are gated by core's
**Administer site configuration** permission, not by these two. The submodules add
their own permissions (for managing consent agreements, viewing/editing GDPR fields,
creating and administering tasks, and so on) — see each submodule's documentation.
