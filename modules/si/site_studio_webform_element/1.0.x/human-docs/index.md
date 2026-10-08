# Site Studio Webform Element — manual setup guide

**Site Studio Webform Element** (`site_studio_webform_element`) adds a Webform
picker to the Acquia Site Studio (Cohesion) builder, so a designer can place an
existing Webform inside a component without touching blocks or templates.

Site Studio builds pages from its own vocabulary of elements, and a Webform is
not part of that vocabulary unless something bridges the two. Without this module,
a page built in Site Studio either cannot contain a form, or contains one a
developer hard‑coded into a template — which puts the form outside the builder the
rest of the page lives in. This module is that bridge, and it works the same way
as its sibling `site_studio_views_element`: it re‑exposes a capability the site
already has (Webforms) in the builder's own terms. Webforms are lazily loaded into
the Site Studio render pipeline, which avoids the uncacheable‑page penalties that
normally come with rendering a form inline or to authenticated users.

Because it simply *places* an existing Webform, the form's configuration stays
where it belongs: fields, validation, handlers, confirmation messages and access
settings all remain Webform's, and the placement is Site Studio's. You can move a
form around the page, or swap it out, without editing the form itself.

Two things are worth checking on any form you place. First, **the form's own
access settings still apply** — a form restricted to authenticated users, placed
on a public page, renders as nothing at all (an empty region, not an error), which
is why this sometimes gets reported as "the form disappeared." Second, **a form on
a public page will be found by bots**, so make sure the site's CAPTCHA or Honeypot
protection covers it.

It works on enable with **no settings form and no permissions of its own**. It
depends on the `cohesion` (Acquia Site Studio) module and `webform`. Site Studio
is Acquia's commercial product, so this module has nothing to do on any site that
does not run that stack.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Make sure both Acquia Site Studio and the Webform module are enabled.
2. Create (or edit) a Site Studio Component.
3. Add a **Webform element** to the Layout Canvas.
4. Set its value to any available Webform.

**Dynamically selecting a Webform (optional).** You can add a Select field to the
component's form builder to supply a token‑based value, letting an author choose
from any available Webform per placement. As the Select field's options source you
can either point an "external data source" at the path
`/api/cohesion/webform-list` (requires Site Studio 7.5.0 or higher), or use
"Options from a custom function" with the function name
`siteStudioWebformElementList`, then reference that field's token on the Webform
element. Note that the option list includes **all** Webforms, even ones not in an
"Open" state, so choose carefully.
