# LocalGov Forms — manual setup guide

**LocalGov Forms** (`localgov_forms`) provides additional configuration, styling and
components for the Drupal [Webform](https://www.drupal.org/project/webform) module,
tuned for the LocalGov Drupal distribution and GOV.UK-style government-service forms.
It does not replace Webform — it layers sensible defaults, accessible components and
extra building blocks on top of it, so council editors can build good forms without
starting from scratch.

Out of the box (on first install) it adjusts Webform's default settings to be more
appropriate for public-sector forms. Specifically it: enables Ajax by default (forms
can override this individually), enables submit-once to prevent double button presses
on slow connections, disables the browser back button during submission, warns about
unsaved changes, enables the submission log, sets plain-English confirmation-message
defaults, removes chevrons from wizard/preview button labels, and hides a range of
rarely-used Webform elements so the editor UI is easier to navigate.

> **Preserving existing Webform settings:** if you already run Webform and want to
> keep your current configuration, add `$settings['localgov_forms_skip_webform_config'] = TRUE;`
> to `settings.php` *before* installing this module. You can remove that line
> afterwards.

Alongside the defaults it ships extra components and submodules — an accessible date
field based on the GDS Date Input pattern, a decision-tree helper, a feedback form, a
configurable address-lookup element (which needs a Geocoder provider — UK councils
typically use the free OS Places geocoder via LocalGov Geo), and a PII (personally
identifiable information) redactor plugin for cleaning submissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its dependencies, and choose the submodules you need.

There is **no single settings page** for LocalGov Forms itself. It works by adjusting
Webform's own configuration and adding components you use from the Webform UI, so its
configuration lives under Webform (**Structure → Webforms**) rather than a dedicated
LocalGov page.

## Where it lives in the admin menu

LocalGov Forms adds no admin settings page of its own (`configure` is `null`). You
build and manage forms through Webform's own UI at **Structure → Webforms**
(`/admin/structure/webform`). The extra components (date, address lookup, and so on)
appear in the element picker when you add elements to a webform.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Go to **Structure → Webforms** and create or edit a webform. You will find the
   LocalGov defaults already applied and the extra elements available in the element
   list.
3. To use the **address lookup** element, first configure a Geocoder provider. UK
   councils typically install LocalGov Geo and the OS Places Geocoder provider, after
   which the *LocalGov OS Places* backend becomes selectable on the element's
   configuration form.
4. Because webforms are configuration entities, they are normally exported with your
   site configuration. If non-developers will build and maintain forms directly on a
   live site, consider installing **Config Ignore** and ignoring `webform.webform.*`
   and `webform.webform_options.*` so deployments do not overwrite editor-built forms.

Feedback and service forms collect submissions that may contain personal data, so
apply the usual safeguards — spam protection, a submission-retention policy, and
restricting who can view submissions.
