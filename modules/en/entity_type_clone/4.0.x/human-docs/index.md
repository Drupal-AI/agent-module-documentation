# Entity Type Clone — manual setup guide

**Entity Type Clone** (`entity_type_clone`) gives administrators two simple admin forms for
duplicating things you would otherwise have to rebuild by hand. One form **clones a bundle**
— a content type, vocabulary, block type, paragraph type, profile type or storage type —
together with all of its fields and its form and view displays. The other **clones a user
role** with all of its permissions. It is a real time-saver when you want a new content type
that starts life identical to an existing one, or a "restricted editor" role that is a copy
of "editor" with a couple of permissions removed.

Cloning runs as a Drupal batch: it creates the target bundle, copies every bundle-level
field onto it, and then re-creates each enabled form-mode and view-mode display (including
field-group and other third-party display settings). Role cloning simply creates the new
role and grants it exactly the source role's permission list. Note that it copies
**structure, not content** — no nodes or terms are cloned — and, because displays are copied
by string-replacing the old bundle name, you should review a cloned bundle before exporting
config or creating content in it (the form says as much on screen).

The module adds a **Clone** operation link to the content type, vocabulary, paragraph and
profile listings, is gated by a single permission (**Access Entity Type Clone**), and needs
core's **Block content**, **Node** and **Taxonomy** modules. Paragraph, Profile and Storage
types become clonable when those respective modules are installed. It has no Drush commands
of its own.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   grant the permission.
2. [Configuration](configuration/index.md) — using the bundle-clone and role-clone forms,
   field by field.

## Where it lives in the admin menu

Once enabled, the two forms live at **Configuration → Development → Entity Type Clone**
(`/admin/config/entity-type-clone`) for bundles and `/admin/config/role-clone` for roles;
the two link to each other. You can also start a bundle clone from the **Clone** operation
on the content type, vocabulary, paragraph type or profile type listing pages.
