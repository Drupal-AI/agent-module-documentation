# Language Field — manual setup guide

**Language Field** (`languagefield`) adds a reusable field type that lets any
entity — a node, user, term, or media item — store one or more languages *as
data*. This is different from core's built‑in content‑language selector: instead
of setting the language a piece of content is translated into, you attach an
ordinary field that records languages as values. Think of the languages a person
speaks on a staff profile, the original language of a document separate from its
translation, or the languages a service is offered in.

The module ships the `language_field` field type together with three widgets — a
select list (`languagefield_select`), a single autocomplete
(`languagefield_autocomplete`), and a tags‑style multi‑value autocomplete
(`languagefield_autocomplete_tags`) — and a formatter (`languagefield_default`)
that renders each stored code as an ISO 639 code, the English name, or the native
name (plus a flag icon when the Language Icons module is present). Which
languages are selectable is controlled per field through the field's storage
settings, so different fields can offer different language sets.

When Drupal doesn't ship a language you need — a constructed language, a regional
dialect, or a minority language — the module lets you register your own with a
**Custom Language** config entity, each with an English label, a native name, a
text direction, and a weight. Custom languages then appear in any field whose
language range includes them. Because language values are stored as plain
language codes, the field also works with Views, Tokens, Feeds, and Tamper.

Enabling Language Field is purely additive: nothing changes until you add a
Language field to a bundle. This guide is written for a **human** setting it up
through the admin UI. If you want terse, token‑cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a Language field to a bundle,
   choose which languages it offers, and register custom languages.

## Where it lives in the admin menu

Language Field has **no global settings page**. You configure it in two places:
on each **Language field** you add to a content type or other bundle (under
*Manage fields*), and on the **Custom languages** admin page at **Configuration
→ Regional and language → Custom languages**
(`/admin/config/regional/custom_language`), which needs the *Administer language
field* permission.

## How to use it

Add a field of type **Language** to the bundle where you want to record
languages, then pick which language set it offers (the site's configured
languages, all predefined ISO languages, your custom languages, and so on),
choose a widget for editors, and choose how stored values display. If you need
languages Drupal doesn't provide, register them on the Custom languages page
first. See [Configuration](configuration/index.md) for the step‑by‑step.
