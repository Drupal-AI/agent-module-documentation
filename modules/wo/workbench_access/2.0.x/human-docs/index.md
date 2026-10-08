# Workbench Access — manual setup guide

**Workbench Access** (`workbench_access`) is a hierarchical, editorial access
control module. Instead of giving editors blanket permission to edit *all* content
of a type, it lets you partition content into editorial **sections** — such as
departments, desks, or site areas — and grant each editor rights only within their
own section (and any sections beneath it). A newsroom, for example, can let the
Sports desk edit Sports content while leaving Politics content untouched, all
without creating a separate role for every team.

The sections come from a hierarchy you already have on the site. You define one or
more **access schemes**, each built on either a **taxonomy vocabulary** (terms
become sections) or a **menu** (menu items become sections). Content is then filed
under a section, and editors assigned to that section — individually or by role —
can edit it. Editors assigned to a *parent* section can edit everything in its
child sections too.

One important thing to understand: Workbench Access is **additive and deny-only**.
It only *removes* access from users who are not in the right section; it never
grants edit rights on its own. So an editor still needs a normal Drupal permission
like *Article: Edit any content* **in addition to** section membership. A special
*Bypass workbench access* permission lets trusted super-editors skip all section
checks.

The module works after you configure at least one access scheme. It requires
Drupal core's **Node**, **Taxonomy**, **Options**, **Menu UI**, and **Menu Link
Content** modules, runs on Drupal 9, 10, or 11, and can run stand-alone without the
rest of the Workbench suite. It ships one hidden, test-only submodule
(`workbench_access_hooks`) that you do not normally enable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the `access_scheme` config
entity keys, the plugin type, and the services — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create an access scheme, assign
   editors to sections, and set the permissions.

## Where it lives in the admin menu

Everything is administered at **Configuration → Workflow → Workbench Access**
(`/admin/config/workflow/workbench_access`), where you add and manage access
schemes and the module's settings. The module's permissions are on the People →
Permissions page.

## How to use it

The setup has three parts: (1) create an **access scheme** that turns a vocabulary
or menu into sections, (2) make sure content of the relevant bundles has a field
that references those sections, and (3) assign editors (users or roles) to sections
and give them the normal edit permission they need. The
[Configuration](configuration/index.md) page walks through each part.
