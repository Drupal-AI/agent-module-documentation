# AGROVOC Field — manual setup guide

**AGROVOC Field** (`agrovocfield`) helps editors tag content with terms from
**AGROVOC**, the multilingual agricultural thesaurus maintained by the UN's Food
and Agriculture Organization (FAO). As an editor works, the field suggests
matching AGROVOC concepts, so content about agriculture and food can be classified
with standardized, widely recognised terms — which improves classification and
makes your data more interoperable with other agricultural research and data
systems.

The suggestions come from a **self-hosted AGROVOC service** that an administrator
configures — the module calls that endpoint to look up matching concepts. It builds
on core's **Taxonomy** and **Field** modules (the terms you pick become taxonomy
tags) and provides its own permissions.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on these docs:** the available reference material for this module is
> brief. This page explains what it does, how to install it, and that the AGROVOC
> endpoint is administrator-configured; the exact settings screen is not documented
> here. After enabling the module, review its permissions under **People →
> Permissions** and look for its endpoint setting in the admin menu.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Taxonomy and Field.

## How to use it

1. Stand up (or point the module at) a self-hosted AGROVOC service that the module
   can query for concept suggestions.
2. As an administrator, configure the module with that AGROVOC endpoint.
3. Add the AGROVOC field the module provides to a content type (via
   **Manage fields**), pointing it at the taxonomy vocabulary that will hold the
   chosen terms.
4. When editors create content, the field suggests AGROVOC concepts as they type,
   and the selected concepts are stored as taxonomy tags.

Review the permissions the module adds under **People → Permissions** and grant
them to the appropriate roles.
