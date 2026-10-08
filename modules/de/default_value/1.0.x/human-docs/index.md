# Default Value — manual setup guide

**Default Value** (`default_value`) supplies a default value for fields on
*existing* entities at the moment they are loaded. When an entity that predates a
field — or simply has that field empty — is loaded, the field presents a
configured default instead of appearing blank.

This solves a familiar problem: you add a new field to a content type that
already has hundreds of nodes, and every one of those older nodes shows the field
empty. Rather than re‑saving each entity to populate it, Default Value lets you
declare a fallback that is applied on load, so existing content shows a sensible
value straight away. It is a content / fields feature and lives in the **Fields**
package.

Two things are worth understanding up front. First, the default is applied **at
load time** as a runtime fallback — it is *not* persisted to storage unless the
entity is subsequently saved. Second, it affects the loaded *value* only; it does
**not** change access control or permissions in any way. You configure which
fields get a default, and what that default is, on the module's settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the supported entities and
   set the per‑field default values.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Default Value Settings**
(config route `default_value.config`). That is where you pick the entities and
fields that should receive a load‑time default.
