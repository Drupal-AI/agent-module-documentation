# Configuration

BrightEdge Autopilot is configured on its admin form (**`brightedge.admin_form`**),
at **Configuration → Web services → BrightEdge**
(`/admin/config/services/brightedge`).

## Who can open the settings form

The route is guarded by a permission named `administer`, which does **not** exist
as a real Drupal permission. Because Drupal treats an undefined permission as one
nobody can be granted, the form ends up reachable only by roles flagged as full
administrators — and cannot be delegated to, say, an SEO-manager role. This is a
quirk of the module rather than something you configure; just be aware that only
full admins can reach this page.

## Connect the site to BrightEdge

On the form, enter the BrightEdge **account and connector settings** you were
given for your IXF-enabled account. Supply the credential from the environment
variable you set during [installation](../installation/index.md) rather than
pasting a secret directly into committed configuration. Saving connects the site
to your BrightEdge account so it can fetch managed content ("capsules") at render
time.

## Place capsules on pages

BrightEdge content is placed using the module's **IXF Content Block**. Add it
through **Structure → Block layout** or a **Layout Builder** section on the pages
that should carry managed content. Because it is a normal block, its visibility
conditions (which pages, which content types, which roles) apply, so you control
where capsules appear.

## Before you rely on it — two checks

- **Timeout / failure behaviour.** Content is fetched server-side while the page
  renders, so a slow or unreachable BrightEdge means a slow page. Confirm the
  SDK's timeout and that an outage degrades gracefully before placing a capsule on
  a high-traffic template.
- **Who can publish.** Anything published as a capsule in your BrightEdge account
  renders under your domain without a Drupal review step. Make sure the
  publishing controls on the BrightEdge side are locked down to trusted people —
  that account is now part of your site's trust boundary.

## Verify

After connecting and placing a block, load a page that should carry a capsule and
confirm the managed content appears, then check the page still renders promptly.
