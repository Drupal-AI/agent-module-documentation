# Content Type Webform Creation — manual setup guide

**Content Type Webform Creation** (`content_type_webform_creation`) removes the
tedious duplication of rebuilding a form that mirrors a content type you already
have. Normally, turning an "Event" content type into an event‑submission form
means opening **Structure → Webforms**, adding a new webform, and re‑creating
every element by hand — the same labels, the same required flags, the same
taxonomy and media references, all typed in again. This module does it for you:
pick a content type, choose which of its fields to include, and it generates a
ready‑to‑use Webform in a single flow.

The field‑to‑element mapping is **deterministic** — it is based entirely on your
site's existing field configuration, and (unlike some generators) it calls out to
**no AI service**, so the same content type always produces the same result. Text
fields become textfields or textareas, booleans become checkboxes, list fields
become select dropdowns, entity references become selects or entity
autocompletes, media and file fields become file uploads with matching
extensions, dates become datetime pickers, and links become URL fields.
**Required** fields on the content type stay required on the generated form. Only
configurable node‑bundle fields are considered; base fields and deleted fields
are skipped.

It can also **update a webform it previously generated**: pick it from a dropdown
instead of retyping a machine name, and the elements already present are
pre‑selected so nothing is silently dropped. Before anything is written, a
**preview** shows a summary table (field, mapped element, required) plus a live,
read‑only rendering of the generated elements — nothing is created or changed
until you confirm.

The module depends on the **Webform** module (a hard dependency — it generates
and updates Webform entities directly), runs on Drupal 10.3 and 11, and is
actively maintained (maintenance fixes only). The generator and its steps are
gated by core's **Administer site configuration** permission; it has no anonymous
or public endpoints. It is ideal for teams who model content carefully and want a
matching intake, feedback, or request form without rebuilding those fields a
second time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make sure Webform is present.

The module is driven by a generation **wizard** rather than a persistent settings
form, so the steps are described here in "How to use it" rather than in a
separate Configuration page.

## Where it lives in the admin menu

The generator sits at **Configuration → Content → Webform Generator**
(`/admin/config/content/webform-generator`). Every step requires the
**Administer site configuration** permission, so grant that to whichever roles
should be able to generate or update webforms.

## How to use it

1. Go to **Configuration → Content → Webform Generator**
   (`/admin/config/content/webform-generator`).
2. **Choose a content type.** Then either enter a **title** for a brand‑new
   webform — the machine name (id) is suggested automatically from the title and
   stays locked behind an *Edit* link until you choose to override it, the same
   UX core uses for content types and views — or tick **Update an existing
   webform** and pick one from the dropdown to rebuild it in place (its id and
   current elements are reused rather than duplicated).
3. **Select which fields to include.** When updating, fields already present in
   the target webform are checked automatically, so you never accidentally drop
   existing elements.
4. **Review the preview.** A summary table shows each field, the element it maps
   to, and whether it stays required, alongside a live read‑only rendering of the
   generated elements. Nothing is written until you confirm.
5. **Confirm to generate.** You are redirected to the generated (or updated)
   webform's **Edit** page, where you can refine it in the normal Webform build
   UI.

> **Tip:** Some content‑type field types only map to a meaningful Webform element
> when their owning core module is enabled (for example media or link fields). If
> a field you expected is missing from the mapping, check that the module
> providing that field type is enabled.
