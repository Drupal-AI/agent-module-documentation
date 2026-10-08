# ECA Content Access — manual setup guide

**ECA Content Access** (`eca_content_access`) bridges two modules: the
[Content Access](https://www.drupal.org/project/content_access) module, which
provides per-content-type and per-node access grants, and
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action), Drupal's
no-code automation framework. With the bridge in place, the access grants Content
Access manages can be set or adjusted by ECA models that react to events on your
site — for example, opening up a node to a role when it is published, or tightening
access when a workflow state changes.

Because this module drives **access control** through automation, it deserves
careful handling. The correctness of the access rules you build is exactly the
correctness of the ECA models you build with it: an access rule expressed as an
ECA model is only as safe as that model, and a mistake can grant or deny access to
the wrong people. Treat building these models as a trusted, security-sensitive
activity — restrict who is allowed to author ECA models, test the resulting grants
against adversarial cases (does a user who should *not* have access get in?), and
rebuild node access permissions (`drush php:eval` / the node access rebuild) when
your grant logic changes so the grants tables reflect the new rules.

The module has no settings form of its own. It contributes events, conditions, and
actions that you use inside the ECA modeller. It depends on both ECA (`^2 || ^3`)
and Content Access (`^2`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA and Content Access.

There is **no configuration page** for this module — it has no settings form. Its
access-automation logic is built inside the ECA modeller, described in "How to use
it" below.

## Where it lives in the admin menu

ECA Content Access adds no admin page of its own. You build models in the ECA
modeller at **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`), and
the per-type default access settings live on the Content Access side under each
content type's **Access control** tab and (with the module's own settings) at
**Configuration → People → Content Access**.

## How to use it

1. Configure the baseline grants in **Content Access** first (per content type,
   and optionally per node) so you know the starting state.
2. In the ECA modeller at **Configuration → Workflow → ECA**, build a model that
   listens for the event you care about (for example a node being published).
3. Use the actions this module provides to set or change the Content Access grants
   for the entity in context.
4. **Test adversarially.** Log in (or use a test user) as each role that should
   and should not have access, and confirm the grants behave as intended. Rebuild
   node access if your logic changed the grant rules.

Keep authoring of these models restricted to trusted administrators — an ECA model
that changes access is a security-sensitive artifact.
