# Template Whisperer — manual setup guide

**Template Whisperer** (`template_whisperer`) gives editors a simple way to
choose which page template a piece of content should use, and turns that choice
into a Twig theme suggestion your theme can implement. Instead of hard‑coding
node IDs into your theme or bending taxonomy terms into a proxy for "which
layout," an editor picks a named suggestion from a field and the theme can then
provide a matching `node--<suggestion>.html.twig` file.

The recurring need it solves is that one content type often needs several
presentations — a standard article, a long‑read, a photo essay, a news‑listing
page — and that choice really belongs to the editor rather than to a URL pattern.
Drupal's built‑in mechanism for alternative rendering is the *theme suggestion*,
and the usual way to drive one from content is a bespoke
`hook_theme_suggestions_node_alter()` written once per project and undocumented
for whoever comes next. Template Whisperer formalises that: the available
suggestions are declared as configuration entities you manage in the admin UI,
editors pick one from a field, and the set of templates becomes a listable,
exportable thing rather than a convention hidden in the theme's file names.

The module does **not** work entirely on‑enable — you get value from it only
after you create at least one suggestion and attach the Template Whisperer field
to a content type. It depends on core **Field** and **Views**, ships no
submodules, and requires **Drupal 11.1 or newer** (`^11.1 || ^12`), which is a
tight requirement — it will not install on Drupal 10. It also integrates with
Pathauto tokens so URL patterns can be driven by a content's chosen suggestion.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the requirements.

## Where it lives in the admin menu

Template Whisperer does not add a global settings form. Its management interface
sits under **Structure → Template Whisperer**
(`/admin/structure/template-whisperer`), where you create and manage the
suggestion entities.

## How to use it

The workflow, once the module is enabled, is:

1. Go to **Structure → Template Whisperer**
   (`/admin/structure/template-whisperer`) and click **Add Template Whisperer**
   to create a suggestion — for example a "News list" suggestion.
2. Attach the **Template Whisperer** field to the content type (or other
   fieldable entity) you want to control. On the bundle's **Manage fields** page,
   choose *Template Whisperer* from the "Add a new field" selector, give it a
   label and machine name, and save. If your site is multilingual and the entity
   is translatable, tick "Users may translate this field."
3. When editing content of that type, an editor selects a suggestion from the new
   **Template Whisperer** section on the *Advanced* tab of the edit form.
4. In your theme, add the corresponding Twig file — for example
   `node--article--news-list.html.twig` — to control how that content renders.

Two things are worth keeping in mind. **A missing template fails silently:** if a
suggestion has no matching Twig file, the content simply falls back to the
default template, so the editor's choice appears to do nothing — the commonest
support question this pattern raises. Keep your declared suggestions and your
theme's files in step, and re‑check after any theme change. And **a template
choice is content:** it exports with the node and travels with a migration, so
decide what should happen if a suggestion is removed while content still
references it.

Two permissions control access: *administer template whisperer suggestion
entities* (manage the suggestions) and *administer the template whisperer field*
(see and edit the field on content).
