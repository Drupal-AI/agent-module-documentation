# Domain Access Webform — manual setup guide

**Domain Access Webform** (`domain_access_webform`) bridges the
[Webform](https://www.drupal.org/project/webform) and
[Domain](https://www.drupal.org/project/domain) (Domain Access) modules, so that
webforms and their submissions belong to domains. On a multi-domain or
multi-brand site — where one Drupal installation serves several hostnames — this
lets each brand's editors work only with their own forms and submissions instead
of seeing everyone's.

Once enabled, it does three things. It lets you **assign one or more domains to
each webform** (on the webform's own settings). It **restricts which webforms a
user can submit**, allowing a submission only when the webform's domains overlap
with the user's allowed domains. And it **scopes the listing and filtering** of
webforms and submissions: it adds a "Domain" column and a domain filter to the
list pages, and constrains what non-privileged users can see to their own
domains.

A key design point worth trusting: the module **only ever restricts, it never
grants**. Its access check can return "forbidden" or stay neutral, but it never
hands out extra access — so it fails safe and composes cleanly with core Webform
access and Domain Access node grants. New submissions are automatically tagged
with the active (negotiated) domain, and a `domain_id` field is added to
submissions for efficient per-domain querying. There is a single escalation path
— the **bypass domain access webform restrictions** permission — which lets
trusted roles ignore the per-domain limits; audit carefully who holds it.

The restrictions rely on the user fields that Domain Access provides
(`field_domain_access` and `field_domain_admin`). If those fields are missing,
non-bypass users resolve to zero allowed domains, so make sure Domain Access is
properly set up first. Anonymous users have no domain fields and are correctly
excluded from restricted submission pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside
   Domain and Webform), enable it, and grant the bypass permission.

There is **no central settings form** for this module. You assign domains
**per webform** on each form's own settings page, and grant the one bypass
permission — both described below.

## Where it lives in the admin menu

The module does not add a settings page of its own. Its controls appear where you
already manage webforms:

- **Per-webform domain assignment:** on each webform at **Structure → Webforms →
  *(your webform)* → Settings → Form**
  (`/admin/structure/webform/manage/[webform]/settings/form`), choose the domains
  the webform is available on.
- **Filtered listings:** the webform list and the submissions list gain a
  **Domain** column and a domain filter.

## How to use it

1. Confirm Domain Access is configured and users have their domain assignments
   set (via the `field_domain_access` / `field_domain_admin` user fields).
2. Edit each webform and, under **Settings → Form**, select the domains it should
   be available on. New webforms are auto-assigned the active domain if you leave
   this unset.
3. Grant **bypass domain access webform restrictions** only to roles that
   legitimately need to see and submit across all domains.
4. Clear caches after changing a webform's domains so the list builders and the
   webform's stored configuration pick up the change.
5. To build domain-scoped submission reports, use the module's Views filter
   plugin (`domain_webform_filter`) in a submissions view.
