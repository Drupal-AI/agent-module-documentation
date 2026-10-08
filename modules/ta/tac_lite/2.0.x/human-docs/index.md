# Taxonomy Access Control Lite — manual setup guide

**Taxonomy Access Control Lite** (`tac_lite`) controls who may view, edit, or
delete a piece of content based on the **taxonomy terms it is tagged with**,
combined with the user's roles and any per‑user assignments. In plain terms: you
tag nodes with categories (say a *Department* or *Project* vocabulary), then say
"users in this role, or this specific user, may access content tagged with these
terms." Drupal then hides or reveals each node accordingly.

The important thing to understand up front is that tac_lite only ever **grants**
access — it can reveal content, never hide it. So the pattern is always two steps:
first use Drupal's core permissions to lock content down (deny access), then use
tac_lite to selectively open it back up to the right people based on taxonomy. It
does this through Drupal's built‑in node‑access grants system, so it works with
core's access model rather than around it.

You configure it by choosing one or more vocabularies to act as access categories,
then defining up to **seven schemes**. Each scheme grants a chosen set of
operations (view, update, and/or delete) and works in its own access "realm", so
you can, for example, let one role *view* a category while another may *edit* it.
Within a scheme you map roles to terms, and can additionally grant specific terms
to individual users. tac_lite adds one permission (**administer tac_lite**), no
database tables, and depends only on core's **Taxonomy** module. One optional
submodule, **tac_lite_create**, additionally hides taxonomy term options a user
isn't allowed to use on node add/edit forms.

One rule to remember: **after changing any scheme you must rebuild node access
permissions**, or your changes won't take effect on existing content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the `tac_lite_create` submodule.
2. [Configuration](configuration/index.md) — choose access vocabularies, set up
   schemes, assign role and per‑user grants, and rebuild permissions.

## Where it lives in the admin menu

The settings live at **Configuration → People → Access by Taxonomy**
(`/admin/config/people/tac_lite`). Each scheme you define gets its own tab there
(`/admin/config/people/tac_lite/scheme_1`, and so on). Per‑user grants are set on
the **Access by taxonomy** tab of an individual user's account edit page
(`/user/{user}/tac_lite`).

## How to use it

The typical flow is: create a vocabulary of access terms and add it to your
content types, select that vocabulary as an access category, configure one or more
schemes (which operations each grants, and which roles/users get which terms),
then rebuild permissions. See [Configuration](configuration/index.md) for the
step‑by‑step walkthrough.
