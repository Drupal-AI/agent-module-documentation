# Selectify — manual setup guide

**Selectify** (`selectify`) transforms plain Drupal select elements — and radio
and checkbox groups — into modern, accessible, customizable components:
searchable dropdowns, tag-style multi-selects, dual-list selectors, and styled
toggles. It reaches across four places at once — Field UI widgets, Views exposed
filters, arbitrary Form API selects, and (through a submodule) Webform — so a site
can present a consistent, enhanced select experience everywhere rather than in
just one corner.

The native `<select>` is fast and accessible, but becomes unusable past roughly
thirty options, which is why almost every site eventually replaces it. The usual
replacements (Select2, Chosen, and the like) are jQuery-era libraries that rebuild
the control out of `div`s and frequently lose the keyboard behaviour and
screen-reader semantics the native element had for free. Selectify's pitch is that
it does not: the project describes itself as **WCAG 2.1 Level AA** compliant, built
with vanilla JavaScript (no jQuery), with five specialized select widgets (regular,
taggable, searchable, checkbox, and dual-list), styled radios and checkboxes, seven
color themes, light and dark modes, and RTL as well as LTR support. Because the
enhancement applies to fields, filters, Form API selects, and Webform, you can keep
the whole site's form controls looking and behaving the same way.

Two things are worth verifying rather than taking on trust, because they are what
every such component tends to get wrong. **Keyboard operation** — type-ahead, arrow
keys, Home and End, Escape to close, Enter to select — should behave exactly as it
does on a native select, since that is what people have learned. And **screen-reader
announcement** — the control needs the right role, the option count and position
announced, and selection changes announced. A claim of AA conformance is a claim
about precisely these behaviours, so test one with a screen reader before relying
on it. The broader principle holds regardless: do not replace a native form control
unless the replacement is measurably better, because the native one is the
accessible baseline everything else is judged against.

Selectify depends on core's **Views** and **Field** modules, and ships one optional
submodule, **Selectify for Webform** (`selectify_webform`), which extends the
enhancement to Webform submission forms.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the Webform submodule.
2. [Configuration](configuration/index.md) — the global settings form and the
   four places you can turn Selectify on.

## Where it lives in the admin menu

Selectify's global settings form lives under **Configuration** (config route
`selectify.settings_form`). Beyond that, you enable specific widgets where forms
are configured — Manage form display, the Views UI, the Form API settings on the
settings form, and Webform.
