# InforMEA API — manual setup guide

**InforMEA API** (`informea_api`) provides the tools to expose your Drupal content
over **REST** in the exact format the [InforMEA](https://www.informea.org/) project
expects. InforMEA is the United Nations knowledge hub for multilateral
environmental agreements, and this module is the bridge a content-providing site
uses to publish into that platform.

Rather than a point-and-click feature, it is a set of building blocks for a
**decoupled/integration** workflow. It ships a Views **"InforMEA serializer"**
format plugin and a matching set of **serializable field plugins**. You create a
View for each content type you want to expose, give it the InforMEA serializer
format, add the *serializable* versions of your fields (for example *Title
(serializable)*), and the View becomes a REST endpoint delivering data in
InforMEA's shape.

Because the output is served through REST — bypassing the usual page-level UI —
be deliberate about what you publish. Make sure each exposed View and its fields
only surface content that is meant to be **public**, and rely on Drupal's resource
and entity access controls so unpublished or restricted data never leaks through
an endpoint. The module has no access-control mechanism of its own; you secure the
endpoints with core's REST and permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with core REST).

There is **no dedicated settings page** for this module. All setup happens by
building Views with the InforMEA serializer format — see "How to use it" below,
and the project's
[module documentation](https://www.informea.org/en/about/api) for the InforMEA
format details.

## Where it lives in the admin menu

InforMEA API adds no configuration page of its own. You work with it entirely from
**Structure → Views** (`/admin/structure/views`), where you build the REST
endpoints, and (as needed) from the REST/permissions configuration that governs
who may reach them.

## How to use it

1. Enable the module and core REST (see [Installation](installation/index.md)).
2. Go to **Structure → Views** and create a new View for a content type you want
   to expose to InforMEA.
3. Add a **REST export** display (or otherwise set the display's format) and
   choose the **InforMEA serializer** format plugin.
4. Add fields to the View using the **serializable** versions of each field (for
   example *Title (serializable)*), so the output matches InforMEA's expected
   structure.
5. Set the endpoint path, save, and confirm the REST output. Repeat for each
   content type InforMEA should receive.
6. Review who can access the endpoint via core REST settings and permissions, and
   make sure only public content is exposed.
