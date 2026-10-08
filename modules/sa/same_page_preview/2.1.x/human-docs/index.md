# Same Page Preview — manual setup guide

**Same Page Preview** (`same_page_preview`) upgrades Drupal's Preview button so you
can create, edit and preview content **on the same page**. Instead of the standard
preview — which replaces your edit form with a full-page rendering and makes you
press "Back to content editing" to return — Same Page Preview shows the rendered
node in a pane beside the form, so you never lose your place.

The reason this matters is the edit-and-check loop, which is where editorial work
actually happens. For a short node, jumping away to a full-page preview and back is
a mild irritation; for a long page built from paragraphs, that round trip — two page
loads and a scroll to find where you were — is enough friction that people stop
previewing altogether, which is how content ships without anyone having looked at it
rendered. A side-by-side pane removes the round trip.

The module works once enabled — it enhances the existing Preview button, so there is
no settings form to fill in. It has no module dependencies, no submodules and no
third-party libraries.

> **Important compatibility warning — this release does not work on Drupal 11.4.**
> On Drupal 11.4 the module **fatals on load** and cannot be enabled. Core made a
> constructor argument optional in 11.4 and, as a result, its
> `NodePreviewController` now declares the `formBuilder` property as nullable
> (`?FormBuilderInterface`); this module's `PreviewPaneController` extends that class
> but still types the same property as non-nullable (`FormBuilderInterface`), which
> PHP rejects. This was verified on a clean install, where the fatal was bad enough
> that `drush pm:uninstall` itself could not run and the module had to be removed by
> editing `core.extension` directly. The upstream fix is a one-character change, but
> until it lands: **do not enable this version on Drupal 11.4**, and be aware that a
> site already running it will break when you update core to 11.4 rather than at
> install time — the worse order to discover it. On Drupal 10 and pre-11.4 releases
> it works as described.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable (with
   the Drupal 11.4 caveat above).

## How to use it

Once enabled (on a compatible core version), edit any node and press **Preview** as
you normally would. Rather than replacing the form with a full-page preview, the
rendered node appears in a pane beside the form, so you can keep editing fields and
see the effect without leaving the page or losing your form state. The module's
current development focus is on updating that preview as you stop typing and on
accessibility improvements.
