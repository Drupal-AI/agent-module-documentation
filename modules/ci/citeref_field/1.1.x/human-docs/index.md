# Citation Reference Field — manual setup guide

**Citation Reference Field** (`citeref_field`) — "Citeref" for short — provides
Drupal field types for storing citation and reference records. A record can be
identified through a DOI, Handle, or ARK registry, or specified via a URL, URN, or
other method, making it well suited to academic, library, and research sites that
publish content such as publications, articles, or applications.

The module actually stores several related pieces per reference: the **citation
type** (DOI, Handle, ARK, URL, URN, or other), a **citation style name**, the
**citation identifier**, and the **formatted citation text**. Its form widget can
validate the identifier the user enters, and for DOIs it uses the DOI content
negotiation service to fetch a formatted citation — with a citation style chosen
from the CSL style repository. Display and form formatters let you customise how
the reference and its identifier are shown.

There is no central settings page. You use the module by adding one or more Citeref
fields to a content type (or other entity) and configuring their widget and
display like any other field. Administration of the module is gated by the
**Administer citeref_field** permission; it has no front-end access-control role and
escapes rendered output normally. This is a beta, minimally maintained release not
covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Citeref adds no configuration page. You work with it entirely through the Field UI:
**Structure → Content types → *(your type)* → Manage fields**, where you add a
Citeref field, and the matching **Manage form display** / **Manage display** tabs,
where you set its widget and formatter.

## How to use it

1. Go to **Structure → Content types**, pick the content type that should carry a
   reference (for example *Publication*), and open **Manage fields**.
2. **Add field**, choose one of the Citeref citation/reference field types, and
   give it a label such as "Reference".
3. On **Manage form display**, the field's widget lets editors enter the citation
   type and identifier; for DOIs it can validate and fetch a formatted citation,
   with a style selected by name from the CSL repository.
4. On **Manage display**, choose the formatter to control how the citation and its
   identifier appear on the rendered page.

> **Uninstalling:** the module includes an uninstall step that removes its
> dependent fields (currently handled for `node` and field-storage types), so plan
> removals with that in mind.
