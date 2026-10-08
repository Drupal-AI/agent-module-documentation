# CiviCRM Afform Block — manual setup guide

**CiviCRM Afform Block** (`civicrm_afform_block`) is a lightweight bridge that lets
you place a CiviCRM **Afform** — a form built with CiviCRM's Form Builder
extension — anywhere Drupal blocks can go. It provides a single block plugin,
"CiviCRM Afform Block", that renders a chosen Afform (a form, a SearchKit search
display, or a system directive) inside a Drupal region or a Layout Builder layout.

The problem it solves is surfacing CiviCRM forms on the front end without
shortcodes or hand-written embed code. You place the block, pick the form from a
drop-down, and the module loads CiviCRM's Angular resources and renders the
directive. Because the block keeps the Afform as a live reference, the form's own
CiviCRM permissions, fields, and behaviour apply when it is displayed.

To use it you need a working **CiviCRM** installation with the Form Builder (Afform)
extension, plus Drupal's core **Block** module. It is best paired with CiviCRM's own
permission model: Drupal governs where the block appears (via normal block
visibility and roles), while CiviCRM enforces who may actually submit the embedded
form. Typical uses are donation, event, sign-up, or SearchKit displays placed on
marketing or landing pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (CiviCRM must be installed first).

## Where it lives in the admin menu

The module adds no settings page of its own. You use it entirely through **Structure
→ Block layout** (or Layout Builder), where you place the **CiviCRM Afform Block**
and choose which Afform it renders. Placing and configuring blocks requires the
standard **Administer blocks** permission.

## How to use it

1. Make sure CiviCRM is installed and working, with the Form Builder (Afform)
   extension available so you have forms to embed.
2. Go to **Structure → Block layout** and click **Place block** in the region you
   want (or add the block through Layout Builder).
3. Choose **CiviCRM Afform Block** from the list of available blocks.
4. In the block's configuration, pick the form from the **CiviCRM Form Name**
   drop-down. The list is pulled live from CiviCRM and includes Afforms of type
   *form*, *search*, or *system*; labels use each Afform's title, falling back to
   its machine name.
5. Save. The selected Afform now renders wherever you placed the block. You can
   place multiple instances with different forms, and reuse the same form in more
   than one place.

> **Tip:** control who can *submit* the form through CiviCRM's own permissions, and
> use Drupal's block visibility settings to control *where* the form appears.
